---
title: "Rust runtime now in public beta for Vercel Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/rust-runtime-now-in-public-beta-for-vercel-functions"
date: "2025-12-08"
scraped_at: "2026-03-02T09:24:14.697780199+00:00"
language: "en-zh"
translated: true
description: "The Rust runtime is now available in public beta for Vercel Functions. Now powered by Fluid compute."
---

render_with_liquid: false
Dec 8, 2025

2025 年 12 月 8 日

Today, we are launching first-class support for the Rust runtime beta.

今天我们正式推出对 Rust 运行时 Beta 版本的一流支持。

This new release of native support, as an evolution of the [community Rust runtime](https://github.com/vercel-community/rust), brings the full benefits of Vercel Functions, including Fluid compute (with HTTP response streaming and Active CPU pricing) and an increased environment variable limit from 6KB to 64KB.

此次原生支持的新版本，是在 [社区 Rust 运行时](https://github.com/vercel-community/rust) 基础上的演进，全面集成 Vercel Functions 的所有优势，包括 Fluid 计算能力（支持 HTTP 响应流式传输与活跃 CPU 计费模式），以及环境变量容量上限从 6KB 提升至 64KB。

Rust deployments automatically integrate with Vercel's existing logging, observability, and monitoring systems.

Rust 部署将自动接入 Vercel 现有的日志记录、可观测性与监控系统。

To get started, create a Cargo.toml file and a handler function like in the example below:

快速开始：请创建一个 `Cargo.toml` 文件，并编写一个处理函数（handler function），如下例所示：

Cargo.toml

`Cargo.toml`

```typescript
1[package]

name = "rust-hello-world"

version = "0.1.0"

edition = "2024"
```

6[dependencies]

6[依赖项]

tokio = { version = "1", features = ["full"] }

vercel_runtime = { version = "2" }

serde = { version = "1.0", features = ["derive"] }

serde_json = "1.0"

12[[bin]]

12[[二进制文件]]

name = "hello"

path = "api/hello.rs"

api/hello.rs

`api/hello.rs`

```typescript
use serde_json::{Value, json};

use vercel_runtime::{Error, Request, run, service_fn};



4#[tokio::main]

async fn main() -> Result<(), Error> {

6    let service = service_fn(handler);

7    run(service).await

8}
```

第 4 行：`#[tokio::main]`

第 4 行：`#[tokio::main]`

第 6 行：`let service = service_fn(handler);`

第 6 行：`let service = service_fn(handler);`

第 7 行：`run(service).await`

第 7 行：`run(service).await`

```rust
async fn handler(_req: Request) -> Result<Value, Error> {

11    Ok(json!({

12        "message": "Hello, world!",

13    }))

14}
```

立即使用我们的入门模板将应用部署到 Vercel：[Rust Hello World](https://vercel.com/templates/template/rust-hello-world) 和 [Rust Axum](https://vercel.com/templates/template/rust-axum)，或在 [函数文档](https://vercel.com/docs/functions/runtimes/rust) 中了解更多信息。