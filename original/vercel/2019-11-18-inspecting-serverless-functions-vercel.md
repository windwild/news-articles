---
title: "Inspecting Serverless Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/functions-tab"
date: "2019-11-18"
scraped_at: "2026-03-02T10:07:23.490962318+00:00"
language: "en"
translated: false
description: " Get insight into your Serverless Functions with the new \"Functions\" dashboard tab."
---




Nov 18, 2019

After deploying a static frontend to Vercel, some projects might make use of Serverless Functions to feed data from.

Creating Serverless Functions is as simple as adding an [API directory](https://zeit.co/docs/v2/serverless-functions/introduction/) in your project, and today inspecting them became just as comfortable with the new "Functions" tab from your Deployment Overview.

## Function Details

Creating a blazing fast web app is not only a matter of having a static frontend, but also of ensuring your API is not bloated in size, does not consume too many computational resources, and is responding fast.

All of this information can now be accessed in a "Functions" tab available from every deployment overview.

![The most important details about your Serverless Functions, all at one glance.](images/inspecting-serverless-functions-vercel/img_001.jpg)The most important details about your Serverless Functions, all at one glance.

## Realtime Requests

Often it's necessary to follow along with the invocations – and the logs printed as a result – of your Serverless Functions to detect inconsistencies in their behavior.

With the new "Functions" tab, this information is now only a click away.

![A real-time stream of all requests targeting your Serverless Function.](images/inspecting-serverless-functions-vercel/img_002.jpg)A real-time stream of all requests targeting your Serverless Function.

## Failed Requests

Once your Serverless Functions are running in production, it is a vital focus of every developer to ensure they will continue smoothly, without interruption.

To make this process easier, we now also show Failed Requests right in the UI.

![A list of all requests that have not succeeded in the past.](images/inspecting-serverless-functions-vercel/img_003.jpg)A list of all requests that have not succeeded in the past.

In this section, all requests from which your Serverless Function has thrown an unexpected error will be stored and displayed for up to 30 days.

## Conclusion

Thanks to the new **Functions** tab on the dashboard, retrieving the most crucial details about your Serverless Functions is now easier than ever.

This is just another one of several features we are planning to launch to support advanced use cases of Serverless Functions on Vercel.

[Let us know what you think](mailto:support@vercel.com) about this change!