---
title: "Rust runtime now in public beta for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/rust-runtime-now-in-public-beta-for-vercel-functions"
date: "2025-12-08"
scraped_at: "2026-03-02T09:24:14.697780199+00:00"
language: "en"
translated: false
description: "The Rust runtime is now available in public beta for Vercel Functions. Now powered by Fluid compute."
---




Dec 8, 2025

Today, we are launching first-class support for the Rust runtime beta.

This new release of native support, as an evolution of the [community Rust runtime](https://github.com/vercel-community/rust), brings the full benefits of Vercel Functions, including Fluid compute (with HTTP response streaming and Active CPU pricing) and an increased environment variable limit from 6KB to 64KB.

Rust deployments automatically integrate with Vercel's existing logging, observability, and monitoring systems.

To get started, create a Cargo.toml file and a handler function like in the example below:

Cargo.toml

```typescript
1[package]

name = "rust-hello-world"

version = "0.1.0"

edition = "2024"



6[dependencies]

tokio = { version = "1", features = ["full"] }

vercel_runtime = { version = "2" }

serde = { version = "1.0", features = ["derive"] }

serde_json = "1.0"



12[[bin]]

name = "hello"

path = "api/hello.rs"
```

api/hello.rs

```typescript
use serde_json::{Value, json};

use vercel_runtime::{Error, Request, run, service_fn};



4#[tokio::main]

async fn main() -> Result<(), Error> {

6    let service = service_fn(handler);

7    run(service).await

8}



async fn handler(_req: Request) -> Result<Value, Error> {

11    Ok(json!({

12        "message": "Hello, world!",

13    }))

14}
```

Deploy to Vercel today with one of our starter templates [Rust Hello World](https://vercel.com/templates/template/rust-hello-world) and [Rust Axum](https://vercel.com/templates/template/rust-axum), or read more in [the Function docs](https://vercel.com/docs/functions/runtimes/rust).