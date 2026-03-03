---
title: "January 2020 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-january-2020"
date: "2020-01-01"
scraped_at: "2026-03-02T10:07:16.885917492+00:00"
language: "en-zh"
translated: true
description: "Vercel's changelog for January 2020"
---

Jan 1, 2020

2020 年 1 月 1 日

## Deployments

## 部署

- 新建部署现在将自动获得当时 Vercel 上可用的最新 Node.js 版本（参见 [Vercel 官方运行时文档](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version)）。

- 新建部署现在将自动获得当时 Vercel 上可用的最新 Node.js 版本（参见 [Vercel 官方运行时文档](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version)）。

## Domains

## 域名

- 删除项目时，其所有生产环境域名（Production Domains）现在也将一并停用（此后不再提供任何内容）。

- 删除项目时，其所有生产环境域名（Production Domains）现在也将一并停用（此后不再提供任何内容）。

- 从未正确配置过的域名，现在将在 7 天后自动删除（此前为 3 天）。

- 从未正确配置过的域名，现在将在 7 天后自动删除（此前为 3 天）。

- 创建新项目时，若组合名称可用，其默认生产环境域名现在将缩短一个单词。

- 创建新项目时，若组合名称可用，其默认生产环境域名现在将缩短一个单词。

## Other

## 其他更新

- 现在，只需向 [zeit/now](https://github.com/zeit/now) 仓库提交一个 Pull Request，即可为 Vercel 添加对新框架的支持。

- 现在，只需向 [zeit/now](https://github.com/zeit/now) 仓库提交一个 Pull Request，即可为 Vercel 添加对新框架的支持。

- 自 Now CLI 16.7.3 起，所有以 `.env` 开头的文件均不再上传；此前仅名为 `.env` 的文件不被上传。

- 自 Now CLI 16.7.3 起，所有以 `.env` 开头的文件均不再上传；此前仅名为 `.env` 的文件不被上传。

- New endpoints for retrieving a [realtime stream of all requests for a deployment](https://zeit.co/docs/api/#endpoints/logs/stream-serverless-function-logs) and retrieving all [failed requests](https://zeit.co/docs/api/#endpoints/logs/fetch-failed-requests-for-serverless-function) are now available.

- 现已提供两个新 API 端点：用于获取部署的[所有请求的实时流](https://zeit.co/docs/api/#endpoints/logs/stream-serverless-function-logs)，以及用于获取所有[失败请求](https://zeit.co/docs/api/#endpoints/logs/fetch-failed-requests-for-serverless-function)。