---
title: "Pacific Northwest National Laboratory and OpenAI partner to accelerate federal permitting  | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/pacific-northwest-national-laboratory"
date: "2026-02-26"
scraped_at: "2026-03-02T10:08:16.764017129+00:00"
language: "en-US"
translated: false
description: "OpenAI and Pacific Northwest National Laboratory introduce DraftNEPABench, a new benchmark evaluating how AI coding agents can accelerate federal permitting—showing potential to reduce NEPA drafting..."
tags: ["Global Affairs"]
---

February 26, 2026

[Global Affairs](https://openai.com/news/global-affairs/)

# Pacific Northwest National Laboratory and OpenAI partner to accelerate federal permitting

New benchmark shows potential to reduce infrastructure permitting timelines



Modernizing how the federal government permits critical infrastructure is essential to building a faster, safer, and more competitive U.S. economy. From energy projects and advanced manufacturing to transportation and water systems, permitting determines how quickly promising ideas become real-world investments. Yet today, environmental and technical reviews often take years, which slows innovation, increases costs, and delays the benefits these projects deliver to communities.

That’s why OpenAI has partnered with the U.S. Department of Energy’s Pacific Northwest National Laboratory (PNNL) and its [PermitAI™⁠(opens in a new window)](https://www.pnnl.gov/projects/permitai/) team to evaluate whether coding agents can help effectively accelerate federal permitting work. PermitAI, an initiative funded by the Department of Energy’s Office of Policy, and OpenAI worked together with 19 subject matter experts on the National Environmental Policy Act review process to design a benchmark (called DraftNEPABench) for assessing how well AI models perform on tasks relating to NEPA workflows such as drafting environmental impact statements.

Across a representative set of drafting tasks spanning NEPA document sections from 18 federal agencies, 19 experts found that generalized coding agents have the potential to speed up NEPA document drafting work by as much as 1 to 5 hours per subsection—up to roughly 15% reduction in drafting time—signaling a meaningful step forward in how AI can support complex government workflows.

## Designing a benchmark for real-world permitting work

Federal permitting is a complex and document-heavy process in government. Reviews often require reading hundreds of pages of technical reports, cross-checking information across multiple sources, and drafting detailed analyses that must meet regulatory requirements.

Through this collaboration, [OpenAI and PNNL explored the power⁠(opens in a new window)](https://www.pnnl.gov/sites/default/files/media/file/PREPRINT_PNNL_PolicyAI_DraftNEPABench_OpenAI.pdf) of generalizing coding agents (in this case, Codex CLI) as an effective way to extract performance from reasoning models like GPT‑5 for research, technical analysis, and report writing tasks that involve a file system. By giving models access to a command-line interface (typically used for coding tasks), they can use more general strategies for solving a task than hand-crafted heuristics. These agents are required to:

- Read and accurately synthesize documents spanning hundreds of pages of technical and regulatory content
- Verify facts across multiple environmental, engineering, and regulatory sources
- Draft structured reports that meet highly specified legal and technical criteria

## Why this work matters

For the United States to continue to grow its economy in this [Intelligence Age⁠(opens in a new window)](https://ia.samaltman.com/), it must be able to build safely, responsibly, and quickly. As AI systems increasingly impact the physical world, we must understand their capabilities in domains like civil engineering, environmental, and regulatory analysis. Over time, advanced models will need to understand laws and regulations accurately as they help to invent new and safer technologies, protect natural resources, and meet human needs.

For more than 50 years, the process has required federal agencies to review and document the environmental impacts of projects such as bridges, power plants, transmission lines, and manufacturing facilities. This benchmark helps identify where today’s AI models can responsibly assist humans in accelerating these workflows.

Codex CLI scores across tasks

012345ScoreU.S. Bureau of LandManagementU.S. EnvironmentalProtection AgencyU.S. Army Corps ofEngineersBureau of Ocean EnergyManagementNational Oceanic andAtmosphericAdministrationFederal Energy RegulatoryCommissionU.S. Fish and WildlifeServiceU.S. Nuclear RegulatoryCommissionHawaii Department of Landand Natural ResourcesNational Nuclear SecurityAdministrationU.S. Bureau ofReclamationU.S. Department ofTransportationU.S. Department of theNavyFederal AviationAdministrationU.S. Department of EnergyTennessee ValleyAuthorityAgency3.703.653.613.513.433.343.293.233.203.193.153.123.023.023.002.96

_Mean evaluation scores (1–5 scale) across 102 tasks, grouped by lead agency. Scores aggregate assessments of structure, clarity, accuracy, and references. A score of 1 indicates major deficiencies, 3 indicates a partially correct draft, and a score of 5 indicates a fully correct and complete draft._

In addition to de-risking autonomy, this work can advance the design of better interfaces for experts and AI. Moving beyond static PDFs, coding agents can dynamically generate web-based reports and interactive visualizations from their work that make it easier for human reviewers to validate.

With AI, agencies will be able to review, refine, and approve proposals more efficiently, and government workers will gain leverage from teams of AI agents that handle time-consuming portions of their work so they can focus on judgment, oversight, and complex decision-making. This work aligns with OpenAI’s broader commitment to public service and OpenAI for Government’s goal to equip public servants with tools that make them more effective and supported.

## Limitations

This benchmark evaluates model capability on well-specified drafting tasks where the relevant context is available, not the full ambiguity and discretion of real-world permitting decisions. It emphasizes accuracy and correct reference use to clarify where models could assist human reviewers. When reviewing failure cases, we found some “errors” were actually driven by outdated references and weak evaluation criteria and we had to update the rubrics accordingly. More generally, if source materials are incomplete, inconsistent, or out of date, models may not flag these discrepancies without explicit instructions. Real-world deployments are more likely to involve expert feedback and iteration, which is expected to improve performance beyond what is reported in these self-contained benchmark tasks.

## What’s next

OpenAI is supporting PNNL to further develop and refine solutions for [PermitAI⁠(opens in a new window)](https://www.pnnl.gov/projects/permitai)’s applications, designed to help federal agencies streamline permitting processes. Over time, we expect to see the average time to approval for federally reviewed infrastructure projects fall from months to weeks, accelerating project development and strengthening U.S. competitiveness and supporting long-term economic growth.