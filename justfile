default:
    just --list

check: lint
    -stylua -c src/

lint:
    -selene src/

format:
    stylua src/

wally:
    wally install
    rojo sourcemap "default.project.json" --output sourcemap.json
    wally-package-types --sourcemap sourcemap.json Packages/
    wally-package-types --sourcemap sourcemap.json ServerPackages/
