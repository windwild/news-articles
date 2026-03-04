---
title: "Improving verifiability in AI development | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/improving-verifiability"
date: "2020-04-16"
scraped_at: "2026-03-02T10:27:19.179377902+00:00"
language: "en-US"
translated: false
description: "We’ve contributed to a multi-stakeholder report by 58 co-authors at 30 organizations, including the Centre for the Future of Intelligence, Mila, Schwartz Reisman Institute for Technology and So..."
tags: ["Research"]
---
&#123;% raw %}

April 16, 2020


# Improving verifiability in AI development

[Read paper(opens in a new window)](https://arxiv.org/abs/2004.07213)

![Improving Verifiability](images/improving-verifiability-in-ai-development-openai/img_001.webp)

Illustration: Justin Jay Wang



We’ve contributed to a multi-stakeholder report by [58 co-authors⁠](https://openai.com/index/improving-verifiability/#authors) at 30 organizations, including the [Centre for the Future of Intelligence⁠(opens in a new window)](http://lcfi.ac.uk/), [Mila⁠(opens in a new window)](https://mila.quebec/en/), [Schwartz Reisman Institute for Technology and Society⁠(opens in a new window)](https://sr-institute.utoronto.ca/), [Center for Advanced Study in the Behavioral Sciences⁠(opens in a new window)](https://casbs.stanford.edu/), and [Center for Security and Emerging Technologies⁠(opens in a new window)](https://cset.georgetown.edu/). This report describes 10 mechanisms to improve the verifiability of claims made about AI systems. Developers can use these tools to provide evidence that AI systems are safe, secure, fair, or privacy-preserving. Users, policymakers, and civil society can use these tools to evaluate AI development processes.

While a growing number of organizations have articulated ethics principles to guide their AI development process, it can be difficult for those outside of an organization to verify whether the organization’s AI systems reflect those principles in practice. This ambiguity makes it harder for stakeholders such as users, policymakers, and civil society to scrutinize AI developers’ claims about properties of AI systems and could fuel competitive corner-cutting, increasing social risks and harms. The report describes existing and potential mechanisms that can help stakeholders grapple with questions like:

- Can I (as a user) verify the claims made about the level of privacy protection guaranteed by a new AI system I’d like to use for machine translation of sensitive documents?
- Can I (as a regulator) trace the steps that led to an accident caused by an autonomous vehicle? Against what standards should an autonomous vehicle company’s safety claims be compared?
- Can I (as an academic) conduct impartial research on the risks associated with large-scale AI systems when I lack the computing resources of industry?
- Can I (as an AI developer) verify that my competitors in a given area of AI development will follow best practices rather than cut corners to gain an advantage?

The 10 mechanisms highlighted in the report are listed below, along with recommendations aimed at advancing each one. (See the [report⁠(opens in a new window)](https://arxiv.org/abs/2004.07213) for discussion of how these mechanisms support verifiable claims as well as relevant caveats about our findings.)

**Institutional Mechanisms and Recommendations**

1. **Third party auditing**. A coalition of stakeholders should create a task force to research options for conducting and funding third party auditing of AI systems.
2. **Red teaming exercises**. Organizations developing AI should run red teaming exercises to explore risks associated with systems they develop, and should share best practices and tools.
3. **Bias and safety bounties**. AI developers should pilot bias and safety bounties for AI systems to strengthen incentives and processes for broad-based scrutiny of AI systems.
4. **Sharing of AI incidents**. AI developers should share more information about AI incidents, including through collaborative channels.

**Software Mechanisms and Recommendations**

1. **Audit trails**. Standard setting bodies should work with academia and industry to develop audit trail requirements for safety-critical applications of AI systems.
2. **Interpretability**. Organizations developing AI and funding bodies should support research into the interpretability of AI systems, with a focus on supporting risk assessment and auditing.
3. **Privacy-preserving machine learning**. AI developers should develop, share, and use suites of tools for privacy-preserving machine learning that include measures of performance against common standards.

**Hardware Mechanisms and Recommendations**

1. **Secure hardware for machine learning**. Industry and academia should work together to develop hardware security features for AI accelerators or otherwise establish best practices for the use of secure hardware (including secure enclaves on commodity hardware) in machine learning contexts.
2. **High-precision compute measurement**. One or more AI labs should estimate the computing power involved in a single project in great detail and report on lessons learned regarding the potential for wider adoption of such methods.
3. **Compute support for academia**. Government funding bodies should substantially increase funding for computing power resources for researchers in academia, in order to improve the ability of those researchers to verify claims made by industry.

We and our co-authors will be doing further research on these mechanisms and OpenAI will be looking to adopt several of these mechanisms in the future. We hope that this report inspires meaningful dialogue, and we are eager to discuss additional institutional, software, and hardware mechanisms that could be useful in enabling trustworthy AI development. We encourage anyone interested in collaborating on these issues to connect with the corresponding authors and visit the [report website⁠(opens in a new window)](http://www.towardtrustworthyai.com/).

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)

## Report authors, equal contribution

[Miles Brundage⁠](mailto:miles@openai.com) (OpenAI) [Shahar Avin⁠](mailto:sa478@cam.ac.uk) (Centre for the Study of Existential Risk, Leverhulme Centre for the Future of Intelligence) [Jasmine Wang⁠](mailto:jasminewang76@gmail.com) (Mila, University of Montreal) [Haydn Belfield⁠](mailto:hb492@cam.ac.uk) (Centre for the Study of Existential Risk, Leverhulme Centre for the Future of Intelligence) [Gretchen Krueger⁠](mailto:gretchen@openai.com) (OpenAI)

## Report authors, descending contribution

Gillian Hadfield (OpenAI, University of Toronto, Schwartz Reisman Institute for Technology and Society)Heidy Khlaaf (Adelard)Jingying Yang (Partnership on AI)Helen Toner (Center for Security and Emerging Technology)Ruth Fong (University of Oxford)Tegan Maharaj (Mila, Montreal Polytechnic)Pang Wei Koh (Stanford University)Sara Hooker (Google Brain)Jade Leung (Future of Humanity Institute)Andrew Trask (University of Oxford)Emma Bluemke (University of Oxford)Jonathan Lebensold (Mila, McGill University)Cullen O’Keefe (OpenAI)Mark Koren (Stanford Centre for AI Safety)Théo Ryffel (École Normale Supérieure \[Paris\])JB Rubinovitz (Remedy.AI)Tamay Besiroglu (University of Cambridge)Federica Carugati (Center for Advanced Study in the Behavioral Sciences)Jack Clark (OpenAI)Peter Eckersley (Partnership on AI)Sarah de Haas (Google Research)Maritza Johnson (Google Research)Ben Laurie (Google Research)Alex Ingerman (Google Research)Igor Krawczuk (École Polytechnique Fédérale de Lausanne)Amanda Askell (OpenAI)Rosario Cammarota (Intel)Andrew Lohn (RAND Corporation)David Krueger (Mila, Montreal Polytechnic)Charlotte Stix (Eindhoven University of Technology)Peter Henderson (Stanford University)Logan Graham (University of Oxford)Carina Prunkl (Future of Humanity Institute)Bianca Martin (OpenAI)Elizabeth Seger (University of Cambridge)Noa Zilberman (University of Oxford)Seán Ó hÉigeartaigh (Leverhulme Centre for the Future of Intelligence, Centre for the Study of Existential Risk)Frens Kroeger (Coventry University)Girish Sastry (OpenAI)Rebecca Kagan (Center for Security and Emerging Technology)Adrian Weller (University of Cambridge, Alan Turing Institute)Brian Tse (Future of Humanity Institute, Partnership on AI)Elizabeth Barnes (OpenAI)Allan Dafoe (Future of Humanity Institute)Paul Scharre (Center for a New American Security)Ariel Herbert-Voss (OpenAI)Martijn Rasser (Center for a New American Security)Shagun Sodhani (Mila, University of Montreal)Carrick Flynn (Center for Security and Emerging Technology)Thomas Gilbert (University of California, Berkeley)Lisa Dyer (Partnership on AI)Saif Khan (Center for Security and Emerging Technology)Yoshua Bengio (Mila, University of Montreal)Markus Anderljung (Future of Humanity Institute)

## Related articles

[View all](https://openai.com/news/publication/)

![Democratic Inputs To AI Grant Program Update](images/improving-verifiability-in-ai-development-openai/img_002.jpg)

[Democratic inputs to AI grant program: lessons learned and implementation plans\\
\\
SafetyJan 16, 2024](https://openai.com/index/democratic-inputs-to-ai-grant-program-update/)

![Practices For Governing Agentic AI Systems](images/improving-verifiability-in-ai-development-openai/img_003.jpg)

[Practices for Governing Agentic AI Systems\\
\\
PublicationDec 14, 2023](https://openai.com/index/practices-for-governing-agentic-ai-systems/)

![Confidence-Building Measures for Artificial Intelligence Workshop proceedings](images/improving-verifiability-in-ai-development-openai/img_004.png)

[Confidence-Building Measures for Artificial Intelligence: Workshop proceedings\\
\\
ConclusionAug 1, 2023](https://openai.com/index/confidence-building-measures-for-artificial-intelligence/)

Improving verifiability in AI development \| OpenAI
&#123;% endraw %}
