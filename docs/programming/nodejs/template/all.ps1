$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

$prevErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

# Get setup options
# Project information
$currentDirectory = Get-Location
$projectDefaultName = $currentDirectory | Split-Path -Leaf

$projectName = Read-Host -Prompt "Project name (Default: $projectDefaultName)"
if ($projectName -eq "") {
    $projectName = $projectDefaultName
}

$projectOrganization = Read-Host -Prompt "Project organization (Default: book000)"
if ($projectOrganization -eq "") {
    $projectOrganization = "book000"
}

$projectRepository = Read-Host -Prompt "Project repository (Default: $projectOrganization/$projectName)"
if ($projectRepository -eq "") {
    $projectRepository = $projectOrganization + "/" + $projectRepository
}

$projectHomepage = Read-Host -Prompt "Project homepage (Default: https://github.com/$projectRepository)"
if ($projectHomepage -eq "") {
    $projectHomepage = "https://github.com/$projectRepository"
}

$projectAuthorName = Read-Host -Prompt "Project author name (Default: Tomachi <tomachi@tomacheese.com>)"
if ($projectAuthorName -eq "") {
    $projectAuthorName = "Tomachi <tomachi@tomacheese.com>"
}

$projectLicense = Read-Host -Prompt "Project license (Default: MIT)"
if ($projectLicense -eq "") {
    $projectLicense = "MIT"
}

$projectBugUrl = Read-Host -Prompt "Project bug URL (Default: $projectHomepage/issues)"
if ($projectBugUrl -eq "") {
    $projectBugUrl = $projectHomepage + "/issues"
}

$projectRepositoryUrl = Read-Host -Prompt "Project repository URL (Default: git@github.com:$projectRepository.git)"
if ($projectRepositoryUrl -eq "") {
    $projectRepositoryUrl = "git@github.com:$projectRepository.git"
}

# Generate options
# if test
$ifTest = Read-Host -Prompt "Do you want to add a test? (Default: n)"
if ($ifTest -eq "") {
    $ifTest = "n"
}
if ($ifTest -eq "y") {
    $ifTest = $true
} else {
    $ifTest = $false
}

Write-OutPut ""

Write-Output "Creating project..."

# Create package.json
$packageJson = @{
    name = $projectName
    version = "0.0.0"
    description = ""
    homepage = $projectHomepage
    bugs = @{
        url = $projectBugUrl
    }
    repository = @{
        type = "git"
        url = $projectRepositoryUrl
    }
    license = $projectLicense
    author = $projectAuthorName
    private = $true
    main = "dist/main.js"
    scripts = @{
        start = "tsx ./src/main.ts"
        dev = "tsx watch ./src/main.ts"
        lint = "run-z lint:prettier,lint:eslint,lint:tsc"
        "lint:prettier" = "prettier --check src"
        "lint:eslint" = "eslint . --ext ts,tsx"
        "lint:tsc" = "tsc"
        fix = "run-z fix:prettier fix:eslint"
        "fix:eslint" = "eslint . --ext ts,tsx --fix"
        "fix:prettier" = "prettier --write src"
    }
}

$packageJson | ConvertTo-Json -Depth 100 | Out-File -FilePath package.json -Encoding utf8 -Force
Write-Output "Created package.json."

# Create .node-version
$nodeVersion = node -v
$nodeVersion = $nodeVersion.Replace("v","").Replace("\r","").Replace("\n","").Replace("`u{feff}","")
New-Item -Force .node-version -ItemType File -Value $nodeVersion
Write-Output "Created .node-version."

# Create .gitignore
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore" -OutFile ".gitignore"
Write-Output "Created .gitignore."

# Create .github/workflows/nodejs-ci.yml
New-Item -Force .github/workflows/ -ItemType Directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/templates/master/workflows/nodejs-ci.yml" -OutFile ".github/workflows/nodejs-ci.yml"
Write-Output "Created .github/workflows/nodejs-ci.yml."

# If test is true, install packages
if ($ifTest) {
    # add package.json
    $packageJson.scripts.test = "jest --runInBand --passWithNoTests --detectOpenHandles --forceExit"

    $packageJson.jest = @{
      moduleFileExtensions = @("js", "ts")
      transform = @{
        "^.+\\.ts$" = @(
          "ts-jest",
          @{
            tsconfig = "tsconfig.json"
          }
        )
      }
      testMatch = @(
        "**/*.test.ts"
      )
      setupFilesAfterEnv = @(
        "jest-expect-message"
      )
    }

    $packageJson | ConvertTo-Json -Depth 100 | Out-File -FilePath package.json -Encoding utf8 -Force
    Write-Output "Updated package.json."

    pnpm add -D -E jest ts-jest @types/jest jest-expect-message
}

# Install packages
pnpm add -D -E typescript @types/node tsx prettier eslint eslint-config-standard eslint-config-prettier eslint-plugin-import eslint-plugin-n eslint-plugin-promise eslint-plugin-unicorn run-z @typescript-eslint/parser @typescript-eslint/eslint-plugin @vercel/ncc @book000/node-utils
Write-Output "Installed packages."

npx fixpack

# Create .eslintrc.yml
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.eslintrc.yml" -OutFile ".eslintrc.yml"
Write-Output "Created .eslintrc.yml."

# Create .eslintignore
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.eslintignore" -OutFile ".eslintignore"
Write-Output "Created .eslintignore."

# Create .prettierrc.yml
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.prettierrc.yml" -OutFile ".prettierrc.yml"
Write-Output "Created .prettierrc.yml."

# Create tsconfig.json
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/tsconfig.json" -OutFile "tsconfig.json"
Write-Output "Created tsconfig.json."

# Create renovate.json
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/renovate.json" -OutFile "renovate.json"
Write-Output "Created renovate.json."

# Create .devcontainer
New-Item -Force .devcontainer -ItemType Directory
$devcontainerJson = @{
    name = $projectName
    image = "mcr.microsoft.com/devcontainers/typescript-node:0-18"
    postCreateCommand = "pnpm install"
    waitFor = "postCreateCommand"
    otherPortAttributes = @{
        "onAutoForward" = "silent"
    }
    customizations = @{
      extensions = @(
        "esbenp.prettier-vscode"
      )
      settings = @{
        "[typescript]" = @{
          "editor.defaultFormatter" = "esbenp.prettier-vscode"
          "editor.codeActionsOnSave" = @{
            "source.organizeImports" = $false
          }
        }
        "git.branchProtection" = @("main", "master")
        "editor.formatOnSave" = $true
      }
      vscode = @{
        extensions = @(
          "esbenp.prettier-vscode"
        )
        settings = @{
          "[typescript]" = @{
            "editor.defaultFormatter" = "esbenp.prettier-vscode"
            "editor.codeActionsOnSave" = @{
              "source.organizeImports" = $false
            }
          }
          "git.branchProtection" = @("main", "master")
          "editor.formatOnSave" = $true
        }
      }
    }
}

$devcontainerJson | ConvertTo-Json -Depth 100 | Out-File -FilePath .devcontainer/devcontainer.json -Encoding utf8 -Force
Write-Output "Created .devcontainer/devcontainer.json."

Write-Output ""
Write-Output "Done."
