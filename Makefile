all: build strict min umd es docs

pretty:
	yarn run pretty

build: build/package.json
	@ node rollup.config.js --out=build

strict: build/package.json
	@ node rollup.config.js --out=build/strict --strict
	@ cp build/package.json build/strict

min: build/package.json
	@ node rollup.config.js --out=build/min --minify

umd: build/package.json
	@ node rollup.config.js --out=build/umd --format=umd

es: build/package.json
	@ node rollup.config.js --out=build/es --format=es

docs:
	@ mkdir -p build
	@ cp -r CHANGELOG.md README.md LICENSE build

build/package.json: package.json
	@ mkdir -p build
	@ node -p 'p=require("./package");p.private=p.scripts=p.jest=p.devDependencies=undefined;JSON.stringify(p,null,2)' > $@

release: clean all
	npm publish build

prerelease: clean all
	npm publish build --tag beta

bench: build
	@ NODE_ENV=production node --expose-gc bench/history-performance
	@ NODE_ENV=production node --expose-gc bench/dispatch-performance
	@ NODE_ENV=production node --expose-gc bench/push-performance
	@ NODE_ENV=production node --expose-gc bench/fork-performance
	@ NODE_ENV=production node --expose-gc bench/compare-tree-performance

clean:
	@ rm -rf build/*

.PHONY: clean bench release prerelease all docs build strict min umd es
