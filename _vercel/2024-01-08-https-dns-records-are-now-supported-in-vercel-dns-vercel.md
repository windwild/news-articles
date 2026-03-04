---
title: "HTTPS DNS records are now supported in Vercel DNS - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/https-dns-records-are-now-supported-in-vercel-dns"
date: "2024-01-08"
scraped_at: "2026-03-02T09:48:41.293042344+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Jan 8, 2024

2024 年 1 月 8 日

You can now create `HTTPS` DNS records in Vercel DNS.

您现在可以在 Vercel DNS 中创建 `HTTPS` DNS 记录。

The new `HTTPS` DNS record type, also known as SVCB or Service Binding record, has recently been published as [RFC 9460](https://datatracker.ietf.org/doc/rfc9460/).

新型 `HTTPS` DNS 记录类型（亦称 SVCB 记录或服务绑定记录）近期已作为 [RFC 9460](https://datatracker.ietf.org/doc/rfc9460/) 正式发布。

This record type is designed for the HTTP protocol to improve client performance and privacy in establishing secure connections. The record can include additional information about the target server, such as supported ALPN protocols (e.g., HTTP/2, HTTP/3, etc), which can eliminate the need for protocol negotiation/upgrade between client and server to minimize the number of round trips.

该记录类型专为 HTTP 协议设计，旨在提升客户端在建立安全连接时的性能与隐私保护能力。记录中可包含目标服务器的额外信息（例如所支持的 ALPN 协议，如 HTTP/2、HTTP/3 等），从而避免客户端与服务器之间进行协议协商或升级，减少往返通信次数。

Since the `HTTPS` record type is still a new standard, not all HTTP clients can support it. Learn more in [our documentation](https://vercel.com/docs/projects/domains/working-with-dns#dns-records).

由于 `HTTPS` 记录类型仍是一项新兴标准，并非所有 HTTP 客户端均支持该功能。更多详情请参阅[我们的文档](https://vercel.com/docs/projects/domains/working-with-dns#dns-records)。
&#123;% endraw %}
