---
title: "LangSmith Incident on May 1, 2025"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-incident-on-may-1-2025/"
date: "2025-05-07"
scraped_at: "2026-03-03T07:32:29.900799099+00:00"
language: "en-zh"
translated: true
tags: ["Engineering", "![Building Multi-Agent Apps", "deep agents"]
---

Requests to the [US LangSmith API](https://api.smith.langchain.com/redoc?ref=blog.langchain.com) from both the [web application](https://smith.langchain.com/?ref=blog.langchain.com) and SDKs experienced an elevated error rate for 28 minutes on May 1, 2025 (starting at 14:35 UTC and ending at 15:03 UTC). During the incident window, approximately 55% of all API requests failed with a connection error. This impacted all endpoints accessible through the API, including endpoints for run ingestion and data fetching.

2025 年 5 月 1 日，[美国 LangSmith API](https://api.smith.langchain.com/redoc?ref=blog.langchain.com)（来自 [Web 应用](https://smith.langchain.com/?ref=blog.langchain.com) 和各类 SDK）的请求错误率异常升高，持续时间为 28 分钟（始于协调世界时 UTC 14:35，止于 15:03）。在故障窗口期内，约 55% 的全部 API 请求因连接错误而失败。此次故障影响了所有可通过该 API 访问的端点，包括运行数据（run）上报和数据拉取等端点。

A conflicting DNS record was accidentally left over during a migration between certificate renewal automation technologies at the end of January. This conflicting record caused renewal to fail all attempts at rotation during the month of April. Once the certificate expired, the LangSmith UI showed “Your connection is not private” when loaded, and all new connection attempts to the LangSmith API failed if they verified SSL.

一月末，在证书续期自动化技术迁移过程中，一条冲突的 DNS 记录被意外遗留下来。该冲突记录导致整个四月份所有证书轮换（rotation）尝试均告失败。证书过期后，LangSmith 用户界面加载时显示“您的连接并非私密”（Your connection is not private），且所有对 LangSmith API 的新连接请求（若启用 SSL 验证）均失败。

Once the root cause was identified, the conflicting DNS record was deleted and a manual SSL certificate renewal was triggered, which restored SSL connectivity.

根因定位后，该冲突 DNS 记录被立即删除，并手动触发了 SSL 证书续期流程，从而恢复了 SSL 连接能力。

This incident happened due to a combination of human error and lack of observability for cert renewal automation and SSL certificate expiry. The incident was not initially discovered with proactive monitoring — it was instead first reported by both internal and external users. This further pointed to observability gaps that needed closing.

本次事故由人为失误与证书续期自动化流程及 SSL 证书过期监控缺失共同导致。事故最初并未通过主动监控发现，而是先由内部员工与外部用户分别报告。这进一步凸显出亟待弥补的可观测性（observability）短板。

# Incident timeline

# 事故时间线

💡

All timestamps are in UTC

💡

所有时间戳均为协调世界时（UTC）

| **Time** | **Event** |
| --- | --- |
| January 31, 2025 13:35 | Migration to new certificate renewal automation completed, new certificates issued |
| January 31, 2025 16:07 | Conflicting DNS record created via dangling Terraform code |
| April 1, 2025 | Certificate renewal automation begins failed attempts to renew |
| May 1, 2025 14:35 | Certificate expired |
| May 1, 2025 14:41 | Initial user report of certificate expiry error |
| May 1, 2025 14:47 | Root cause identified. |
| May 1, 2025 14:49 | Conflicting DNS record deleted. Manual request to renew certificate issued. |
| May 1, 2025 14:54 | Public incident status page published. |
| May 1, 2025 15:03 | New certificate issuance completed, availability restored. |

| **时间** | **事件** |
| --- | --- |
| 2025 年 1 月 31 日 13:35 | 新证书续期自动化系统迁移完成，新证书签发成功 |
| 2025 年 1 月 31 日 16:07 | 因残留的 Terraform 代码，意外创建了冲突的 DNS 记录 |
| 2025 年 4 月 1 日 | 证书续期自动化系统开始反复失败的续期尝试 |
| 2025 年 5 月 1 日 14:35 | SSL 证书正式过期 |
| 2025 年 5 月 1 日 14:41 | 首次收到用户关于证书过期错误的报告 |
| 2025 年 5 月 1 日 14:47 | 根本原因确认 |
| 2025 年 5 月 1 日 14:49 | 冲突 DNS 记录被删除；手动发起证书续期请求 |
| 2025 年 5 月 1 日 14:54 | 公开事故状态页面上线发布 |
| 2025 年 5 月 1 日 15:03 | 新证书签发完成，服务可用性全面恢复 |

# Analysis

# 根因分析

The indicators of certificate renewal failures included a certificate resource stuck in “pending” status and error logs in the component managing the renewal.

证书续期失败的早期迹象包括：证书资源长期处于“pending”（待处理）状态，以及负责续期的组件中出现相关错误日志。

# Resolution

# 问题解决

Once we identified the root cause, we were able to restore availability quickly by deleting the conflicting DNS record and manually requesting certificate renewal.

在定位根本原因后，我们通过删除冲突的 DNS 记录并手动触发证书续期，迅速恢复了服务可用性。

# Next Steps

# 后续改进措施

The human error component of this incident involved:

本次事件中的人为失误包括：

- Missing deleting the conflicting Google-managed SSL certificate in Terraform code  
- 在 Terraform 代码中遗漏了对冲突的 Google 托管 SSL 证书的删除操作  

- An incorrect assumption that we had certificate expiry monitors in place that would remain valid after migration  
- 错误地假设我们已部署证书过期监控机制，且该机制在迁移后仍能持续有效  

There were a few contributing factors to the duration of this incident and the slowness of our public response:

导致本次事件持续时间较长及对外响应迟缓的因素包括：

- Recent change of log destinations for Kubernetes system components omitted the new component, so manual troubleshooting was required  
- 近期 Kubernetes 系统组件日志输出目标发生变更，但未将新组件纳入日志采集范围，因此需依赖人工排查  

- Migration between status page providers in progress at the time — this delayed status page publishing  
- 当时正处于状态页服务商迁移过程中——这延迟了状态页的更新发布  

With all of this in mind, we have taken steps to prevent this failure — and others like it — from happening again:

基于上述分析，我们已采取以下措施，防止此类故障（及类似问题）再次发生：

1. Added certificate expiry monitors for LangSmith domains  
1. 为 LangSmith 域名新增证书过期监控  

2. Added monitors for significant drops in run ingestion volume  
2. 新增对运行数据（run）摄入量显著下降的监控  

3. Ensured all Kubernetes system component logs are ingested  
3. 确保所有 Kubernetes 系统组件的日志均被正常采集  

4. **In Progress**: Monitor error logs from all Kubernetes system namespaces  
4. **进行中**：监控所有 Kubernetes 系统命名空间中的错误日志  

5. **In Progress**: Building an internal dashboard for critical Kubernetes system workflows like certificate renewal  
5. **进行中**：构建内部仪表盘，用于监控证书续期等关键 Kubernetes 系统工作流  

We take the reliability of our platform seriously, and we will invest in this area and others to continue improving our incident response process and reliability.

我们高度重视平台的可靠性，并将持续投入资源，进一步优化事件响应流程与系统整体可靠性。

### Tags

### 标签

[![Building Multi-Agent Apps](images/langsmith-incident-on-may-1-2025/img_001.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 分钟阅读