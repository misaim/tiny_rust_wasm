all:
	echo "No rule defined. Try make run."

build: src/lib.rs
	rm -f dist/*
	wasm-pack build --dev --target web --out-dir dist --out-name index

release: clean
	wasm-pack build --target web --out-dir www/dist --out-name index
	cp index.html www/index.html
	cp -r static/ www/static
	rm www/dist/*.ts www/dist/package.json www/dist/.gitignore www/dist/README.md

release-test: release
	cd www/ && python3 -m http.server

run: build
	python3 -m http.server

clean:
	cargo clean
	rm -rf www/ dist/
