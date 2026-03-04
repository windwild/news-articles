---
render_with_liquid: false
title: "Our $1 million hacker challenge for React2Shell - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/our-million-dollar-hacker-challenge-for-react2shell"
date: "2025-12-19"
scraped_at: "2026-03-02T09:23:32.953982752+00:00"
language: "en-zh"
translated: true
description: "We paid $1M to security researchers to break our WAF. Here's what we learned defending against React2Shell."
---
render_with_liquid: false
render_with_liquid: false

Dec 19, 2025

2025 年 12 月 19 日

在 React2Shell 漏洞披露后的数周内，我们的防火墙拦截了超过 600 万次针对运行存在漏洞版本 Next.js 的部署所发起的攻击尝试，其中峰值时段单日拦截量高达 230 万次。

这一成果得益于 Seawall——Vercel Web 应用防火墙（WAF）中深度请求检测层。我们与 116 位安全研究人员合作，全力挖掘 WAF 可能存在的所有绕过方式；为此累计发放奖金逾 100 万美元，并在 48 小时内根据新上报的技术手段快速发布 20 个独立的 WAF 更新。这些研究人员发现的绕过技术现已永久集成至我们的防火墙规则中，为平台上的所有部署提供防护。

但 WAF 规则仅是第一道防线。**我们现首次公开披露一项额外的纵深防御机制——该机制直接作用于 Vercel 平台的计算层，专门用于抵御远程代码执行（RCE）攻击。** 此纵深防御机制所产生的数据使我们能够高度确信：WAF 在阻断 React2Shell 利用行为方面表现极为出色。

本文将介绍我们为保护客户所构建的安全能力，以及这一能力对 Vercel 平台未来安全格局的意义。

## 我们正在防御什么

以下这段看似怪异的载荷，已令整个行业无数工程师辗转难眠：

```tsx
1{

2  0: {

3    status: "resolved_model",

4    reason: 0,

4    原因：0，

5    _response: {

5    _response：{

6      _prefix: "console.log('☠️')//",

6      _prefix：`console.log('☠️')//`，

7      _formData: {

7      _formData：{

8        get: "$1:then:constructor",

8        get：`"$1:then:constructor"`，

9      },

9      }，

10    },

10    }，

11    then: "$1:then",

11    then：`"$1:then"`，

12    value: '{"then":"$B"}',

12    value：`'{"then":"$B"}'`，

13  },

13  }，

14  1: "$@0",

15}
```

React2Shell 漏洞利用的示例 PoC

这就是 React2Shell 的有效载荷（payload）。将此内容发送至任何运行存在漏洞的 React Server Components 的服务器，该 `console.log('☠️')` 字符串便会在服务端被求值执行。该字符串可被替换为几乎任意代码：运行程序、提取密钥、发起网络请求等。CVE-2025-55182 的 CVSS 评分为 10.0（满分 10.0），堪称最严重的安全漏洞之一。

在该 CVE 被负责任地披露后，倒计时即已启动。我们深知恶意攻击者将争分夺秒地利用该漏洞，因此在公众尚不知情之前，便已主动联络 AWS、Google、Microsoft、Cloudflare、Netlify、Fastly、Deno 等行业合作伙伴。通过这种协同合作，当协调一致的公开披露正式进行时，所有主流平台提供商均已部署缓解措施，从而确保尽可能多的用户在完成自身补丁更新前即已受到保护。

但我们同样预见到接下来会发生什么。一旦一个漏洞被披露，安全研究人员、恶意攻击者以及好奇的旁观者便会立即开始审查受影响的代码路径，以寻找绕过手段及相关漏洞。短短数日内，研究人员便在 React Server Components 中识别出另外两个新漏洞，这迫使我们进一步发布补丁并更新 Web 应用防火墙（WAF）规则。

![公开披露后前 72 小时内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_001.svg)![公开披露后前 72 小时内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_002.svg)![公开披露后前 72 小时内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_003.svg)![公开披露后前 72 小时内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_004.svg)

公开披露后前 72 小时内拦截的漏洞利用尝试

![随后一周内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_005.svg)![随后一周内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_006.svg)![随后一周内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_007.svg)![随后一周内拦截的漏洞利用尝试](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_008.svg)

随后一周内拦截的漏洞利用尝试

We needed defenses that could adapt.

我们需要能够自适应的防御机制。

## The $50k bounty

## 5 万美元漏洞赏金计划

Rather than wait for WAF bypasses to surface in the wild, we decided to take control of the patch cycle and pay the best security researchers in the world to find them for us first.

我们没有被动等待 WAF 绕过技术在野外自然暴露，而是决定主动掌控补丁周期，率先聘请全球顶尖的安全研究人员帮我们发现这些绕过方法。

Within hours of the decision, we had a public bug bounty program live on HackerOne. Launching a program like this typically takes weeks. HackerOne's team worked around the clock to make it happen, and according to co-founder Michiel Prins, it was one of the fastest public program launches in their history.

决策作出数小时后，我们的公开漏洞赏金计划便已在 HackerOne 平台上线。通常，启动此类计划需耗时数周；而 HackerOne 团队昼夜奋战，使其如期落地——联合创始人 Michiel Prins 表示，这是 HackerOne 历史上启动速度最快的公开项目之一。

We offered $50,000 for every unique technique that bypassed our WAF protections. The bounty was deliberately high to help redirect researcher energy toward responsible disclosure instead of black market sales, and to turn the people who were going to be probing our defenses anyway into collaborators.

我们为每一种成功绕过我们 WAF 防护的独特技术提供 5 万美元奖励。该赏金金额刻意设得较高，旨在引导研究人员将精力投向负责任披露（responsible disclosure），而非黑市交易；同时，也将原本就打算探测我们防御体系的人员，转化为我们的协作伙伴。

The program worked. 116 researchers participated, submitting 156 reports. By the time the program closed, we had validated 38 responsible disclosures and paid out $1 million across 20 unique bypass techniques. We shared these techniques with other platform providers so they could harden their own defenses. What we learned didn't just protect Vercel customers.

该计划成效显著：共 116 名研究人员参与，提交了 156 份报告。项目结束时，我们已确认并验证了 38 起负责任披露，并针对 20 种独特的绕过技术累计发放奖金 100 万美元。我们还将这些绕过技术同步分享给其他平台提供商，助其加固自身防护体系。我们所获得的经验，不仅保护了 Vercel 的客户。

## Seawall: Hardening our WAF

## Seawall：强化我们的 WAF

Seawall is the deep request inspection layer of our WAF, examining request payloads rather than just headers and blocking malicious patterns before they reach your application.

Seawall 是我们 WAF 中深度请求检测层，它不仅检查请求头（headers），更深入分析请求载荷（payloads），在恶意模式抵达您的应用之前即予以拦截。

After each HackerOne report, we followed a repeatable process. Reproduce the bypass. Convert it into a test case. Update the rules to block it. Deploy globally. Wait for the next report. Repeat. We shipped 20 updates to Seawall in the first 48 hours after the bounty program launched, with average response time dropping from two hours to thirty minutes per finding as we refined our process.

每次收到 HackerOne 报告后，我们都遵循一套可复用的流程：复现绕过行为 → 将其转化为测试用例 → 更新规则以实现拦截 → 全球部署 → 等待下一份报告 → 再次循环。赏金计划启动后的前 48 小时内，我们已向 Seawall 推送了 20 次更新；随着流程持续优化，我们对每项新发现的平均响应时间也从最初的两小时缩短至三十分钟。

Most reports came in during the first 24 hours as researchers tested novel variations. A smaller batch in the second 24 hours. Then a trickle of increasingly sophisticated techniques over the following days as people dug deeper into edge cases.

大多数报告集中在前 24 小时内，研究人员在此期间尝试了大量新颖变体；第二日报告数量明显减少；随后数日内，则陆续出现少量但日益精巧的技术方案——研究人员正不断深入挖掘边界场景（edge cases）。

One thing that surprised us was how useful AI turned out to be for the work of reproducing reports.  
令我们惊讶的一点是，AI 在复现漏洞报告的工作中竟展现出如此高的实用价值。

The submissions generally rely on subtle nuances that are easy to miss, and the exploitation conditions can be very specific.  
这些提交的报告通常依赖于一些细微却容易被忽略的差别，且利用条件往往非常具体。

Modern AI models are remarkably good at teasing out those details and converting them into reproducible test cases.  
现代 AI 模型在挖掘这些细节方面表现极为出色，并能将其转化为可复现的测试用例。

Every validated report became a Go-based unit test that now runs on CI whenever Seawall changes.  
每一份经验证的报告都转化成了基于 Go 的单元测试，如今只要 Seawall 发生变更，这些测试就会在持续集成（CI）环境中自动运行。

The techniques researchers discovered during this program will continue protecting customers long after the bounty ended.  
研究人员在此项目中发现的各类技术，将在赏金计划结束之后，长期持续地保护我们的客户。

## Adding to our defense-in-depth strategy

## 深化纵深防御策略

To protect customers further, we deployed a second layer of defense that operates directly on the compute layer.  
为进一步保护客户，我们部署了第二层防御机制，该机制直接作用于计算层（compute layer）。

This runtime mitigation layer operates inside the application itself, not at the WAF layer.  
这一运行时缓解层（runtime mitigation layer）内置于应用程序内部，而非位于 Web 应用防火墙（WAF）层面。

For this reason it does not rely on heuristics and instead directly eliminates the code evaluation vector targeted by the attack.  
正因如此，它不依赖启发式规则，而是直接消除攻击所针对的代码求值（code evaluation）入口点。

React2Shell relies on the fact that JavaScript functions have a `constructor` property which can be used to eval code at runtime.  
React2Shell 攻击依赖于 JavaScript 函数拥有一个 `constructor` 属性，该属性可在运行时用于执行任意代码（`eval`）。

The runtime mitigation denies this code execution during React rendering, breaking the attack vector at its core.  
该运行时缓解机制在 React 渲染过程中禁止此类代码执行，从而从根源上切断了攻击路径。

We expected that legitimate applications would never use this capability, and when we trialed the mitigation we saw nothing touching this code path in practice, so we knew it was safe to deploy.  
我们预期，合法应用绝不会使用这一能力；在缓解措施试运行期间，我们也未观察到任何实际流量触及该代码路径，因此确认其上线是安全的。

Deno's team was the first to ship a runtime mitigation, and their willingness to share details gave us confidence in the direction we were already exploring.  
Deno 团队是首个推出运行时缓解方案的团队；他们乐于公开技术细节，进一步坚定了我们此前已着手探索的方向。

We adapted our implementation for Node.js, validated at scale that it was safe to deploy, then shared it back to other platform providers so that they could benefit from it as well.  
我们将该方案适配至 Node.js 环境，在大规模生产环境中验证其安全性后，又将实现回馈给其他平台提供商，使其也能从中受益。

Dedicated logging was set up to fire whenever the runtime mitigation triggered, with automatic alerts to the security team.  
我们专门设置了日志记录机制：每当运行时缓解机制被触发，即自动生成日志并自动向安全团队发出告警。

If an attacker found a WAF bypass that actually worked in production, the runtime mitigation would catch it and we'd know immediately.  
倘若攻击者发现了真正能在生产环境中奏效的 WAF 绕过手段，该运行时缓解机制也会及时捕获，我们可立即获知。

Today, this mitigation covers 96% of traffic on Vercel.  
目前，该缓解机制已覆盖 Vercel 平台上 96% 的流量。

Through the logging from the second layer of defense in place, we actually know when the WAF gets bypassed in practice, and so we can state with high confidence that Vercel's WAF was highly effective against exploitation of React2Shell.  
借助第二层防御机制所生成的日志，我们实际上能够明确识别出 WAF 在真实场景中被绕过的时刻；因此，我们有充分信心断言：Vercel 的 WAF 在抵御 React2Shell 利用方面表现极为有效。

## Stopping the most sophisticated bypasses

## 阻断最复杂的绕过手段

The HackerOne program attracted talented researchers from around the world.  
HackerOne 项目吸引了来自全球各地的优秀安全研究员。

Thanks to everyone who participated and helped make Seawall stronger.  
衷心感谢所有参与本项目、助力 Seawall 不断强化的各位同仁。

The core job of a WAF protecting against React2Shell is to identify malicious payloads while allowing legitimate ones.  
WAF 在防御 React2Shell 攻击时的核心任务，是在放行合法载荷的同时精准识别恶意载荷。

Actually executing the code to check isn't an option, so pattern matching and parsing have to be enough.  
实际执行代码进行检测并不可行，因此必须仅依靠模式匹配与语法解析来完成判断。

For researchers, that means finding ways to hide the exploit from pattern matching.  
对研究员而言，这意味着需设法让攻击载荷避开模式匹配的检测。

[Lachlan Davidson](https://github.com/lachlan2k/), the original discoverer of React2Shell, and his research partner [Sylvie](https://hackerone.com/sy1vi3) submitted two bypasses that we want to walk through here. They demonstrate both the challenges of building a secure WAF and the creativity of the security research involved.

[Lachlan Davidson](https://github.com/lachlan2k/) 是 React2Shell 的最初发现者，他与研究伙伴 [Sylvie](https://hackerone.com/sy1vi3) 提交了两个绕过漏洞，我们将在本文中逐一分析。这两个案例既体现了构建安全 Web 应用防火墙（WAF）所面临的挑战，也展现了安全研究人员在攻防对抗中所展现出的非凡创造力。

### Recursive UTF encoding

### 递归式 UTF 编码

Many bypasses try to confuse the parser by replacing regular characters with their Unicode representation in JSON. This is relatively easy to normalize and most WAFs do so by default.

许多绕过技术试图通过将常规字符替换为 JSON 中对应的 Unicode 表示形式来混淆解析器。这类编码相对容易标准化，大多数 WAF 默认即支持此类规范化处理。

But what if you could Unicode encode the Unicode encoding? And then do it again?

但如果对 Unicode 编码本身再次进行 Unicode 编码呢？甚至反复多次呢？

Lachlan and Sylvie discovered that an exploit gadget that could force the React flight protocol to perform repeated JSON decoding of the same string. Any WAF robust against N layers of Unicode encoding could be defeated by using the gadget N+1 times. Seawall now recursively decodes until the payload is fully normalized, closing this class of bypass entirely.

Lachlan 与 Sylvie 发现了一种利用漏洞的小工具（exploit gadget），可强制 React Flight 协议对同一字符串执行多次 JSON 解码。任何能抵御 N 层 Unicode 编码的 WAF，都可在使用该小工具 N+1 次后被成功绕过。为此，Seawall 现已实现递归式解码机制，持续解码直至载荷完全归一化，从而彻底封堵此类绕过方式。

Notably, this and similar bypasses also relied on extremely subtle behaviors of JavaScript's built-in ReadableStream class where it is possible to construct errored stream chunks that, against default behavior, do not terminate stream processing and then relying on the fact the stringification as part of stream error message can be leveraged into a function call exploit gadget.

值得注意的是，此类及类似绕过技术还依赖于 JavaScript 原生 `ReadableStream` 类中极为隐蔽的行为：攻击者可构造出处于错误状态（errored）的流数据块（stream chunk）；而按默认行为，这类错误块并不会终止流处理流程；更关键的是，流错误消息在字符串化（stringification）过程中所触发的副作用，可被进一步利用，转化为函数调用型漏洞利用小工具（function call exploit gadget）。

![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_009.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_010.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_011.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_012.svg)

![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_009.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_010.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_011.svg)![](images/our-1-million-hacker-challenge-for-react2shell-vercel/img_012.svg)

### Accessing constructor without the colon

### 不使用冒号访问 constructor

The core RCE gadget of React2Shell accesses the constructor property of a function using the React flight protocol's colon-based property access syntax. That is why the exploit contains the string `:constructor`, and WAF protections detect bad payloads based on this string.

React2Shell 的核心远程代码执行（RCE）小工具，是借助 React Flight 协议基于冒号（`:`）的属性访问语法，来获取函数对象的 `constructor` 属性。正因如此，所有利用该漏洞的载荷中均包含字符串 `:constructor`，而 WAF 的防护规则也正是基于该字符串识别恶意载荷。

One way to bypass this would be to find an entirely different exploit chain that doesn't use the constructor property, but nobody has been able to find one. Lachlan found another way: going from `:constructor` to `constructor`. Notice the missing colon?

一种可能的绕过思路是寻找一条完全不依赖 `constructor` 属性的全新利用链，但迄今尚无人成功实现。而 Lachlan 找到了另一条路径：将 `:constructor` 改为 `constructor`——注意，冒号消失了？

They did this by discovering a way to do property access and string manipulation using similar gadgets specific to the webpack modules in context for RSC parsing. A WAF can detect this approach by targeting strings further up the attack chain, but it demonstrates the power an attacker has in obfuscating payloads beyond the original proof of concept.

他们通过发现一种方法实现了属性访问和字符串操作——该方法利用了针对当前 RSC 解析上下文中 webpack 模块的相似“小工具”（gadgets）。Web 应用防火墙（WAF）可通过在攻击链更上游的位置检测相关字符串来识别此类手法；但这也凸显了攻击者在混淆载荷方面所具备的强大能力，远超原始概念验证（PoC）的范畴。

## Helping customers upgrade: Security as a product experience

## 协助客户升级：将安全融入产品体验

Defense in depth bought time, but the only true fix was getting people to upgrade. We shipped a [security bulletin](https://vercel.com/kb/bulletin/react2shell) to serve as the single source of truth, dashboard banners to help identify vulnerable deployments, a CLI tool (`npx fix-react2shell-next`) to help patch vulnerable apps, and automated PRs via Vercel Agent to automate that process as much as possible.

纵深防御争取了时间，但唯一真正有效的修复方案仍是推动用户升级。我们发布了[安全公告](https://vercel.com/kb/bulletin/react2shell)，作为权威、统一的信息来源；在控制台仪表板中添加横幅提示，帮助用户识别存在风险的部署；提供命令行工具（`npx fix-react2shell-next`），协助修复易受攻击的应用；并通过 Vercel Agent 自动发起 Pull Request（PR），尽可能实现整个修复流程的自动化。

## Looking ahead

## 展望未来

React2Shell tested our security infrastructure in ways we couldn’t have simulated. We came out of this with a battle-hardened WAF, a runtime defense layer that we can adapt for future vulnerabilities, and a playbook for responding to the next critical CVE.

React2Shell 以我们此前无法模拟的方式检验了自身的安全基础设施。此次事件后，我们拥有了一个历经实战考验的 Web 应用防火墙（WAF）、一个可灵活适配未来漏洞的运行时防御层，以及一套应对下一次高危 CVE 的标准化响应手册。

The bypass techniques researchers discovered during the HackerOne program are now permanent additions to our firewall. The cross-industry collaboration set a template for how platforms can work together when the web is under attack. The tools shipped to help customers upgrade are now part of how we respond to any security incident.

研究人员在 HackerOne 项目期间发现的各类绕过技术，现已永久集成至我们的防火墙规则中。跨行业协作则为网络遭受攻击时各平台如何协同响应树立了范本。而为协助客户升级所发布的各类工具，如今已成为我们应对任何安全事件的标准响应流程的一部分。

But platform protections only buy time. They're a first line of defense, not a replacement for patching. If you're running a vulnerable version of Next.js, patch now.

但平台级防护仅能争取时间——它属于第一道防线，绝不能替代打补丁本身。若您正在运行存在漏洞的 Next.js 版本，请立即升级修复。

The next critical vulnerability will come, and when it does, Vercel customers can be confident that we will have protections in place while they patch.

下一次高危漏洞终将到来；届时，Vercel 客户可确信：在您完成修复之前，我们已提前部署好相应防护措施。

## Credits

## 致谢

First and foremost, thank you to [Lachlan Davidson](https://github.com/lachlan2k/) for responsibly disclosing React2Shell. He continued to probe our defenses after disclosure and submitted some of the most sophisticated bypasses we saw.

首先，衷心感谢 [Lachlan Davidson](https://github.com/lachlan2k/) 对 React2Shell 漏洞的负责任披露。他在披露之后持续深入测试我们的防御机制，并提交了我们所见最为精巧复杂的若干绕过方案。

Thank you to every researcher who participated in our HackerOne program: hakikiwidya, [luhko](https://hackerone.com/luhko), [lachlan2k](https://hackerone.com/lachlan2k), [sy1vi3](https://hackerone.com/sy1vi3), [maple3142](https://hackerone.com/maple3142), [hacktronresearch](https://hackerone.com/hacktronresearch), [bugra](https://hackerone.com/bugra), [lonecat](https://hackerone.com/lonecat), [ryotak](https://hackerone.com/ryotak), [ch1axan](https://hackerone.com/ch1axan), [chilaxan](https://hackerone.com/chilaxan), [cjm00n](https://hackerone.com/cjm00n), [francisconeves97](https://hackerone.com/francisconeves97), [phithon](https://hackerone.com/phithon), [shubs](https://hackerone.com/shubs), and [hashkitten](https://hackerone.com/hashkitten).

衷心感谢参与我们 HackerOne 计划的每一位研究人员：hakikiwidya、[luhko](https://hackerone.com/luhko)、[lachlan2k](https://hackerone.com/lachlan2k)、[sy1vi3](https://hackerone.com/sy1vi3)、[maple3142](https://hackerone.com/maple3142)、[hacktronresearch](https://hackerone.com/hacktronresearch)、[bugra](https://hackerone.com/bugra)、[lonecat](https://hackerone.com/lonecat)、[ryotak](https://hackerone.com/ryotak)、[ch1axan](https://hackerone.com/ch1axan)、[chilaxan](https://hackerone.com/chilaxan)、[cjm00n](https://hackerone.com/cjm00n)、[francisconeves97](https://hackerone.com/francisconeves97)、[phithon](https://hackerone.com/phithon)、[shubs](https://hackerone.com/shubs) 和 [hashkitten](https://hackerone.com/hashkitten)。

This response wouldn't have been possible without our partners:

若无以下合作伙伴的支持，本响应将无法实现：

- **HackerOne** mobilized their team to launch our bug bounty program in under six hours. This process typically takes weeks.

- **HackerOne** 迅速动员团队，在六小时之内即启动了我们的漏洞赏金计划——而该流程通常需耗时数周。

- **Latacora IntrusionOps** provided critical incident response support, helping with triage, validation, and reproduction of submissions as they came in.

- **Latacora IntrusionOps** 提供了关键的事件响应支持，协助我们对陆续提交的漏洞报告进行分类、验证与复现。

Special thanks to [Marten Abrahamsen](https://www.linkedin.com/in/martenabrahamsen), Vercel CFO, for approving the $1 million bounty payout.

特别感谢 Vercel 首席财务官 [Marten Abrahamsen](https://www.linkedin.com/in/martenabrahamsen)，他批准了本次 100 万美元的漏洞赏金发放。