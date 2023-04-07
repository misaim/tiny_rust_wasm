all:
	echo "Building without server, -Os"

build: src/lib.rs
	rm -f dist/*
	wasm-pack build --dev --target no-modules --out-dir dist --out-name index
	mv dist/index_bg.wasm dist/index.wasm

release: clean
	wasm-pack build --target no-modules --out-dir www/dist --out-name index
	cp index.html www/index.html
	cp -r static/ www/static
	mv www/dist/index_bg.wasm www/dist/index.wasm
	rm www/dist/*.ts www/dist/package.json

release-test: release
	cd www/ && python3 -m http.server

run: build
	python3 -m http.server

clean:
	rm -rf www/ dist/
