$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
Set-PSDebug -Trace 1

Start-Process -NoNewWindow -Wait -FilePath "yarn.cmd" -ArgumentList "init"

$NODE_VERSION=node -v
$NODE_VERSION=$NODE_VERSION.Replace("v","").Replace("\r","").Replace("\n","").Replace("`u{feff}","")
New-Item -Force .node-version -ItemType File -Value $NODE_VERSION
$PACKAGE_JSON=jq --arg version $NODE_VERSION '.engines.node |= $version' package.json
$PACKAGE_JSON | Out-File -FilePath package.json -Encoding utf8 -Force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/github/gitignore/main/Node.gitignore" -OutFile ".gitignore"

New-Item -Force .github/workflows/ -ItemType Directory
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/templates/master/workflows/nodejs-ci.yml" -OutFile ".github/workflows/nodejs-ci.yml"

yarn add -D -E typescript @types/node ts-node ts-node-dev prettier eslint eslint-config-standard eslint-config-prettier eslint-plugin-import eslint-plugin-n eslint-plugin-promise eslint-plugin-unicorn yarn-run-all @typescript-eslint/parser @typescript-eslint/eslint-plugin @vercel/ncc winston winston-daily-rotate-file logform cycle @book000/node-utils

npm pkg set scripts.start="ts-node -r tsconfig-paths/register ./src/main.ts"
npm pkg set scripts.dev="ts-node-dev --poll -r tsconfig-paths/register ./src/main.ts"
npm pkg set scripts.package="run-s clean compile packing"
npm pkg set scripts.packing="ncc build ./dist/main.js -o output/ -m"
npm pkg set scripts.compile="tsc -p ."
npm pkg set scripts.clean="rimraf dist output"
npm pkg set scripts.lint="run-p -c lint:prettier lint:eslint lint:tsc"
npm pkg set scripts.lint:prettier="prettier --check src"
npm pkg set scripts.lint:eslint="eslint . --ext ts,tsx"
npm pkg set scripts.lint:tsc="tsc"
npm pkg set scripts.fix="run-s fix:prettier fix:eslint"
npm pkg set scripts.fix:eslint="eslint . --ext ts,tsx --fix"
npm pkg set scripts.fix:prettier="prettier --write src"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.eslintrc.yml" -OutFile ".eslintrc.yml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.eslintignore" -OutFile ".eslintignore"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/.prettierrc.yml" -OutFile ".prettierrc.yml"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/tsconfig.json" -OutFile "tsconfig.json"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/book000/memo/main/docs/programming/nodejs/template/renovate.json" -OutFile "renovate.json"
