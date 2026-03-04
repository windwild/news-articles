---
title: "Curve fitting for charts: better visualizations for Vercel Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/curve-fitting-for-charts-better-visualizations-for-vercel-analytics"
date: "2022-09-09"
scraped_at: "2026-03-02T10:00:40.947144230+00:00"
language: "en-zh"
translated: true
description: "How we made your Vercel Analytics data more actionable to drive performance for your application."
---
&#123;% raw %}

Sep 9, 2022

2022 年 9 月 9 日

上个月，我们发布了 [Vercel Analytics 图表准确性的改进](https://vercel.com/changelog/improved-accuracy-for-vercel-analytics-charts)，使随时间变化的趋势更易于可视化。这一改进最初源于我在 Vercel “Design Your Friday”（每月第一个星期五）活动中开展的一个个人项目——在这一天，我们可自由选择感兴趣的项目进行开发。该项目的目标是提升 Analytics 图表的数据可视化效果。

让我们深入探讨此次更新的具体内容。

## 改进前与改进后

此前，所有数据点仅通过简单地用直线连接来呈现。

![噪声过多的图表中难以识别趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_001.jpg)![噪声过多的图表中难以识别趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_002.jpg)![噪声过多的图表中难以识别趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_001.jpg)![噪声过多的图表中难以识别趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_002.jpg)噪声过多的图表中难以识别趋势。

从该图表中很难读取**趋势**，因为数据过于嘈杂；且显示的变动值为 `-0.15`（下降），这显然有悖直觉。经我此次优化后，系统改用平滑曲线来呈现趋势，并能更精准地测算变动值（delta）。

![最佳拟合线可一目了然地展现图表趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_005.jpg)![最佳拟合线可一目了然地展现图表趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_006.jpg)![最佳拟合线可一目了然地展现图表趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_005.jpg)![最佳拟合线可一目了然地展现图表趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_006.jpg)最佳拟合线可一目了然地展现图表趋势。

## 面临的挑战

旧版可视化方案存在两大主要挑战。

1. It displays **all** data points on the chart and this makes the chart noisy.

1. 它在图表中显示了**全部**数据点，这使得图表显得杂乱无章。

2. The delta shown was calculated by subtracting the last and first sampled data—which is unreasonable for this dataset.

2. 所显示的差值（delta）是通过用最后一个采样数据减去第一个采样数据得出的——这对本数据集而言是不合理的。

![The first and final points of the graph don't tell an accurate story for the whole dataset.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_009.jpg)  
![图表的起始点与终点无法准确反映整个数据集的情况。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_009.jpg)  

The first and final points of the graph don't tell an accurate story for the whole dataset.

图表的起始点与终点无法准确反映整个数据集的情况。

While the chart says `-0.15`, all the data in between was completely ignored. As long as the most recent data point shows improvement, the chart will conclude that my website is performing better. The difference between the first and final endpoints of the chart could be two users who happen to have very different network connections—but that doesn't tell the whole story about our site performance.

尽管图表显示为 `-0.15`，但其间所有中间数据却完全被忽略了。只要最新一个数据点显示出改善趋势，图表就会断定我的网站性能正在提升。而图表首尾两个端点之间的差异，可能仅仅源于两位网络连接条件截然不同的用户——但这远不足以说明我们网站整体的性能表现。

We want the insights that you receive from these charts to be accurate, easy to parse, and actionable. What can we do to make this chart tell a more authentic story?

我们希望您从这些图表中获得的洞察是准确、易于理解且具备可操作性的。那么，我们该如何改进这张图表，使其讲述一个更真实、更有说服力的故事？

## A better way

## 更优的方案

After some research, I found that [curve fitting](https://en.wikipedia.org/wiki/Curve_fitting) is a simple way to solve both problems. We use a curve to represent the overall trend of our data in a time series—with as little noise as possible.

经过一些研究，我发现[曲线拟合（curve fitting）](https://en.wikipedia.org/wiki/Curve_fitting)是一种简单有效的方法，可同时解决上述两个问题。我们借助一条曲线来表征时间序列数据的整体趋势——尽可能减少噪声干扰。

To demonstrate, I built an example that uses [the palmerpenguins dataset](https://allisonhorst.github.io/palmerpenguins/) to visualize the relationship between the bill length and depth of sampled penguins. It’s a bit noisy just like our previous Analytics chart.

为便于演示，我构建了一个示例，使用[palmerpenguins 数据集](https://allisonhorst.github.io/palmerpenguins/)来可视化所采样企鹅喙长（bill length）与喙深（bill depth）之间的关系。该数据集同样存在一定程度的随机性，正如我们此前的 Analytics 图表一样。

[![The palmerspenguins dataset is quite random and trends may not be obvious at first glance.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_010.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)  
[![palmerpenguins 数据集具有较强的随机性，趋势在初看之下并不明显。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_010.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)

[View data on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)  
[在 Observable 上查看数据](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear)

If you already know the type of curve that you are looking for, there are many existing algorithms to calculate the fitting curve for a given set of data points. The easiest way is to do a [linear regression](https://en.wikipedia.org/wiki/Linear_regression)—finding a straight line to describe the data.

如果你已经知道所要拟合的曲线类型，那么已有大量现成算法可用于根据给定的数据点集计算拟合曲线。最简单的方法是进行[线性回归（Linear Regression）](https://en.wikipedia.org/wiki/Linear_regression)——即寻找一条直线来描述这些数据。

[![A linear regression can give a quick and naive trend for a chart.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_011.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

[![线性回归可为图表提供快速而粗略的趋势。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_011.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

[在 Observable 上与该图表交互](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression)

Linear regression is just a special case of [polynomial regression](https://en.wikipedia.org/wiki/Polynomial_regression) where the order is 1. You can drag the slider above to see how different polynomial orders affect the fitting curve. When the **order** is N, the polynomial function will have a degree of N, and the curve will have N−1 turning points (so 1 is a straight line).

线性回归只是[多项式回归（Polynomial Regression）](https://en.wikipedia.org/wiki/Polynomial_regression)的一个特例，其阶数（order）为 1。你可以拖动上方的滑块，观察不同多项式阶数对拟合曲线的影响。当阶数为 **N** 时，多项式函数的次数也为 N，其曲线将具有 N−1 个拐点（因此阶数为 1 时即为一条直线）。

The [Mean Squared Error (MSE)](https://en.wikipedia.org/wiki/Mean_squared_error) value (`Σ(value - predictedValue)^2 / dataNum`) measures the "goodness" of the fit of the curve to the data. The smaller the error is, the better the curve describes the given data.

[均方误差（Mean Squared Error, MSE）](https://en.wikipedia.org/wiki/Mean_squared_error) 值（`Σ(value − predictedValue)² / dataNum`）用于衡量曲线对数据的拟合“优度”。误差越小，说明该曲线对给定数据的描述越准确。

Usually, the easy solution would be manually choosing a reasonable order and hardcoding it in our visualization. That’s what a lot of people do and, in most cases, it should be okay. However, when we don’t know the behavior of the data (is it constantly increasing or decreasing? is it periodic?), it’s hard to choose a good order.

通常，一种简便的做法是人工选定一个合理的阶数，并将其硬编码到可视化逻辑中。许多人正是这样做的；在大多数情况下，这种做法也完全可行。然而，当我们不了解数据的行为特征时（例如：数据是否持续递增或递减？是否具有周期性？），就很难选择一个合适的阶数。

As you might notice, a **higher order** will result in a more “accurate” curve with a **lower error** in general—but it also results in a more noisy curve. It can turn the curve too many times to follow our data because of all the noise. This is called [overfitting](https://en.wikipedia.org/wiki/Overfitting).

你可能已经注意到，**更高的阶数**通常会带来“更精确”的拟合曲线和**更低的误差**——但同时也会导致曲线更加嘈杂。由于数据中存在噪声，高阶多项式可能使曲线过度弯曲、频繁转向，反而偏离了数据的真实趋势。这种现象称为[过拟合（Overfitting）](https://en.wikipedia.org/wiki/Overfitting)。

You can play with the example below [on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1): it generates fake data points with some normal distributed randomness and then calculates the regression curve for it. For the “Constant” dataset, it’s better to just use a straight line to fit (`order = 1`). However, for the “Quadratic” dataset, selecting `order = 2` will result in a more stable, better fitting curve.

你可以在下方示例中亲自尝试：[在 Observable 上运行该示例](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)。该示例会生成一组带正态分布随机扰动的模拟数据点，并为其计算回归曲线。对于“常数型（Constant）”数据集，仅使用一条直线拟合（`order = 1`）效果最佳；而对于“二次型（Quadratic）”数据集，选择 `order = 2` 则能得到更稳定、拟合效果更优的曲线。

[![A quadratic dataset with an order of 2.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_012.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

[![阶数为 2 的二次型数据集。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_012.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

[在 Observable 上与该图表交互](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#RegressionLinear1)

## The "good" fit

## “良好拟合”

All the examples so far show a “bad fit” or an “overfit” curve. It might describe the **current** dataset well, but, when you regenerate the data, it will not describe the **new** data accurately.

截至目前的所有示例均展示了“欠拟合”或“过拟合”的曲线。这类曲线或许能较好地描述**当前**数据集，但当你重新生成数据时，它将无法准确刻画**新**数据。

This is a very foundational concept in Machine Learning and Data Science—to split the data into a **training set** and a **test set**. The training set (the **current** data) is used to train the model and calculate the regression curve, and the test set ( **newly** generated data) is used to evaluate how well the model works. A good fit for the training set should have a low error on the test set, too.

这是机器学习与数据科学中一个极为基础的概念：将数据划分为**训练集**（training set）和**测试集**（test set）。训练集（即**当前**数据）用于训练模型并计算回归曲线；而测试集（即**新生成**的数据）则用于评估模型的实际表现。对训练集实现良好拟合的模型，也应在测试集上保持较低的误差。

In our real-world problem, we don’t actually have a training set and a test set (we don’t generate random data) and all we have are the numbers collected from production. But we can choose some data points as the training set, and the remaining ones become the test set. To make the algorithm deterministic, I split our data points by odd and even indexes.

在我们的真实问题中，并不存在天然划分好的训练集与测试集（我们并不会随机生成数据），所有可用数据均来自生产环境的实际采集。但我们仍可人为选取部分数据点作为训练集，其余数据点则构成测试集。为确保算法具有确定性，我按数据点索引的奇偶性进行划分。

[![Finding "best fit" using a training set and a test set.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_013.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

[![使用训练集与测试集寻找“最优拟合”。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_013.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

[Interact with this chart on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

[在 Observable 上与该图表交互](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#Regression1)

As shown in the example above, we use the **training set** to calculate the fitting curve and measure the error for both the **training set** and  **test set**. If you increase the order, the curve tries to follow the  points, but the gray lines show the error for points.

如上例所示，我们利用**训练集**计算拟合曲线，并分别度量其在**训练集**和**测试集**上的误差。若持续提高多项式阶数，曲线将愈发贴近各数据点；而图中灰色线段则表示对应数据点的误差。

Ideally, a good fit should have a low error for both datasets. We will use a simple but intuitive equation **error = max(MSE(training set), MSE(test set))** to measure the “overall goodness” of the fit for the entire dataset. Usually, when we increase the order of the polynomial regression, the error will decrease (underfitting), hit a good fit, then increase again (overfitting).

理想情况下，“良好拟合”应同时在两个数据集上都保持较低误差。我们将采用一个简洁而直观的公式：**误差 = max(MSE(训练集), MSE(测试集))**，来衡量整个数据集上拟合效果的“整体优劣”。通常，随着多项式回归阶数的提升，误差会先下降（欠拟合阶段），继而达到一个较优值（良好拟合），之后再度上升（过拟合阶段）。

[![A chart showing "best fit" gives us a value of 2.](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_014.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

[![一张图表显示“最优拟合”对应的阶数值为 2。](images/curve-fitting-for-charts-better-visualizations-for-vercel-analytics-vercel/img_014.jpg)](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

[View data on Observable](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

[在 Observable 上查看数据](https://observablehq.com/@shu/plot-regression?oetm_referrer=https%3A%2F%2Fshud.in%2F&oetm_route=%2F%40shu%2Fplot-regression#error)

This chart shows the overall error `max(MSE(training set), MSE(test set))` when the polynomial regression order increases. It’s clear that when the order is 2, we have the best fit for the data—which is what we can feel intuitively from the interactive example.

该图表展示了多项式回归阶数增加时的整体误差 `max(MSE(训练集), MSE(测试集))`。显然，当阶数为 2 时，模型对数据的拟合效果最佳——这一点我们也能从交互式示例中直观地感受到。

Finally, we can use that regression curve for the actual visualization and estimation. This adaptive approach is simple, easy to implement, and turned out to work really well for our case.

最后，我们可以利用该回归曲线进行实际的可视化与估计。这种自适应方法简单易实现，且在我们的实际场景中表现非常出色。

## Try it out

## 立即体验

To try out this new change, enable [Vercel Analytics](https://vercel.com/analytics) today by visiting the Analytics tab in your project dashboard or [try it free with a team on Vercel Pro](https://vercel.com/signup?next=/dashboard?createTeam=true).

如需体验这一新功能，请立即启用 [Vercel Analytics](https://vercel.com/analytics)：前往项目仪表板中的 “Analytics”（分析）标签页，或 [通过 Vercel Pro 免费为团队试用](https://vercel.com/signup?next=/dashboard?createTeam=true)。
&#123;% endraw %}
