$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$prevErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

Function Get-UserInput {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory = $true)]
    [string]$Message,
    [string]$DefaultValue = $null
  )

  $ValidInput = $false
  while (-not $ValidInput) {
    $UserInput = Read-Host -Prompt "$Message"
    if ($UserInput -ne "") {
      $ValidInput = $true
      return $UserInput
    }
    else {
      if ($DefaultValue -ne $null) {
        $ValidInput = $true
        return $DefaultValue
      }
      else {
        Write-Host "Please enter a value."
      }
    }
  }
}

Function Get-YesNoInput {
  [CmdletBinding()]
  Param(
    [Parameter(Mandatory = $true)]
    [string]$Message,
    [Nullable[bool]]$DefaultValue = $null
  )

  $ValidInput = $false
  while (-not $ValidInput) {
    $Prompt = "$Message "
    if ($DefaultValue -eq $true) {
      $Prompt += "[Y/n]"
    }
    elseif ($DefaultValue -eq $false) {
      $Prompt += "[y/N]"
    }
    else {
      $Prompt += "[y/n]"
    }

    $UserInput = Read-Host -Prompt $Prompt
    if ($UserInput -eq 'y') {
      $ValidInput = $true
      return $true
    }
    elseif ($UserInput -eq 'n') {
      $ValidInput = $true
      return $false
    }
    elseif ($UserInput -eq "" -and $DefaultValue -ne $null) {
      $ValidInput = $true
      return $DefaultValue
    }
    else {
      Write-Host "Please enter y or n."
    }
  }
}

# Get setup options
# Project information
$currentDirectory = Get-Location
$projectDefaultName = $currentDirectory | Split-Path -Leaf

$projectName = Get-UserInput -Message "Project name (Default: $projectDefaultName)" -DefaultValue $projectDefaultName
$projectOrganization = Get-UserInput -Message "Project organization (Default: book000)" -DefaultValue "book000"
$projectRepository = Get-UserInput -Message "Project repository (Default: $projectOrganization/$projectName)" -DefaultValue "$projectOrganization/$projectName"
$projectHomepage = Get-UserInput -Message "Project homepage (Default: https://github.com/$projectRepository)" -DefaultValue "https://github.com/$projectRepository"
$projectDescription = Get-UserInput -Message "Project description" -DefaultValue ""
$projectAuthorName = Get-UserInput -Message "Project author name (Default: Tomachi <tomachi@tomacheese.com>)" -DefaultValue "Tomachi <tomachi@tomacheese.com>"
$projectLicense = Get-UserInput -Message "Project license (Default: MIT)" -DefaultValue "MIT"
$projectBugUrl = Get-UserInput -Message "Project bug URL (Default: $projectHomepage/issues)" -DefaultValue "$projectHomepage/issues"
$projectRepositoryUrl = Get-UserInput -Message "Project repository URL (Default: git@github.com:$projectRepository.git)" -DefaultValue "git@github.com:$projectRepository.git"

# Generate options
$ifTest = Get-YesNoInput -Message "Do you want to add a test?"
$ifConfigSchema = Get-YesNoInput -Message "Do you want to add a config schema generator?" -DefaultValue $true
if ($ifConfigSchema) {
  $tsConfigInterfacePath = Get-UserInput -Message "TypeScript Config interface file path (Default: src/config.ts)" -DefaultValue "src/config.ts"
}
$ifIgnoreDataDirectory = Get-YesNoInput -Message "Do you want to ignore the data directory?" -DefaultValue $true
$ifAddReviewer = Get-YesNoInput -Message "Do you want to automatically add reviewers to pull requests workflow?" -DefaultValue $true
$ifDockerfile = Get-YesNoInput -Message "Do you want to Dockerfile?" -DefaultValue $true

Write-Output ""

Write-Output "Creating project.."

# Get pnpm version
$pnpmVersion = pnpm -v
$pnpmVersion = $pnpmVersion.Replace("\r", "").Replace("\n", "").Replace("`u{feff}", "")
$packageManager = "pnpm@$pnpmVersion"

# Create package.json
$packageJson = @{
  name           = $projectName
  version        = "0.0.0"
  description    = $projectDescription
  homepage       = $projectHomepage
  bugs           = @{
    url = $projectBugUrl
  }
  repository     = @{
    type = "git"
    url  = $projectRepositoryUrl
  }
  license        = $projectLicense
  author         = $projectAuthorName
  private        = $true
  main           = "dist/main.js"
  scripts        = @{
    preinstall      = "npx only-allow pnpm"
    start           = "tsx ./src/main.ts"
    dev             = "tsx watch ./src/main.ts"
    lint            = "run-z lint:prettier,lint:eslint,lint:tsc"
    "lint:prettier" = "prettier --check src"
    "lint:eslint"   = "eslint . -c eslint.config.mjs"
    "lint:tsc"      = "tsc"
    fix             = "run-z fix:prettier fix:eslint"
    "fix:eslint"    = "eslint . -c eslint.config.mjs --fix"
    "fix:prettier"  = "prettier --write src"
  }
  packageManager = $packageManager
}

$packageJson | ConvertTo-Json -Depth 100 | Out-File -FilePath package.json -Encoding utf8 -Force
Write-Output "Created package.json"

# Create .depcheckrc.json
$depcheckrcJson = @{
  "ignores" = @(
    "@types/node",
    "run-z",
    "eslint-config-standard",
    "eslint-plugin-import",
    "eslint-plugin-n",
    "eslint-plugin-promise"
  )
}

$depcheckrcJson | ConvertTo-Json -Depth 100 | Out-File -FilePath .depcheckrc.json -Encoding utf8 -Force
Write-Output "Created .depcheckrc.json"

# Create .node-version
$nodeVersion = node -v
$nodeVersion = $nodeVersion.Replace("v", "").Replace("\r", "").Replace("\n", "").Replace("`u{feff}", "")
New-Item -Force .node-version -ItemType File -Value $nodeVersion
Write-Output "Created .node-version"

# Create .gitignore
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore" -OutFile ".gitignore"
Add-Content -Path ".gitignore" -Value "`n# pnpm`n.pnpm-store"
Write-Output "Created .gitignore"

if ($ifIgnoreDataDirectory) {
  Add-Content -Path .gitignore -Value "data/"
  Write-Output "Added data/ to .gitignore"
}

# Create LICENSE
if ($projectLicense -eq "MIT") {
  # Get MIT license from GitHub API
  Invoke-WebRequest -Uri "https://api.github.com/licenses/mit" | ConvertFrom-Json | Select-Object -ExpandProperty body | Out-File -FilePath LICENSE -Encoding utf8 -Force -NoNewline

  # Replace [year] with current year
    (Get-Content -Path LICENSE -Raw) -replace "\[year\]", (Get-Date).Year | Set-Content -Path LICENSE -Encoding utf8 -Force -NoNewline

  # Replace [fullname] with author name
  # "Tomachi" -> "Tomachi"
  # "Tomachi <tomachi@tomacheese.com>" -> "Tomachi"
  $projectAuthorNameWithoutEmail = $projectAuthorName -replace "<.*>", ""
  $projectAuthorNameWithoutEmail = $projectAuthorNameWithoutEmail.Trim()
    (Get-Content -Path LICENSE -Raw) -replace "\[fullname\]", $projectAuthorNameWithoutEmail | Set-Content -Path LICENSE -Encoding utf8 -Force -NoNewline

  Write-Output "Created LICENSE"
}

# Create .github/workflows/nodejs-ci-pnpm.yml
New-Item -Force .github/workflows/ -ItemType Directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/templates/master/workflows/nodejs-ci-pnpm.yml" -OutFile ".github/workflows/nodejs-ci-pnpm.yml"
Write-Output "Created .github/workflows/nodejs-ci-pnpm.yml"

# If test is true, install packages
if ($ifTest) {
  # add package.json
  $packageJson.scripts.test = "jest --runInBand --passWithNoTests --detectOpenHandles --forceExit"

  $packageJson.jest = @{
    moduleFileExtensions = @("js", "ts")
    transform            = @{
      "^.+\.ts$" = @(
        "ts-jest",
        @{
          tsconfig = "tsconfig.json"
        }
      )
    }
    testMatch            = @(
      "**/*.test.ts"
    )
    setupFilesAfterEnv   = @(
      "jest-expect-message"
    )
  }

  $packageJson | ConvertTo-Json -Depth 100 | Out-File -FilePath package.json -Encoding utf8 -Force
  Write-Output "Updated package.json"

  $depcheckrcJson.ignores += @(
    "@types/jest"
  )

  $depcheckrcJson | ConvertTo-Json -Depth 100 | Out-File -FilePath .depcheckrc.json -Encoding utf8 -Force
  Write-Output "Updated .depcheckrc.json"

  pnpm add -D -E jest ts-jest @types/jest jest-expect-message
}

# Install packages
pnpm add -D -E typescript @types/node tsx prettier eslint eslint-config-standard eslint-plugin-import eslint-plugin-n eslint-plugin-promise run-z @book000/node-utils @book000/eslint-config
Write-Output "Installed packages"

npx fixpack

# Create eslint.config.mjs
Write-Host "Create eslint.config.mjs..."
"export { default } from '@book000/eslint-config';" | Out-File -FilePath .\eslint.config.mjs -Encoding utf8

# Create .prettierrc.yml
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.prettierrc.yml" -OutFile ".prettierrc.yml"
Write-Output "Created .prettierrc.yml"

# Create tsconfig.json
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/tsconfig.json" -OutFile "tsconfig.json"
Write-Output "Created tsconfig.json"

# Create renovate.json
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/renovate.json" -OutFile "renovate.json"
Write-Output "Created renovate.json"

# Create .fixparkrc
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.fixpackrc" -OutFile ".fixpackrc"
Write-Output "Created .fixpackrc"

# Create .devcontainer
New-Item -Force .devcontainer -ItemType Directory
$devcontainerJson = @{
  name                = $projectName
  image               = "mcr.microsoft.com/devcontainers/typescript-node:0-18"
  postCreateCommand   = "corepack enable"
  postStartCommand    = "pnpm install"
  waitFor             = "postStartCommand"
  otherPortsAttributes = @{
    "onAutoForward" = "silent"
  }
  customizations      = @{
    extensions = @(
      "esbenp.prettier-vscode"
    )
    settings   = @{
      "[typescript]"         = @{
        "editor.defaultFormatter"  = "esbenp.prettier-vscode"
        "editor.codeActionsOnSave" = @{
          "source.organizeImports" = $false
        }
      }
      "git.branchProtection" = @("main", "master")
      "editor.formatOnSave"  = $true
    }
    vscode     = @{
      extensions = @(
        "esbenp.prettier-vscode"
      )
      settings   = @{
        "[typescript]"         = @{
          "editor.defaultFormatter"  = "esbenp.prettier-vscode"
          "editor.codeActionsOnSave" = @{
            "source.organizeImports" = $false
          }
        }
        "git.branchProtection" = @("main", "master")
        "editor.formatOnSave"  = $true
      }
    }
  }
}

$devcontainerJson | ConvertTo-Json -Depth 100 | Out-File -FilePath .devcontainer/devcontainer.json -Encoding utf8 -Force
npx fixdevcontainer
Write-Output "Created .devcontainer/devcontainer.json"

if ($ifConfigSchema) {
  # Install typescript-json-schema
  pnpm add -D -E typescript-json-schema

  $packageJson = Get-Content -Path package.json -Raw | ConvertFrom-Json -AsHashtable

  # Add script
  $packageJson.scripts."generate-schema" = "typescript-json-schema --required $tsConfigInterfacePath ConfigInterface -o schema/Configuration.json"
  $packageJson | ConvertTo-Json -Depth 100 | Out-File -FilePath package.json -Encoding utf8 -Force

  # Add depcheck ignore
  $depcheckrcJson.ignores += @(
    "typescript-json-schema"
  )
  $depcheckrcJson | ConvertTo-Json -Depth 100 | Out-File -FilePath .depcheckrc.json -Encoding utf8 -Force

  Write-Output "Add generate-schema script to package.json"
}

# Create Dockerfile
if ($ifDockerfile) {
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/Dockerfile" -OutFile "Dockerfile"
  Write-Output "Created Dockerfile"

  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/templates/master/workflows/docker.yml" -OutFile ".github/workflows/docker.yml"
  # Replace { imageName: "tomacheese/twitter-dm-memo", context: ".", file: "Dockerfile", packageName: "twitter-dm-memo" }
    (Get-Content -Path ".github/workflows/docker.yml" -Raw) -replace "{ imageName: `"tomacheese/twitter-dm-memo`", context: `".`", file: `"Dockerfile`", packageName: `"twitter-dm-memo`" }", "{ imageName: `"$projectOrganization/$projectName`", context: `".`", file: `"Dockerfile`", packageName: `"$projectName`" }" | Set-Content -Path ".github/workflows/docker.yml"
  Write-Output "Created .github/workflows/docker.yml"
}

# Create add-reviewer.yml
if ($ifAddReviewer) {
  Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/templates/master/workflows/add-reviewer.yml" -OutFile ".github/workflows/add-reviewer.yml"
  Write-Output "Created .github/workflows/add-reviewer.yml"
}

Write-Output ""
Write-Output "Done"

$ErrorActionPreference = $prevErrorActionPreference
