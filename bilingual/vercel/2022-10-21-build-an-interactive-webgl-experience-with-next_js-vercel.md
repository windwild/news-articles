---
title: "Build an interactive WebGL experience with Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js"
date: "2022-10-21"
scraped_at: "2026-03-02T09:59:56.294494014+00:00"
language: "en-zh"
translated: true
description: "Use interactive code sandboxes to build the Next.js Conf registration prism game."
---

Oct 21, 2022

2022 年 10 月 21 日

用网页端的 3D 图形渲染 API，将你的创意变为现实。

WebGL 是一种用于在网页浏览器中渲染 3D 图形的 JavaScript API，使开发者能够创建独特而富有表现力的图形效果——这是静态图片所无法企及的。借助 WebGL，我们将原本平淡无奇的会议注册页面，升级为 [沉浸式的 Next.js Conf 注册页](https://nextjs.org/conf/oct22/registration)。

本文将手把手教你如何使用开源 WebGL 工具复现这一体验的核心视觉元素——其中包括 Vercel 工程师专为解决浏览器中 3D 渲染性能难题而开发的一款新工具。

1. [搭建原型](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#1.-put-together-a-prototype)

2. [增强视觉效果](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#2.-enhance-the-visuals)

3. [优化性能](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#3.-optimize-performance)


## 核心创意

在设计构思初期，我们以“3D 渲染”“三角形”“金字塔”“光束”等关键词为提示词，利用 DALL·E 生成了一系列概念图。以下是 DALL·E 输出的部分示例：

![DALL·E 生成的图像的 10 种变体。原始图像同样由 DALL·E 生成。](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_001.jpg)![DALL·E 生成的图像的 10 种变体。原始图像同样由 DALL·E 生成。](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_001.jpg)DALL·E 生成的图像的 10 种变体。原始图像同样由 DALL·E 生成。

At this point, we began discussing the beauty of a rainbow and how it expresses everything that light is capable of in the visible spectrum.  
此时，我们开始探讨彩虹之美，以及它如何展现可见光谱中光所能呈现的一切。

We began tying this idea back to the future of the Web and how we want to help the Web reach its full potential—like the rainbow.  
我们进而将这一理念与 Web 的未来联系起来，思考如何助力 Web 充分释放其潜能——正如彩虹一般。

Our designers settled on a rich, striking mood board:  
我们的设计师最终确定了一组丰富而夺目的情绪板：

![A mood board depicting many of the concepts that led to the creation of the Next.js Conf registration page. Prisms, beams of light, and rainbows create vivid, eye-catching visual elements.¹](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_003.jpg)![A mood board depicting many of the concepts that led to the creation of the Next.js Conf registration page. Prisms, beams of light, and rainbows create vivid, eye-catching visual elements.¹](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_003.jpg)  
![一张情绪板，展现了促成 Next.js Conf 注册页诞生的诸多概念：棱镜、光束与彩虹共同构成鲜明、吸睛的视觉元素。¹](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_003.jpg)![一张情绪板，展现了促成 Next.js Conf 注册页诞生的诸多概念：棱镜、光束与彩虹共同构成鲜明、吸睛的视觉元素。¹](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_003.jpg)  

A mood board depicting many of the concepts that led to the creation of the Next.js Conf registration page. Prisms, beams of light, and rainbows create vivid, eye-catching visual elements.¹  
一张情绪板，展现了促成 Next.js Conf 注册页诞生的诸多概念：棱镜、光束与彩虹共同构成鲜明、吸睛的视觉元素。¹

We also knew we wanted this experience to be **interactive** and [**accessible**](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site).  
我们也明确希望这一体验具备**交互性**，并做到[**无障碍可访问**](https://vercel.com/blog/improving-the-accessibility-of-our-nextjs-site)。

We began discussing how beams of light can reveal hidden particles in the air.  
我们由此展开讨论：光束如何揭示空气中隐藏的微粒。

Putting it all together, the idea became: "What if a user could control a light source to reveal objects in a scene like a light beam does? And what if the light bounced off of other objects, hit a prism, and created a gorgeous rainbow?"  
整合所有这些想法后，核心创意逐渐成形：“如果用户能操控一个光源，像真实光束一样照亮并揭示场景中的物体，会怎样？如果这束光还能从其他物体上反射、再投射到棱镜上，从而生成一道绚丽的彩虹，又会怎样？”

Our next challenge: **how to replicate this in the browser**.  
接下来的挑战是：**如何在浏览器中复现这一效果**。

After looking at [art from the WebGL community](https://docs.pmnd.rs/react-three-fiber/getting-started/examples), we sat down with WebGL to see how we could achieve this effect.  
在参考了[WebGL 社区的艺术作品](https://docs.pmnd.rs/react-three-fiber/getting-started/examples)之后，我们深入研究 WebGL，探索实现该效果的技术路径。

## 1\. Put together a prototype  

## 1. 搭建原型

To build a proof of concept, we reached for a common, open-source set of tooling in the WebGL space. Let's get to know the tools we used so you can build with us.  
为构建概念验证（PoC），我们选用了 WebGL 领域一套常用且开源的工具链。下面让我们一起了解所用工具，以便你也能参与共建。

Two packages from [Poimandres](https://github.com/pmndrs), a developer collective, were key tools for our creative JavaScript project.:  
来自开发者协作组织 [Poimandres](https://github.com/pmndrs) 的两个软件包，成为我们此次创意 JavaScript 项目的关键工具：

- [**react-three-fiber**](https://github.com/pmndrs/react-three-fiber): A library for using three.js in React components (where Vercel engineer Paul Henschel is a lead maintainer)  
- [**react-three-fiber**](https://github.com/pmndrs/react-three-fiber)：一款用于在 React 组件中集成 three.js 的库（Vercel 工程师 Paul Henschel 是该项目的首席维护者）

- [**drei**](https://github.com/pmndrs/drei): A “kitchen sink” library of convenience helpers letting the three.js community share common patterns  
- [**drei**](https://github.com/pmndrs/drei)：一个“一站式”工具库，汇集大量便捷辅助函数，助力 three.js 社区共享通用开发模式

### Getting familiar with `react-three-fiber`  

### 熟悉 `react-three-fiber`

`react-three-fiber` lets developers create and interact with objects in a scene using React components.  
`react-three-fiber` 允许开发者使用 React 组件来创建和交互场景中的对象。

Below is a sandbox to get you started with the basics.  
下方是一个沙盒环境，助您快速上手基础用法。

```
import { useRef, useState } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'

function Box (props) {
  // This reference gives us direct access to the THREE.Mesh object.
  // 此引用使我们能够直接访问 THREE.Mesh 对象。
  const ref = useRef()

  // Hold state for hovered and clicked events.
  // 保存鼠标悬停与点击事件的状态。
  const [hovered, hover] = useState(false)
  const [clicked, click] = useState(false)

  // Subscribe this component to the render-loop and rotate the mesh every frame.
  // 将该组件订阅至渲染循环，使网格每帧自动旋转。
  useFrame((state,delta) => (ref.current.rotation.x += delta))

  // Return the view.
  // 返回视图。
  // These are regular three.js elements expressed in JSX.
  // 这些是用 JSX 表达的标准 three.js 元素。
  return (
    <mesh
      {...props}
      ref={ref}
      scale={clicked ? 1.5 : 1}
      onClick={(event) => click(!clicked)}
      onPointerOver={(event) => hover(true)}
      onPointerOut={(event) => hover(false)}
    >
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={hovered ? 'hotpink' : 'orange' } />
    </mesh>
  )
}

export default function App() {
  return (
    <Canvas>
      <color attach="background" args={['#fff']} />
      <ambientLight intensity={0.5} />
      <spotLight position={[10, 10, 10]} angle={0.15} penumbra={1} />
      <pointLight position={[-10, -10, -10]} />
      <Box position={[-1.2, 0, 0]} />
      <Box position={[1.2, 0, 0]} />
    </Canvas>
  )
}
```

To enter the code editing mode, press Enter. To exit the edit mode, press Escape  
要进入代码编辑模式，请按 Enter 键；要退出编辑模式，请按 Escape 键。

You are editing the code. To exit the edit mode, press Escape  
您正在编辑代码。要退出编辑模式，请按 Escape 键。

Open on CodeSandbox  
在 CodeSandbox 中打开

An interactive code sandbox showing the basics of three.js and how to make two, 3D rotating blocks that spin.

一个交互式代码沙盒，展示 three.js 的基础知识，以及如何创建两个三维旋转立方体。

A few things to try with this sandbox:

在该沙盒中可尝试以下操作：

- Hover a cube to turn it pink

- 将鼠标悬停在立方体上，使其变为粉色

- On line 27, change `hotpink` to `green` and hover the cube again

- 在第 27 行将 `hotpink` 改为 `green`，再次将鼠标悬停在立方体上

- Click a cube to toggle its size

- 点击立方体以切换其尺寸

- Comment out the `<Box />` on line 40 to see the cube on the right disappear

- 注释掉第 40 行的 `<Box />`，观察右侧立方体消失

This brings the power of WebGL and `three.js` to React developers in a way that feels familiar, allowing them to create awesome 3D visuals in the browser. `react-three-fiber` also:

这将 WebGL 和 `three.js` 的强大能力以 React 开发者熟悉的方式带入 React 生态，使他们能够在浏览器中轻松创建惊艳的 3D 视觉效果。`react-three-fiber` 还具备以下特性：

- Has no limitations when compared to raw `three.js`. If you can build it with `three.js`, you can build it with `react-three-fiber`.

- 相较于原生 `three.js`，没有任何功能限制：凡可用 `three.js` 实现的功能，均可通过 `react-three-fiber` 实现。

- Exposes component props like `onRayHit` that can be used to respond to events in your scene similar to native React events (e.g. `onClick`).

- 暴露了类似 `onRayHit` 的组件属性，可用于响应场景中的事件，其使用方式与原生 React 事件（如 `onClick`）高度一致。

- Outperforms `three.js` at scale by leveraging React’s scheduler.

- 借助 React 的调度器（scheduler），在大规模场景下性能优于原生 `three.js`。

With enough practice, a React developer can build remarkable experiences in the browser that are only limited by their imagination.

经过足够的练习，React 开发者便能在浏览器中构建出令人惊叹的交互体验，其上限仅受限于想象力。

### Proving the concept

### 验证概念

Now that we know we can build 3D art with React, let’s create the groundwork for an interactive beam of light that bounces off of objects. Once we have this part figured out, we will have something that resembles the core of the mechanics for the game you played on the Next.js Conf registration page.

既然我们已确认可以使用 React 构建 3D 艺术，接下来就让我们为一条可与物体碰撞反弹的交互式光束打下基础。一旦实现这一部分，我们就将拥有一个与你在 Next.js Conf 注册页面上玩过的游戏核心机制高度相似的雏形。

In your next sandbox, you will find a "light beam" that follows your cursor and reflects off of a few 2D objects in the scene.

在你的下一个沙盒环境中，你将看到一条“光束”——它会跟随你的鼠标移动，并在场景中的若干 2D 物体表面发生反射。

App.jsReflect.jsx

App.jsReflect.jsx

```
import * as THREE from 'three'
import { useRef, useState } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { useTexture } from '@react-three/drei'
import { Reflect } from './Reflect'

export default function App() {
  return (
    <Canvas orthographic camera={{ zoom: 100 }}>
      <color attach="background" args={['#000']} />
      <Scene />
    </Canvas>
  )
}

function Scene() {
  const streaks = useRef()
  const glow = useRef()
  const reflect = useRef()
  const [streakTexture, glowTexture] = useTexture(['https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/1LRW0uiGloWqJcY0WOxREA/61737e55cab34a414d746acb9d0a9400/download.png', 'https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/2NKOrPD3iq75po1v0AA6h2/fc0d49ba0917bcbfd3d8a63688045a0c/download.jpeg'])

 const obj = new THREE.Object3D()
  const f = new THREE.Vector3()
  const t = new THREE.Vector3()
  const n = new THREE.Vector3()

  let i = 0
  let range = 0
```

```javascript
useFrame((state) => {
    reflect.current.setRay([(state.pointer.x * state.viewport.width) / 2, (state.pointer.y * state.viewport.height) / 2, 0])
    range = reflect.current.update()

    for (i = 0; i < range - 1; i++) {
      // Position 1
      f.fromArray(reflect.current.positions, i * 3)
      // Position 2
      t.fromArray(reflect.current.positions, i * 3 + 3)
      // Calculate normal
      n.subVectors(t, f).normalize()
      // Calculate mid-point
      obj.position.addVectors(f, t).divideScalar(2)
      // Stretch by using the distance
      obj.scale.set(t.distanceTo(f) * 3, 6, 1)
      // Convert rotation to euler z
      obj.rotation.set(0, 0, Math.atan2(n.y, n.x))
      obj.updateMatrix()
      streaks.current.setMatrixAt(i, obj.matrix)
    }

    streaks.current.count = range - 1
    streaks.current.instanceMatrix.updateRange.count = (range - 1) * 16
    streaks.current.instanceMatrix.needsUpdate = true

    // First glow isn't shown.
    obj.scale.setScalar(0)
    obj.updateMatrix()
    glow.current.setMatrixAt(0, obj.matrix)

    for (i = 1; i < range; i++) {
      obj.position.fromArray(reflect.current.positions, i * 3)
      obj.scale.setScalar(0.75)
      obj.rotation.set(0, 0, 0)
      obj.updateMatrix()
      glow.current.setMatrixAt(i, obj.matrix)
    }

    glow.current.count = range
    glow.current.instanceMatrix.updateRange.count = range * 16
    glow.current.instanceMatrix.needsUpdate = true
  })

return (
    <>
      <Reflect ref={reflect} far={10} bounce={10} start={[10, 5, 0]} end={[0, 0, 0]}>
        {/* Any object in here will receive ray events */}
        <Block scale={0.5} position={[0.25, -0.15, 0]} />
        <Block scale={0.5} position={[-1.1, .9, 0]} rotation={[0, 0, -1]} />
        <Triangle scale={0.4} position={[-1.1, -1.2, 0]} rotation={[Math.PI / 2, Math.PI, 0]} />
      </Reflect>
      {/* Draw stretched pngs to represent the reflect positions. */}
      <instancedMesh ref={streaks} args={[null, null, 100]} instanceMatrix-usage={THREE.DynamicDrawUsage}>
        <planeGeometry />
        <meshBasicMaterial
          map={streakTexture}
          transparent
          opacity={1}
          blending={THREE.AdditiveBlending}
          depthWrite={false}
          toneMapped={false}
        />
      </instancedMesh>
      {/* Draw glowing dots on the contact points. */}
      <instancedMesh ref={glow} args={[null, null, 100]} instanceMatrix-usage={THREE.DynamicDrawUsage}>
        <planeGeometry />
        <meshBasicMaterial
          map={glowTexture}
          transparent
          opacity={1}
          blending={THREE.AdditiveBlending}
          depthWrite={false}
          toneMapped={false}
        />
      </instancedMesh>
    </>
  )
}

function Block({ onRayOver, ...props }) {
  const [hovered, hover] = useState(false)
  return (
    <mesh onRayOver={(e) => hover(true)} onRayOut={(e) => hover(false)} {...props}>
      <boxGeometry />
      <meshBasicMaterial color={hovered ? 'orange' : 'white'} />
    </mesh>
  )
}

function Triangle({ onRayOver, ...props }) {
  const [hovered, hover] = useState(false)
  return (
    <mesh
      {...props}
      onRayOver={(e) => (e.stopPropagation(), hover(true))}
      onRayOut={(e) => hover(false)}
      onRayMove={(e) => null /*console.log(e.direction)*/}>
      <cylinderGeometry args={[1, 1, 1, 3, 1]} />
      <meshBasicMaterial color={hovered ? 'hotpink' : 'white'} />
    </mesh>
  )
}
```

```javascript
useFrame((state) => {
    reflect.current.setRay([(state.pointer.x * state.viewport.width) / 2, (state.pointer.y * state.viewport.height) / 2, 0])
    range = reflect.current.update()

    for (i = 0; i < range - 1; i++) {
      // 位置 1
      f.fromArray(reflect.current.positions, i * 3)
      // 位置 2
      t.fromArray(reflect.current.positions, i * 3 + 3)
      // 计算法向量
      n.subVectors(t, f).normalize()
      // 计算中点
      obj.position.addVectors(f, t).divideScalar(2)
      // 利用两点间距离进行拉伸
      obj.scale.set(t.distanceTo(f) * 3, 6, 1)
      // 将旋转转换为欧拉角 Z 轴分量
      obj.rotation.set(0, 0, Math.atan2(n.y, n.x))
      obj.updateMatrix()
      streaks.current.setMatrixAt(i, obj.matrix)
    }

    streaks.current.count = range - 1
    streaks.current.instanceMatrix.updateRange.count = (range - 1) * 16
    streaks.current.instanceMatrix.needsUpdate = true

    // 第一个辉光效果不显示。
    obj.scale.setScalar(0)
    obj.updateMatrix()
    glow.current.setMatrixAt(0, obj.matrix)

    for (i = 1; i < range; i++) {
      obj.position.fromArray(reflect.current.positions, i * 3)
      obj.scale.setScalar(0.75)
      obj.rotation.set(0, 0, 0)
      obj.updateMatrix()
      glow.current.setMatrixAt(i, obj.matrix)
    }

    glow.current.count = range
    glow.current.instanceMatrix.updateRange.count = range * 16
    glow.current.instanceMatrix.needsUpdate = true
  })

return (
    <>
      <Reflect ref={reflect} far={10} bounce={10} start={[10, 5, 0]} end={[0, 0, 0]}>
        {/* 此处包含的任意对象都将接收射线事件 */}
        <Block scale={0.5} position={[0.25, -0.15, 0]} />
        <Block scale={0.5} position={[-1.1, .9, 0]} rotation={[0, 0, -1]} />
        <Triangle scale={0.4} position={[-1.1, -1.2, 0]} rotation={[Math.PI / 2, Math.PI, 0]} />
      </Reflect>
      {/* 绘制拉伸后的 PNG 图像，以表示反射路径上的各点位置。 */}
      <instancedMesh ref={streaks} args={[null, null, 100]} instanceMatrix-usage={THREE.DynamicDrawUsage}>
        <planeGeometry />
        <meshBasicMaterial
          map={streakTexture}
          transparent
          opacity={1}
          blending={THREE.AdditiveBlending}
          depthWrite={false}
          toneMapped={false}
        />
      </instancedMesh>
      {/* 在接触点上绘制发光圆点。 */}
      <instancedMesh ref={glow} args={[null, null, 100]} instanceMatrix-usage={THREE.DynamicDrawUsage}>
        <planeGeometry />
        <meshBasicMaterial
          map={glowTexture}
          transparent
          opacity={1}
          blending={THREE.AdditiveBlending}
          depthWrite={false}
          toneMapped={false}
        />
      </instancedMesh>
    </>
  )
}

function Block({ onRayOver, ...props }) {
  const [hovered, hover] = useState(false)
  return (
    <mesh onRayOver={(e) => hover(true)} onRayOut={(e) => hover(false)} {...props}>
      <boxGeometry />
      <meshBasicMaterial color={hovered ? 'orange' : 'white'} />
    </mesh>
  )
}

function Triangle({ onRayOver, ...props }) {
  const [hovered, hover] = useState(false)
  return (
    <mesh
      {...props}
      onRayOver={(e) => (e.stopPropagation(), hover(true))}
      onRayOut={(e) => hover(false)}
      onRayMove={(e) => null /*console.log(e.direction)*/}>
      <cylinderGeometry args={[1, 1, 1, 3, 1]} />
      <meshBasicMaterial color={hovered ? 'hotpink' : 'white'} />
    </mesh>
  )
}
```

You are editing the code. To exit the edit mode, press Escape

你正在编辑代码。要退出编辑模式，请按 Esc 键。

Open on CodeSandbox

在 CodeSandbox 中打开

A code sandbox showing how a strategy to make lines appear more like beams of light.

一个代码沙盒示例，展示了一种让线条看起来更像光束的策略。

Let's break down this sandbox into its key parts so we have a strong foundation to build on.

让我们将这个沙盒拆解为几个关键部分，从而为我们后续的构建打下坚实基础。

- First, the `App` function creates a canvas for the scene to be painted onto. We can set an `orthographic` property to make 2D rendering more simple and create a camera with a set zoom level. We also give the background a dark color.

- 首先，`App` 函数创建了一个用于绘制场景的画布（canvas）。我们可通过设置 `orthographic` 属性来简化 2D 渲染，并创建一个具有固定缩放级别的相机。同时，我们将背景设为深色。

- Next, `Scene` establishes a line that will follow your cursor as you move it. We use `useLayoutEffect` from React and `useFrame`, a custom React hook from `react-three-fiber` that runs every time a new frame is drawn.

- 接着，`Scene` 创建了一条随鼠标移动而实时跟随的线。我们使用了 React 的 `useLayoutEffect`，以及来自 `react-three-fiber` 的自定义 React Hook `useFrame`——该 Hook 在每次渲染新帧时都会执行。

- We also need to draw a few shapes to bounce our light ray. `Block` and `Triangle` are React components that have props for `onRayOver` and `onRayOut` that handle their respective events for the activity of the light beam.

- 我们还需绘制若干几何形状，用以反射光束。`Block` 和 `Triangle` 是两个 React 组件，它们分别接收 `onRayOver` 和 `onRayOut` 属性，用于处理光束与物体交互过程中的悬停与离开事件。

- Last, we'll bring in two `.png` files as textures to create the light beam itself as well as the splash of glow where the light ray intersects with an object. Instead of demanding that WebGL do more rendering work, we can let the browser adjust the position of a `.png` for much better performance.

- 最后，我们将引入两张 `.png` 文件作为纹理：一张用于呈现光束本体，另一张则用于表现光束与物体相交处迸发的辉光效果。相比让 WebGL 承担更多渲染任务，直接由浏览器调整 `.png` 图片的位置可显著提升性能。

The code here is relatively simple for creating 3D graphics, unlocking a world that lets us create more complex elements, interactions, and scenes through the declarative nature of React.

此处的代码在实现 3D 图形方面相对简洁，却由此开启了一个全新世界——借助 React 的声明式特性，我们得以构建更复杂的元素、交互与场景。

Next, let's look at bringing in some color.

接下来，我们来看看如何为场景增添一些色彩。

### Creating a rainbow

### 创建彩虹

We need to produce a rainbow for the final ray exiting the prism. Here, we returned to the open source community for inspiration.

我们需要为最终从棱镜射出的光线生成一道彩虹。在此过程中，我们回归开源社区寻求灵感。

On [shadertoy](https://www.shadertoy.com/), we found two excellent shaders that we thought would combine to create a powerful effect:

在 [Shadertoy](https://www.shadertoy.com/) 上，我们发现了两个非常出色的着色器，认为它们组合起来能产生强大的视觉效果：

- [@alanzucconi](https://twitter.com/AlanZucconi)’s rainbow: [A highly performant visible color spectrum.](https://www.shadertoy.com/view/ls2Bz1)

- [@alanzucconi](https://twitter.com/AlanZucconi) 的彩虹着色器：[高性能可见光谱着色器](https://www.shadertoy.com/view/ls2Bz1)

- Juliapoo’s iridescence: [Amorphous blob creator](https://www.shadertoy.com/view/ltKcWh) to give the rainbow a flowing effect.

- Juliapoo 的虹彩着色器：[无定形色块生成器](https://www.shadertoy.com/view/ltKcWh)，用于赋予彩虹流动般的动态效果。

The combination of these two shaders can be found in the sandbox below:

这两个着色器的组合效果可在下方沙盒中查看：

App.jsRainbow.js

```
import { useRef } from 'react'
import { Canvas, useFrame } from '@react-three/fiber'
import { Rainbow } from './Rainbow'

export default function App() {
  return (
    <Canvas>
      <color attach="background" args={['black']} />
      <Scene />
    </Canvas>
  )
}

function Scene() {
  const ref = useRef()
  useFrame((state, delta) => (ref.current.rotation.z += delta / 5))
  return <Rainbow ref={ref} startRadius={0} endRadius={0.65} fade={0} />
}
```

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

要进入代码编辑模式，请按 Enter 键；要退出编辑模式，请按 Escape 键。

You are editing the code. To exit the edit mode, press Escape

您正在编辑代码。要退出编辑模式，请按 Escape 键。

Open on CodeSandbox

在 CodeSandbox 中打开

A code sandbox showing how two shaders can be brought together to create an iridescent rainbow.

一个代码沙盒示例，展示如何将两个着色器组合起来，生成具有虹彩效果的彩虹。

## 2\. Enhance the visuals

## 2. 提升视觉效果

Often, the end result of heavy graphical computing doesn’t come out perfectly. To create a final, appealing outcome, you can use a postprocessor to execute filters and effects on the render output before it is sent to the browser to be painted on screen.

图形计算密集型任务的最终渲染结果往往并不完美。为获得最终令人满意的视觉效果，您可在渲染结果发送至浏览器并绘制到屏幕之前，借助后处理（postprocessor）对输出执行各类滤镜与特效。

For `three.js` projects, postprocessing is typically considered a must and can enhance visuals tremendously. For this project we used:

对于 `three.js` 项目而言，后处理通常被视为必备环节，可极大提升画面表现力。本项目中我们使用了以下工具：

- [react-postprocessing](https://github.com/pmndrs/postprocessing): Another package from Poimandres, this library can save developers hundreds of lines of code for usual postprocessing tasks.

- [react-postprocessing](https://github.com/pmndrs/postprocessing)：Poimandres 团队开发的另一款库，可为常规后处理任务节省开发者数百行代码。

- [screen-space-reflections](https://github.com/0beqz/screen-space-reflections): This package captures existing screen data and uses it to create reflections.

- [screen-space-reflections](https://github.com/0beqz/screen-space-reflections)：该库捕获当前屏幕数据，并利用这些数据生成屏幕空间反射效果。

`react-postprocessing` is a popular alternative to the three.js `EffectComposer` method due to its performance benefits. Most notably, `EffectComposer` merges all effects into a single one, minimizing the number of render operations.

得益于其性能优势，`react-postprocessing` 已成为 `three.js` 原生 `EffectComposer` 方案的主流替代选择。其中最显著的特点是：`EffectComposer` 将所有后处理效果合并为单次渲染流程，从而大幅减少渲染操作次数。

For our postprocessing, we used three different effects:

我们的后处理使用了三种不同的效果：

- [Bloom](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#bloom): Give bright areas a glowing effect

- [Bloom（泛光）](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#bloom)：为高亮区域添加发光效果

- [Color Lookup Table](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#color-lookup-table): Achieve a desired color range

- [颜色查找表（Color Lookup Table）](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#color-lookup-table)：实现目标色彩范围

- [Screen Space Reflections](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#screen-space-reflections): Create reflections of existing graphical data

- [屏幕空间反射（Screen Space Reflections）](https://vercel.com/blog/building-an-interactive-webgl-experience-in-next-js#screen-space-reflections)：基于现有图形数据生成反射效果

### Bloom

### 泛光（Bloom）

Bloom is an effect that puts light fringes around the brightest spots of an image. In digital art, this shader is mimicking the natural effect of real-life camera lenses when reacting to bright light. A camera lens can’t perfectly handle areas of bright light in an image and ends up distributing this light across the rest of the image, creating a halo effect.

泛光是一种在图像最亮区域周围添加光晕边缘的视觉效果。在数字艺术中，该着色器旨在模拟真实相机镜头在强光照射下产生的自然光学现象：镜头无法完美聚焦于图像中的高亮区域，导致部分光线向周围扩散，从而形成光晕（halo）效果。

An example of a bloom post-processor. The bright lights in the triangular prism and rainbow light beam gain an aura effect when the bloom effect is activated.

一个泛光后处理器的示例：当启用泛光效果时，三角棱镜和彩虹光束中的明亮光源会呈现出明显的光晕（aura）效果。

In our case, this shader brings extra life to the bright parts of the light refracting through the prism as well as the beams of white light being mixed into the rainbow.

在本项目中，该着色器进一步增强了光线经棱镜折射后所产生的高亮区域，以及混入彩虹中的白色光束的视觉表现力。

### Color Lookup Tables

### 颜色查找表（Color Lookup Tables）

Color Lookup Tables (often abbreviated as LUT) are a method for filtering an original set of colors to a new range for the entire rendered image.

颜色查找表（Color Lookup Table，常缩写为 LUT）是一种将原始色彩集整体映射至新色彩范围的图像滤镜方法，适用于整幅渲染图像。

(1000/560)

The WebGL render before and after a Color Lookup Table has been applied. The imagery is switching back and forth between a green hue to a blue hue.

应用颜色查找表（Color Lookup Table，LUT）前后的 WebGL 渲染效果。画面在绿色色调与蓝色色调之间反复切换。

For this project, we used the LUT to give the scene a more blue and cinematic look. If you don't want to dial in the colors yourself, premade LUTs are available from resources like [IWLTBAP](https://luts.iwltbap.com/).

本项目中，我们使用 LUT 为场景赋予更偏蓝、更具电影感的视觉风格。若您不想手动精细调整色彩，可从 [IWLTBAP](https://luts.iwltbap.com/) 等资源网站获取现成的 LUT 文件。

### Screen Space Reflections

### 屏幕空间反射（Screen Space Reflections）

Screen Space Reflections were used to make the scene look more dynamic by having the environment reflected within the prism.

我们采用屏幕空间反射技术，使场景更具动态感——环境内容被实时反射到棱镜内部。

(2422/1346)

A screenshot of the Next.js 2022 registration page. The prism is illuminated by the white, glowing blocks that redirect the light source because they are placed quite close to it.

Next.js 2022 注册页面的截图。棱镜由白色发光方块照亮；这些方块因紧邻光源而起到重定向光线的作用。

Reflections like these can be calculated through a process called “raymarching”. In [raymarching](https://gamedev.stackexchange.com/questions/67719/how-do-raymarch-shaders-work), every pixel on the screen that can have a reflection is calculated, step-by-step, to see where the best point of reflection exists, according to the original point of interest. This process is rather resource intensive so we limited these reflections to only the prism and, additionally, turned them off entirely for mobile devices.

此类反射可通过一种名为“光线行进（raymarching）”的技术进行计算。在 [raymarching](https://gamedev.stackexchange.com/questions/67719/how-do-raymarch-shaders-work) 中，对屏幕上每一个可能产生反射的像素，逐步追踪其反射路径，以确定相对于原始观察点的最佳反射位置。该过程计算开销较大，因此我们将反射效果限定于棱镜本身，并进一步在移动设备上完全禁用该效果。

This shader noticeably reflects the rainbow within the prism—but will also reflect other objects like the mirror boxes and the light ray itself when those objects are in the right positions.

该着色器清晰地呈现了棱镜内部的彩虹效果——同时，当镜面方块或光束本身处于合适位置时，也会将它们一并反射出来。

![A screenshot of the Next.js 2022 registration page. The prism is illuminated by the white, glowing blocks that redirect the light source because they are placed quite close to it.](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_005.jpg)![A screenshot of the Next.js 2022 registration page. The prism is illuminated by the white, glowing blocks that redirect the light source because they are placed quite close to it.](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_005.jpg)A screenshot of the Next.js 2022 registration page. The prism is illuminated by the white, glowing blocks that redirect the light source because they are placed quite close to it.

![Next.js 2022 注册页面截图：棱镜由白色发光方块照亮；这些方块因紧邻光源而起到重定向光线的作用。](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_005.jpg)![Next.js 2022 注册页面截图：棱镜由白色发光方块照亮；这些方块因紧邻光源而起到重定向光线的作用。](images/build-an-interactive-webgl-experience-with-next_js-vercel/img_005.jpg)Next.js 2022 注册页面的截图。棱镜由白色发光方块照亮；这些方块因紧邻光源而起到重定向光线的作用。

### All together now

### 现在，将一切整合起来

We now have:

我们现在拥有：

- A ray of light

- 一束光线

- Objects to bounce it off of

- 可供光线反射的物体

- A prism

- 一个棱镜

- And a rainbow

- 以及一道彩虹

It's time to put it all together. We've added one last touch for the prism, a beveled model from `drei` on the prism to give it a final bit of detail.

现在是时候将所有元素整合起来了。我们为棱镜添加了最后一处细节：使用 `drei` 库提供的倒角（beveled）模型，使棱镜呈现出更精致的外观。

App.js Reflect.js Box.js Rainbow.js Beam.js Prism.js Flare.js

```
import * as THREE from 'three'
import { useRef, useCallback, useState } from 'react'
import { Canvas, useLoader, useFrame } from '@react-three/fiber'
import { Center, Text3D } from '@react-three/drei'
import { Bloom, EffectComposer, LUT } from '@react-three/postprocessing'
import { LUTCubeLoader } from 'postprocessing'
import { Beam } from './components/Beam'
import { Rainbow } from './components/Rainbow'
import { Prism } from './components/Prism'
import { Flare } from './components/Flare'
import { Box } from './components/Box'

export function lerp(object, prop, goal, speed = 0.1) {
  object[prop] = THREE.MathUtils.lerp(object[prop], goal, speed)
}
```

```javascript
const vector = new THREE.Vector3()
export function lerpV3(value, goal, speed = 0.1) {
  value.lerp(vector.set(...goal), speed)
}

const vector = new THREE.Vector3()
export function lerpV3(value, goal, speed = 0.1) {
  value.lerp(vector.set(...goal), speed)
}

export function calculateRefractionAngle(incidentAngle, glassIor = 2.5, airIor = 1.000293) {
  const theta = Math.asin((airIor * Math.sin(incidentAngle)) / glassIor) || 0
  return theta
}

export function calculateRefractionAngle(incidentAngle, glassIor = 2.5, airIor = 1.000293) {
  const theta = Math.asin((airIor * Math.sin(incidentAngle)) / glassIor) || 0
  return theta
}

export default function App() {
  const texture = useLoader(LUTCubeLoader, 'https://uploads.codesandbox.io/uploads/user/b3e56831-8b98-4fee-b941-0e27f39883ab/DwlG-F-6800-STD.cube')

  return (
    <Canvas orthographic gl={{ antialias: false }} camera={{ position: [0, 0, 100], zoom: 70 }}>
      <color attach="background" args={['black']} />
      <Scene />
      <EffectComposer disableNormalPass>
        <Bloom mipmapBlur levels={9} intensity={1.5} luminanceThreshold={1} luminanceSmoothing={1} />
        <LUT lut={texture} />
      </EffectComposer>
    </Canvas>
  )
}

export default function App() {
  const texture = useLoader(LUTCubeLoader, 'https://uploads.codesandbox.io/uploads/user/b3e56831-8b98-4fee-b941-0e27f39883ab/DwlG-F-6800-STD.cube')

  return (
    <Canvas orthographic gl={{ antialias: false }} camera={{ position: [0, 0, 100], zoom: 70 }}>
      <color attach="background" args={['black']} />
      <Scene />
      <EffectComposer disableNormalPass>
        <Bloom mipmapBlur levels={9} intensity={1.5} luminanceThreshold={1} luminanceSmoothing={1} />
        <LUT lut={texture} />
      </EffectComposer>
    </Canvas>
  )
}

function Scene() {
  const [isPrismHit, hitPrism] = useState(false)
  const flare = useRef(null)
  const ambient = useRef(null)
  const spot = useRef(null)
  const boxreflect = useRef(null)
  const rainbow = useRef(null)

  const rayOut = useCallback(() => hitPrism(false), [])
  const rayOver = useCallback((e) => {
    // Break raycast so the ray stops when it touches the prism.
    e.stopPropagation()
    hitPrism(true)
    // Set the intensity really high on first contact.
    rainbow.current.material.speed = 1
    rainbow.current.material.emissiveIntensity = 20
  }, [])

  const vec = new THREE.Vector3()
  const rayMove = useCallback(({ api, position, direction, normal }) => {
    if (!normal) return
    // Extend the line to the prisms center.
    vec.toArray(api.positions, api.number++ * 3)
    // Set flare.
    flare.current.position.set(position.x, position.y, -0.5)
    flare.current.rotation.set(0, 0, -Math.atan2(direction.x, direction.y))

    // Calculate refraction angles.
    let angleScreenCenter = Math.atan2(-position.y, -position.x)
    const normalAngle = Math.atan2(normal.y, normal.x)

    // The angle between the ray and the normal.
    const incidentAngle = angleScreenCenter - normalAngle

    // Calculate the refraction for the incident angle.
    const refractionAngle = calculateRefractionAngle(incidentAngle) * 6

函数 Scene() {
  const [isPrismHit, hitPrism] = useState(false)
  const flare = useRef(null)
  const ambient = useRef(null)
  const spot = useRef(null)
  const boxreflect = useRef(null)
  const rainbow = useRef(null)

  const rayOut = useCallback(() => hitPrism(false), [])
  const rayOver = useCallback((e) => {
    // 中断射线检测，使射线在接触棱镜时停止。
    e.stopPropagation()
    hitPrism(true)
    // 首次接触时将发光强度设为极高值。
    rainbow.current.material.speed = 1
    rainbow.current.material.emissiveIntensity = 20
  }, [])

  const vec = new THREE.Vector3()
  const rayMove = useCallback(({ api, position, direction, normal }) => {
    if (!normal) return
    // 将线段延伸至棱镜中心。
    vec.toArray(api.positions, api.number++ * 3)
    // 设置光晕位置。
    flare.current.position.set(position.x, position.y, -0.5)
    flare.current.rotation.set(0, 0, -Math.atan2(direction.x, direction.y))

    // 计算折射角。
    let angleScreenCenter = Math.atan2(-position.y, -position.x)
    const normalAngle = Math.atan2(normal.y, normal.x)

    // 入射光线与法向量之间的夹角。
    const incidentAngle = angleScreenCenter - normalAngle

    // 根据入射角计算折射角。
    const refractionAngle = calculateRefractionAngle(incidentAngle) * 6
```

```markdown
    // Apply the refraction.
    // 应用折射效果。
    angleScreenCenter += refractionAngle
    rainbow.current.rotation.z = angleScreenCenter

    // Set spot light.
    // 设置聚光灯。
    lerpV3(spot.current.target.position, [Math.cos(angleScreenCenter), Math.sin(angleScreenCenter), 0], 0.05)
    spot.current.target.updateMatrixWorld()
  }, [])

  useFrame((state) => {
    // Tie beam to the mouse.
    // 将光束绑定到鼠标位置。
    boxreflect.current.setRay([(state.pointer.x * state.viewport.width) / 2, (state.pointer.y * state.viewport.height) / 2, 0], [0, 0, 0])

    // Animate rainbow intensity.
    // 动画化彩虹的发光强度。
    lerp(rainbow.current.material, 'emissiveIntensity', isPrismHit ? 2.5 : 0, 0.1)
    spot.current.intensity = rainbow.current.material.emissiveIntensity

    // Animate ambience.
    // 动画化环境光强度。
    lerp(ambient.current, 'intensity', 0, 0.025)
  })

  return (
    <>
      {/* Lights */}
      {/* 灯光 */}
      <ambientLight ref={ambient} intensity={0} />
      <pointLight position={[10, -10, 0]} intensity={0.05} />
      <pointLight position={[0, 10, 0]} intensity={0.05} />
      <pointLight position={[-10, 0, 0]} intensity={0.05} />
      <spotLight ref={spot} intensity={1} distance={7} angle={1} penumbra={1} position={[0, 0, 1]} />
      {/* Prism + blocks + reflect beam */}
      {/* 棱镜 + 方块 + 反射光束 */}
      <Beam ref={boxreflect} bounce={10} far={20}>
        <Prism scale={.6} position={[0, -0.5, 0]} onRayOver={rayOver} onRayOut={rayOut} onRayMove={rayMove} />
      <Box position={[-1.4, 1, 0]} rotation={[0, 0, Math.PI / 8]} />
      <Box position={[-2.4, -1, 0]} rotation={[0, 0, Math.PI / -4]} />
      </Beam>
      {/* Rainbow and flares */}
      {/* 彩虹与光晕效果 */}
      <Rainbow ref={rainbow} startRadius={0} endRadius={0.5} fade={0} />
      <Flare ref={flare} visible={isPrismHit} renderOrder={10} scale={1.25} streak={[12.5, 20, 1]} />
    </>
  )
}
```

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

You are editing the code. To exit the edit mode, press Escape

Open on CodeSandbox

## 3. Optimize performance

## 3. 优化性能
```

This rendering looks great but we also have to consider something else important: performance.

这种渲染效果看起来很棒，但我们也必须考虑另一件同样重要的事情：性能。

Building up all of these great effects can take a toll on device resources. We noticed that older devices were starting to have trouble, and, after going through lots of tweaks and variations, we still had reports coming in that performance was an issue.

构建所有这些精美的视觉效果会对设备资源造成较大负担。我们注意到，一些较老的设备已开始出现卡顿问题；即便经过大量参数调整和方案迭代，我们仍持续收到用户反馈，指出性能仍是瓶颈。

The usual approach to handling device performance in the WebGL community has been to watch GPU utilization. However, this is known to be fraught with buggy behavior since different devices calculate GPU usage differently. This would cause some devices to under- or over-render according to their perceived resource usage.

WebGL 社区中处理设备性能的常规做法是监控 GPU 利用率。然而，这种方法众所周知存在诸多缺陷——不同设备计算 GPU 使用率的方式各不相同，导致某些设备会因“感知到”的资源占用过高或过低，而出现渲染不足或过度渲染的问题。

### Building a new performance monitor

### 构建一款全新的性能监控器

Instead of monitoring resource utilization, we asked “Why not check on the final result of the rendered application to address what our users are actually seeing?”

我们没有选择监控资源利用率，而是提出一个问题：“为什么不直接检查渲染应用的最终输出效果，从而真实反映用户实际看到的内容？”

`drei` now features [a <PerformanceMonitor /> component](https://github.com/pmndrs/drei#performancemonitor) that watches the frames per second (FPS) of the render to see if it is performing within a developer-defined acceptable range. If the FPS drops too low, the application can be made to ease the characteristics of the render to reduce the workload. If the FPS is high and the application can offer a better render, the rendering will improve.

`drei` 现已内置 [`<PerformanceMonitor />`](https://github.com/pmndrs/drei#performancemonitor) 组件，该组件通过实时监测渲染帧率（FPS），判断当前渲染性能是否处于开发者设定的可接受范围内。若 FPS 过低，应用可自动降低渲染复杂度以减轻负载；若 FPS 充足且系统具备余力，渲染质量则会相应提升。

This adaptive approach is a major improvement compared to sniffing GPU utilization or forcing a user to choose a quality level. Here is a code example of how the Performance Monitor works:

这种自适应策略相比依赖 GPU 利用率探测，或强制用户手动选择画质等级，是一项重大进步。以下是 Performance Monitor 的代码使用示例：

```jsx
import { PerformanceMonitor, usePerformanceMonitor } from '@react-three/drei'

import { EffectComposer } from '@react-three/postprocessing'
```

4// 将用于渲染的后处理效果。

function Effects() {

6  // 一个用于开启或关闭效果的开关。

7  const [hasEffects, setHasEffects] = useState(true)



9  // 对 onChange 参数进行回调解构。

10  // `factor` 是当前的质量缩放因子，取值范围为 0 到 1。

11  usePerformanceMonitor({ onChange: ({ factor }) => {

12    // 如果当前已启用效果，且

13    // 缩放因子高于平均水平……

14    if (hasEffects && factor > 0.5) {

14    如果存在特效且 factor 大于 0.5，则：

15      // ...decrease quality.

15      // ……降低画质。

16      effect.qualityScale = round(0.5 + 0.5 * factor, 1)

16      effect.qualityScale = round(0.5 + 0.5 * factor, 1)

17    }



17    }


19    // Handle other conditions

19    // 处理其他条件

20    // when PerformanceMonitor says

20    // 当 PerformanceMonitor 指示

21    // to decline or incline

21    // 需要降低或提升性能时

23  }})

23  }})

25  return (

25  返回（

26    <EffectComposer>

26    <EffectComposer>

27      { /** Your effects */ }

27      { /** 您的效果 */ }

28    </EffectComposer>

28    </EffectComposer>

29  )

29  ）

30}



30} 



function App() {

function App() {

33  // Starting out with the highest resolution,

33  // 首先使用最高分辨率，

34  // reduce the resolution if the framerate is too low.

34  // 如果帧率过低，则降低分辨率。

35  const [dpr, setDpr] = useState(2)

35  const [dpr, setDpr] = useState(2)

37  return (

37  return (

38    <Canvas dpr={dpr}>

38    <Canvas dpr={dpr}>

39      <PerformanceMonitor

39      <PerformanceMonitor

40        onDecline={() => setDpr(1.5)}

40        onDecline={() => setDpr(1.5)}

41        onIncline={() => setDpr(2)}

41        onIncline={() => setDpr(2)}

42      >

42      >

43        <Scene />

43        <Scene />

44        <Effects />

44        <效果组件 />

45      </PerformanceMonitor />

45      </性能监控组件 />

46    </Canvas>

46    </画布组件 />

47  )

47  )

48}
```

48}
```

## See it live

## 实时体验

[Check out the Next.js conference registration page](https://nextjs.org/conf/oct22/registration) for the full experience—and don’t forget to claim your free ticket while you’re there. Can you collect all three tickets by playing the games?

[查看 Next.js 大会注册页面](https://nextjs.org/conf/oct22/registration)，亲身体验完整效果——别忘了顺手领取你的免费门票！你能否通过参与游戏集齐全部三张门票呢？

¹ _We'd like to give a thanks to outside contributors to our mood board, including artists like Davo Galavotti._

¹ _我们衷心感谢为情绪板（mood board）提供支持的外部贡献者，包括艺术家 Davo Galavotti 等。_