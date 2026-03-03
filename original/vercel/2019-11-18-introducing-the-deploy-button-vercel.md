---
title: "Introducing the Deploy Button - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-button"
date: "2019-11-18"
scraped_at: "2026-03-02T10:07:26.367247848+00:00"
language: "en"
translated: false
description: "Make your project deployable with the click of a button."
---




Nov 18, 2019

Share your custom templates as one-click deployments.

As the author of an open source project or framework, one of your key focuses is making it as easy as possible for users to get started with your creation.

With the help of today's feature release, you can now reduce this entire process down to the click of a single button: The Vercel Deploy Button.

## What's new

To offer your users an easy way to deploy your code to production (and keep updating it afterward), you can now [create your own Deploy Button](https://vercel.com/docs/more/deploy-button).

After clicking "Deploy", you will be asked to confirm the destination and project name, under which a [Next.js](https://zeit.co/solutions/nextjs) template from the [Next.js examples list](https://github.com/zeit/next.js/tree/canary/examples/hello-world) will be forked and deployed.

![The interface for selecting the destination of your deployment.](images/introducing-the-deploy-button-vercel/img_001.jpg)The interface for selecting the destination of your deployment.

## Creating Git repositories

You might also want to create a GitHub or GitLab repository. To accomplish this, you only need to select the "Create Git repository" option on the Deploy button flow.

![The interface for creating a Git repository for your new project.](images/introducing-the-deploy-button-vercel/img_002.jpg)The interface for creating a Git repository for your new project.

We will automatically create the Git repository for you, once you click deploy, and push the source files of your freshly created deployment.

## Get your own

Using the button for your own project is as easy as copying our default markdown snippet and replacing the URL of the Git repository:

```bash
1[![Deploy with Vercel](images/introducing-the-deploy-button-vercel/img_003.jpg)](https://vercel.com/new/project?template=https://github.com/zeit/now-examples/tree/master/nextjs)
```

A button that deploys the \`nextjs\` directory of the zeit/now-examples repository.

For an example written in HTML, make sure to check out the feature's [documentation](https://zeit.co/docs/v2/more/deploy-button/).

## Conclusion

Our Deploy Button lets your users easily deploy your code to Vercel.

It is ideal for scenarios where customers have not interacted with our platform before, but works just as well if they already have an account.

With this release, we hope to empower open source maintainers and enable faster deployment workflows for the people enjoying their creations.

[Let us know what you think](mailto:support@vercel.com) about this change!