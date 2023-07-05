
# Tiny Rust + WASM

A really small rust + wasm example using webpack. Current packaged size is 29.8 KB uncompressed. 

## Just get started™

`git clone` this repo then `make run`

Navigate to `http://[::]:8000/` or `http://127.0.0.1:8000`

## dependencies

- `make` for handling builds.
- `rust` (i.e `cargo`) and `wasm-pack` for building.
- (optional) `python3` `simple.http` used for `make run` and `make release-test`

## building:

`make build` will build wasm file + js shim to `dist/`.

`make release` will clean, build with release flags and then copy required files to `www/`, which can then be hosted with your http server of choice. Release builds can be significantly smaller then dev builds.

## running

`make run` builds and hosts a basic web server with `python3` from the current directory.

`release-test` performs a release build and hosts a basic web server with `python3` from the `www/` directory.

## base example 
Suggest reading the [wasm-bindgen](https://rustwasm.github.io/docs/wasm-bindgen/introduction.html) book for more information.

#### interacting with DOM, exporting a function to js
##### src/lib.rs
``` rust
use wasm_bindgen::prelude::*;

// Async boilerplate - marks this function (main()) as the entrypoint to the browser.
#[wasm_bindgen(start)]
pub fn main() -> Result<(), JsValue> {
    // Lots of expects - each of these could cause an error if the required item doesn't exist (or can't be created)
    let window = web_sys::window().expect("no global `window` exists");
    let document = window.document().expect("should have a document on window");
    let body = document.body().expect("document should have a body");
    
    // Creates a new p element: <p>"Hello, world!"</p>
    let p = document.create_element("p")?;
    p.set_inner_html("Hello, world!");
    
    // Try to add our <p> element to the document body
    body.append_child(&p).unwrap(); 
    
    // End of Async code - not that javascript cares :D
    Ok(())
}

// Function should exported to javascript. Note standard javascript typings used.
#[wasm_bindgen]
pub fn add(a: u32, b: u32) -> u32 {
    a + b
}
```
##### index.html
``` html
...
  <script type="module">
    import init, { add } from './dist/index.js';
    async function run() {
      await init();
      console.log(add(2, 1)); 
    }
    run();
  </script>
...
```

#### logs to web console
``` rust
#[wasm_bindgen]
extern {
    #[wasm_bindgen(js_namespace = console)]
    fn log(s: &str);
}

log("Hello, console!");
```
