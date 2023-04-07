
# Tiny Rust + WASM

  

A really small rust + wasm example using webpack.

Base example interacts with DOM.

Suggest reading the [wasm-bindgen](https://rustwasm.github.io/docs/wasm-bindgen/introduction.html) book for more information.

## Just get started™

`git clone` this repo then

`make run`

Navigate to `http://[::]:8000/` or `http://127.0.0.1:8000`

 
## Dependencies

`rust` and `wasm-pack` for builds.

`python3` used for `make run` and `make release-test`

## Building:

`make build` will compile rust and move wasm + js web pack files to `dist/`.

`make release` will clean, build and then 'deploy' to `www/`.

## Running

`make run` builds and runs from the root directory.

`release-test` builds and runs from the `www/` directory.
