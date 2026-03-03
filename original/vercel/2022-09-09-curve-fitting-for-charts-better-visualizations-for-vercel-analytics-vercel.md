---
title: "Curve fitting for charts: better visualizations for Vercel Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/curve-fitting-for-charts-better-visualizations-for-vercel-analytics"
date: "2022-09-09"
scraped_at: "2026-03-02T10:00:40.947144230+00:00"
language: "en"
translated: false
description: "How we made your Vercel Analytics data more actionable to drive performance for your application."
---




Sep 9, 2022

Last month, we released [improved accuracy for Vercel Analytics charts](https://vercel.com/changelog/improved-accuracy-for-vercel-analytics-charts)—making it easier to visualize trends over time. This initially began as a side project I worked on during Vercel's Design Your Friday program (on the first Friday of every month, we work on a project of our choice). The goal: improving the data visualization of our Analytics charts.

Let's dig deep on this new change.

## Before and after

Previously, all the data points were visualized by simply connecting them as a line.

![It is difficult to find trends in a graph with a lot of noise.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_001.jpg)![It is difficult to find trends in a graph with a lot of noise.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_002.jpg)![It is difficult to find trends in a graph with a lot of noise.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_001.jpg)![It is difficult to find trends in a graph with a lot of noise.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_002.jpg)It is difficult to find trends in a graph with a lot of noise.

It’s hard to read the **trend** from that chart because it’s too noisy. And the delta showed a `-0.15` decrease which felt wrong. With the improvement I made, it now uses a smooth curve to visualize the trend and measures the delta more accurately.

![A best fit line shows the graph's trend at a glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_005.jpg)![A best fit line shows the graph's trend at a glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_006.jpg)![A best fit line shows the graph's trend at a glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_005.jpg)![A best fit line shows the graph's trend at a glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_006.jpg)A best fit line shows the graph's trend at a glance.

## The challenge

There are two main challenges in the old visualization.

1. It displays **all** data points on the chart and this makes the chart noisy.

2. The delta shown was calculated by subtracting the last and first sampled data—which is unreasonable for this dataset.


![The first and final points of the graph don't tell an accurate story for the whole dataset.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_009.jpg)The first and final points of the graph don't tell an accurate story for the whole dataset.

While the chart says `-0.15`, all the data in between was completely ignored. As long as the most recent data point shows improvement, the chart will conclude that my website is performing better. The difference between the first and final endpoints of the chart could be two users who happen to have very different network connections—but that doesn't tell the whole story about our site performance.

We want the insights that you receive from these charts to be accurate, easy to parse, and actionable. What can we do to make this chart tell a more authentic story?

## A better way

After some research, I found that [curve fitting](https://en.wikipedia.org/wiki/Curve_fitting) is a simple way to solve both problems. We use a curve to represent the overall trend of our data in a time series—with as little noise as possible.

To demonstrate, I built an example that uses [the palmerpenguins dataset](https://allisonhorst.github.io/palmerpenguins/) to visualize the relationship between the bill length and depth of sampled penguins. It’s a bit noisy just like our previous Analytics chart.

[![The palmerspenguins dataset is quite random and trends may not be obvious at first glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_010.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)

[View data on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)

If you already know the type of curve that you are looking for, there are many existing algorithms to calculate the fitting curve for a given set of data points. The easiest way is to do a [linear regression](https://en.wikipedia.org/wiki/Linear_regression)—finding a straight line to describe the data.

[![A linear regression can give a quick and naive trend for a chart.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_011.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

Linear regression is just a special case of [polynomial regression](https://en.wikipedia.org/wiki/Polynomial_regression) where the order is 1. You can drag the slider above to see how different polynomial orders affect the fitting curve. When the **order** is N, the polynomial function will have a degree of N, and the curve will have N-1 turning points (so 1 is a straight line).

The [Mean Squared Error (MSE)](https://en.wikipedia.org/wiki/Mean_squared_error) value (`Σ(value - predictedValue)^2 / dataNum`) measures the "goodness" of the fit of the curve to the data. The smaller the error is, the better the curve describes the given data.

Usually, the easy solution would be manually choosing a reasonable order and hardcoding it in our visualization. That’s what a lot of people do and, in most cases, it should be okay. However, when we don’t know the behavior of the data (is it constantly increasing or decreasing? is it periodic?), it’s hard to choose a good order.

As you might notice, a **higher order** will result in a more “accurate” curve with a **lower error** in general—but it also results in a more noisy curve. It can turn the curve too many times to follow our data because of all the noise. This is called [overfitting](https://en.wikipedia.org/wiki/Overfitting).

You can play with the example below [on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1): it generates fake data points with some normal distributed randomness and then calculates the regression curve for it. For the “Constant” dataset, it’s better to just use a straight line to fit (`order = 1`). However, for the “Quadratic” dataset, selecting `order = 2` will result in a more stable, better fitting curve.

[![A quadratic dataset with an order of 2.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_012.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

## The "good" fit

All the examples so far show a “bad fit” or an “overfit” curve. It might describe the **current** dataset well, but, when you regenerate the data, it will not describe the **new** data accurately.

This is a very foundational concept in Machine Learning and Data Science—to split the data into a **training set** and a **test set**. The training set (the **current** data) is used to train the model and calculate the regression curve, and the test set ( **newly** generated data) is used to evaluate how well the model works. A good fit for the training set should have a low error on the test set, too.

In our real-world problem, we don’t actually have a training set and a test set (we don’t generate random data) and all we have are the numbers collected from production. But we can choose some data points as the training set, and the remaining ones become the test set. To make the algorithm deterministic, I split our data points by odd and even indexes.

[![Finding "best fit" using a training set and a test set.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_013.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

As shown in the example above, we use the **training set** to calculate the fitting curve and measure the error for both the **training set** and  **test set**. If you increase the order, the curve tries to follow the  points, but the gray lines show the error for points.

Ideally, a good fit should have a low error for both datasets. We will use a simple but intuitive equation **error = max(MSE(training set), MSE(test set))** to measure the “overall goodness” of the fit for the entire dataset. Usually, when we increase the order of the polynomial regression, the error will decrease (underfitting), hit a good fit, then increase again (overfitting).

[![A chart showing "best fit" gives us a value of 2.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_014.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

[View data on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

This chart shows the overall error `max(MSE(training set), MSE(test set))` when the polynomial regression order increases. It’s clear that when the order is 2, we have the best fit for the data—which is what we can feel intuitively from the interactive example.

Finally, we can use that regression curve for the actual visualization and estimation. This adaptive approach is simple, easy to implement, and turned out to work really well for our case.

## Try it out

To try out this new change, enable [Vercel Analytics](https://vercel.com/analytics) today by visiting the Analytics tab in your project dashboard or [try it free with a team on Vercel Pro](https://vercel.com/signup?next=/dashboard?createTeam=true).