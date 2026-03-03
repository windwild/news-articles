---
title: "Building an interactive 3D event badge with React Three Fiber - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-an-interactive-3d-event-badge-with-react-three-fiber"
date: "2024-04-17"
scraped_at: "2026-03-02T09:45:35.188024792+00:00"
language: "en-zh"
translated: true
description: "See a full working demo of how we built the interactive Vercel Ship '24 badge using React Three Fiber and react-three-rapier."
---

Apr 17, 2024

2024 年 4 月 17 日

In this post, we’ll look at how we made the dropping lanyard for the [Vercel Ship 2024 site](https://vercel.com/ship), diving into the inspiration, tech stack, and code behind the finished product.

本文将介绍我们如何为 [Vercel Ship 2024 网站](https://vercel.com/ship) 制作下落式挂绳动画，深入探讨其创意灵感、技术栈选型以及最终实现背后的代码细节。

## Inspiration

## 创意灵感

We’ve shared digital tickets for event attendance in the past, but this time, we wanted to take it one step further by creating a tangible experience.

过去我们曾向参会者分发数字门票，但这一次，我们希望更进一步，打造一种可感知、可触摸的体验。

When [Studio Basement](https://basement.studio/) made a video in Blender that depicted a virtual badge dropping down, we liked the idea of it so much that we started to wonder whether we could make it interactive and run it in the browser.

当 [Studio Basement](https://basement.studio/) 使用 Blender 制作了一段虚拟徽章自上而下坠落的视频时，我们非常喜爱这一创意，随即开始思考：能否将其变为可交互的网页体验，并直接在浏览器中运行？

Ultimately, we wanted a highly shareable element that rewards the user for signing up and makes it worth their time.

最终，我们希望打造一个极具传播性的互动元素——它既能作为用户完成注册的奖励，又能切实提升用户的参与价值与时间回报感。

## The stack

## 技术栈

To accomplish the task, we chose the following stack:

为实现这一目标，我们选用了以下技术栈：

- Blender, to prepare and optimize the original models for the web  
- Blender：用于准备并优化原始三维模型，使其适配网页环境  

- React and [React Three Fiber](https://github.com/pmndrs/react-three-fiber), which is a reactive, declarative renderer for [Three.js](https://threejs.org/)  
- React 与 [React Three Fiber](https://github.com/pmndrs/react-three-fiber)：后者是面向 [Three.js](https://threejs.org/) 的响应式、声明式渲染器

- [Drei](https://github.com/pmndrs/drei)，一个面向 React 中 Three.js 生态的组件与工具函数集合。

- [`react-three-rapier`](https://github.com/pmndrs/react-three-rapier)，一个基于 [Dimforge Rapier 物理引擎](https://rapier.rs/) 的声明式物理库。

- [MeshLine](https://github.com/pmndrs/meshline)，一种基于着色器（shader）实现的粗线渲染方案。

尽管我们即将介绍的某些概念可能看起来并不熟悉，但请不要因此感到压力。实际实现仅约 80 行代码，且绝大部分为声明式写法，仅需少量数学运算。

请先查看以下沙盒示例，以了解我们将要构建的内容：

App.js　index.js　styles.css

要进入代码编辑模式，请按 Enter 键；要退出编辑模式，请按 Escape 键。

您当前正在编辑代码。要退出编辑模式，请按 Escape 键。

99

1

2

2

3

3

4

4

5

5

6

6

7

7

8

8

9

9

10

10

11

11

12

12

13

13

14

14

15

15

16

16

17

17

18

18

19

19

20

20

21

21

22

22

23

23

24

24

25

25

26

26

27

27

28

28

29

29

30

30

31

31

32

32

33

33

34

34

35

35

36

36

```javascript
import * as THREE from 'three'
```

```javascript
import * as THREE from 'three'
```

```javascript
import { useRef, useState } from 'react'
```

```javascript
import { useRef, useState } from 'react'
```

```javascript
import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'
```

```javascript
import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'
```

```javascript
import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'
```

```javascript
import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'
```

```javascript
import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

```javascript
import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

```javascript
extend({MeshLineGeometry, MeshLineMaterial})
```

```javascript
扩展({MeshLineGeometry, MeshLineMaterial})
```

```javascript
export default function App() {
  return (
    <Canvas camera={{ position: [0, 0, 13], fov: 25 }}>
      <Physics debug interpolate gravity={[0, -40, 0]} timeStep={1 / 60}>
        <Band />
      </Physics>
    </Canvas>
  );
}
```

```javascript
export default function App() {
  return (
    <Canvas camera={{ position: [0, 0, 13], fov: 25 }}>
      <Physics debug interpolate gravity={[0, -40, 0]} timeStep={1 / 60}>
        <Band />
      </Physics>
    </Canvas>
  );
}
```

```javascript
functionBand(){

functionBand() {

constband = useRef(),fixed = useRef(),j1 = useRef(),j2 = useRef(),j3 = useRef(),card = useRef()// prettier-ignore

const band = useRef(), fixed = useRef(), j1 = useRef(), j2 = useRef(), j3 = useRef(), card = useRef(); // prettier-ignore

constvec = newTHREE.Vector3(),ang = newTHREE.Vector3(),rot = newTHREE.Vector3(),dir = newTHREE.Vector3()// prettier-ignore

const vec = new THREE.Vector3(), ang = new THREE.Vector3(), rot = new THREE.Vector3(), dir = new THREE.Vector3(); // prettier-ignore

const{width,height} = useThree((state)=>state.size)

const { width, height } = useThree((state) => state.size);

const\[curve\] = useState(()=>newTHREE.CatmullRomCurve3(\[newTHREE.Vector3(),newTHREE.Vector3(),newTHREE.Vector3(),newTHREE.Vector3()\]))

const [curve] = useState(() => new THREE.CatmullRomCurve3([new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()]));

const\[dragged,drag\] = useState(false)

const [dragged, drag] = useState(false);

useRopeJoint(fixed,j1,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useRopeJoint(fixed, j1, [[0, 0, 0], [0, 0, 0], 1]); // prettier-ignore

useRopeJoint(j1,j2,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useRopeJoint(j1, j2, [[0, 0, 0], [0, 0, 0], 1]); // prettier-ignore

useRopeJoint(j2,j3,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useRopeJoint(j2, j3, [[0, 0, 0], [0, 0, 0], 1]); // prettier-ignore

useSphericalJoint(j3,card,\[\[0,0,0\],\[0,1.45,0\]\])// prettier-ignore

useSphericalJoint(j3, card, [[0, 0, 0], [0, 1.45, 0]]); // prettier-ignore
```

```javascript
useFrame((state, delta) => {

  if (dragged) {

    vec.set(state.pointer.x, state.pointer.y, 0.5).unproject(state.camera);

    dir.copy(vec).sub(state.camera.position).normalize();

    vec.add(dir.multiplyScalar(state.camera.position.length()));

    [card, j1, j2, j3, fixed].forEach((ref) => ref.current?.wakeUp());

  }
});
```

```javascript
useFrame((state, delta) => {

  如果正在拖拽（dragged 为 true）：

    将向量 vec 设为屏幕坐标 (state.pointer.x, state.pointer.y, 0.5)，再通过 unproject 方法将其反投影到世界空间中（相对于相机 state.camera）；

    将方向向量 dir 设为从相机位置指向该世界坐标的向量，并归一化；

    将 vec 沿 dir 方向延伸，延伸距离为相机到原点的距离（即 state.camera.position.length()）；

    遍历数组 [card, j1, j2, j3, fixed]，对每个 ref 调用其 current?.wakeUp() 方法（唤醒物理体）。

  }
});
```

Open on CodeSandbox

在 CodeSandbox 中打开

## Building a rough draft

## 编写初稿

The basic imports we need revolve around our canvas, physics, and the thick line for the lanyard:

我们需要的基本导入模块主要涉及画布（canvas）、物理引擎（physics），以及用于挂绳（lanyard）的粗线组件：

App.js

App.js

```jsx
import * as THREE from 'three'

import { useRef, useState } from 'react'

import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'

import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'

import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

为了在 React 中使用原生 Three.js 的 `MeshLine` 库，我们需要[对其进行扩展](https://docs.pmnd.rs/react-three-fiber/api/objects#using-3rd-party-objects-declaratively)。`extend` 函数用于扩展 React Three Fiber 所识别的 JSX 元素目录。以这种方式添加的组件即可在场景图（scene graph）中通过驼峰命名法引用，方式与内置原语（如 `<mesh>`）一致：

App.js

```jsx
extend({ MeshLineGeometry, MeshLineMaterial })
```

### 设置画布（Canvas）

### Setting up the canvas

现在我们可以设置一个基础画布。我们需要 React Three Fiber 提供的 `<Canvas>` 组件——它是通往声明式 Three.js 的入口。同时，我们还需添加一个 `<Physics>` 提供器（provider），以便将几何形状与物理系统绑定；在 Rapier 中，这类具备物理特性的对象称为 `<RigidBody>`。

With this, we have everything we need:

有了这些，我们就拥有了所需的一切：

App.js

```jsx
export default function App() {

2  return (

3    <Canvas>

4      <Physics>

5        {/* ... */}

6      </Physics>

7    </Canvas>

8  )

9}
```

## The band component

## 带状组件

Now let’s make the band happen. We need a couple of references to access them later on. The canvas size is important for `meshline`, and a `THREE.CatmullRomCurve3` helps us to calculate a smooth curve with just a few points. We only need four points for the physics joints:

现在让我们实现带状结构。我们需要几个引用，以便后续访问它们。画布尺寸对 `meshline` 至关重要，而 `THREE.CatmullRomCurve3` 可帮助我们仅用少量控制点就计算出一条平滑曲线。物理关节仅需四个点：

App.js

App.js

```jsx
function Band() {

2  // References for the band and the joints

3  const band = useRef()

4  const fixed = useRef()

5  const j1 = useRef()

6  const j2 = useRef()
```

2  // 带状结构及关节的引用

3  const band = useRef()

4  const fixed = useRef()

5  const j1 = useRef()

6  const j2 = useRef()

7  const j3 = useRef()

7  const j3 = useRef()

8  // Canvas size

8  // 画布尺寸

9  const { width, height } = useThree((state) => state.size)

9  const { width, height } = useThree((state) => state.size)

10  // A Catmull-Rom curve

10  // 一条 Catmull-Rom 曲线

11  const [curve] = useState(() => new THREE.CatmullRomCurve3([\
\
12    new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()\
\
13  ]))

11  const [curve] = useState(() => new THREE.CatmullRomCurve3([\
\
12    new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()\
\
13  ]))

### Defining the physics joints

### 定义物理关节

A joint is a physics constraint that tells the engine how shapes interact with one another. We’ll now start to connect the joints, and we’ll later define a fixed `<RigidBody>` that cannot move.

关节是一种物理约束，用于告知物理引擎各个形状之间如何相互作用。接下来我们将开始连接这些关节，并稍后定义一个不可移动的固定 `<RigidBody>`。

We hang the first joint on the `useRopeJoint` the Rapier provides (there are a lot of different constraints for rotations, distances, etc.). The other joints will hang on each other. Basically, we will have made a chain that hangs on a fixed point.

我们将第一个关节挂载到 Rapier 提供的 `useRopeJoint` 上（Rapier 提供了多种约束类型，适用于旋转、距离等不同场景）。其余关节则彼此挂载。本质上，我们将构建一条悬挂在固定点上的链。

`useRopeJoint` requires two `<RigidBody>` references:

`useRopeJoint` 需要两个 `<RigidBody>` 引用：

1. Two anchor points for each (we’re using `[0, 0, 0]`, which is the center point)

1. 每个刚体各需一个锚点（我们使用 `[0, 0, 0]`，即坐标原点）

2. 一个长度（我们使用 `1`）

2. 一个长度（我们使用 `1`）

Our rope is ready to swing!

我们的绳子已准备就绪，可以摆动！

App.js

App.js

```jsx
1  useRopeJoint(fixed, j1, [[0, 0, 0], [0, 0, 0], 1])

2  useRopeJoint(j1, j2, [[0, 0, 0], [0, 0, 0], 1])

3  useRopeJoint(j2, j3, [[0, 0, 0], [0, 0, 0], 1])
```

### Creating a curve

### 创建一条曲线

Rapier will now move the joints along an invisible rope, and we can feed our [Catmull-Rom curve](https://threejs.org/docs/#api/en/extras/curves/CatmullRomCurve3) the positions of these joints. We let it make a smooth, interpolated curve with 32 points and forward that to the `meshline`.

Rapier 现在会沿着一根不可见的绳子移动这些关节，而我们可以将这些关节的位置传入我们的 [Catmull-Rom 曲线](https://threejs.org/docs/#api/en/extras/curves/CatmullRomCurve3)。我们让它生成一条平滑插值的曲线，共包含 32 个点，并将该曲线传递给 `meshline`。

We do this at runtime at 60 or 120 FPS, depending on the monitor’s refresh rate. React Three Fiber gives us an out to handle frame-based animations with the `useFrame` Hook:

我们根据显示器的刷新率，在运行时以 60 或 120 FPS 的帧率执行此操作。React Three Fiber 通过 `useFrame` Hook 提供了一种处理基于帧动画的便捷方式：

```jsx
1  useFrame(() => {

2    curve.points[0].copy(j3.current.translation())

3    curve.points[1].copy(j2.current.translation())

4    curve.points[2].copy(j1.current.translation())

5    curve.points[3].copy(fixed.current.translation())

6    band.current.geometry.setPoints(curve.getPoints(32))

7  })
```

```jsx
1  useFrame(() => {

2    曲线.points[0].copy(j3.current.translation())

3    曲线.points[1].copy(j2.current.translation())

4    曲线.points[2].copy(j1.current.translation())

5    曲线.points[3].copy(fixed.current.translation())

6    band.current.geometry.setPoints(曲线.getPoints(32))

7  })
```

### The view

### 视图

Now we need the view. It consists of the fixed `<RigidBody type="fixed">`, three `<RigidBody>`'s for the joints (`j1`, `j2`, and `j3`), and the `meshline` that we extended above. The joints are positioned in a way that makes them fall down with a slight swing:

现在我们需要构建视图。它包含一个固定的 `<RigidBody type="fixed">`、三个用于关节的 `<RigidBody>`（即 `j1`、`j2` 和 `j3`），以及上文已扩展的 `meshline`。这些关节的位置经过精心设置，使其在重力作用下自然下落，并伴随轻微摆动：

App.js

App.js

```jsx
1  return (

2    <>

3      <RigidBody ref={fixed} type="fixed" />

4      <RigidBody position={[0.5, 0, 0]} ref={j1}>

5        <BallCollider args={[0.1]} />

6      </RigidBody>

7      <RigidBody position={[1, 0, 0]} ref={j2}>

8        <BallCollider args={[0.1]} />

9      </RigidBody >

10      <RigidBody position={[1.5, 0, 0]} ref={j3}>
```

```jsx
1  返回（

2    <>

3      <RigidBody ref={fixed} type="fixed" />

4      <RigidBody position={[0.5, 0, 0]} ref={j1}>

5        <BallCollider args={[0.1]} />

6      </RigidBody>

7      <RigidBody position={[1, 0, 0]} ref={j2}>

8        <BallCollider args={[0.1]} />

9      </RigidBody >

10      <RigidBody position={[1.5, 0, 0]} ref={j3}>
```

11        <BallCollider args={[0.1]} />

11        <球体碰撞体组件 args={[0.1]} />

12      </RigidBody >

12      </刚体组件>

13      <mesh ref={band}>

13      <网格 ref={band}>

14        <meshLineGeometry />

14        <网格线几何体 />

15        <meshLineMaterial color="white" resolution={[width, height]} lineWidth={1} />

15        <网格线材质 color="white" resolution={[width, height]} lineWidth={1} />

16      </mesh>

16      </网格>

17    </>

17    </>

18  )

18  )

19}
```

19}
```

## The card component

## 卡片组件

All that’s missing is the interactive card, which we need to attach to the end of the last joint. For this, we’ll need a new reference, some variables for math, a state for dragging, and a new joint. This time, we use a spherical joint so the card can rotate:

所有缺失的部分是一个交互式卡片，我们需要将其附加到最后一个关节的末端。为此，我们需要一个新的引用、一些用于数学计算的变量、一个用于拖拽的状态，以及一个新的关节。这一次，我们使用球形关节（spherical joint），以便卡片能够自由旋转：

App.js

App.js

```jsx
1  const card = useRef()

2  const vec = new THREE.Vector3()

3  const ang = new THREE.Vector3()

4  const rot = new THREE.Vector3()

5  const dir = new THREE.Vector3()

6  const [dragged, drag] = useState(false)



8  useSphericalJoint(j3, card, [[0, 0, 0], [0, 1.45, 0]])
```

Rapier defines a few rigid-body types:

Rapier 定义了几种刚体类型：

- `fixed`, which isn’t affected by anything

- `fixed`：不受任何力或碰撞影响的刚体

- `dynamic`, the default, which reacts to any other rigid body

- `dynamic`（默认类型）：会响应与其他任意刚体的相互作用（如碰撞、力等）

- `kinematicPosition`, which is the position controlled by the user, not the engine

- `kinematicPosition`：其位置由用户控制，而非物理引擎自动计算

The card needs to be kinematic when dragged and dynamic when it’s not. We will later use `pointerEvents` to set the `dragged` state.

卡片在被拖拽时需设为运动学（kinematic）类型，未拖拽时则为动力学（dynamic）类型。稍后我们将通过 `pointerEvents` 来设置 `dragged` 状态。

Our previous `useFrame` now changes to this:

我们此前的 `useFrame` 现已更新为如下形式：

App.js

App.js

```jsx
1  useFrame((state) => {

2    if (dragged) {

3      vec.set(state.pointer.x, state.pointer.y, 0.5).unproject(state.camera)
```

4      dir.copy(vec).sub(state.camera.position).normalize()

4      dir.copy(vec).sub(state.camera.position).normalize()（归一化处理）

5      vec.add(dir.multiplyScalar(state.camera.position.length()))

5      vec.add(dir.multiplyScalar(state.camera.position.length()))（将方向向量按相机位置长度缩放后加到 vec 上）

6      card.current.setNextKinematicTranslation({ x: vec.x - dragged.x, y: vec.y - dragged.y, z: vec.z - dragged.z })

6      card.current.setNextKinematicTranslation({ x: vec.x - dragged.x, y: vec.y - dragged.y, z: vec.z - dragged.z })（设置卡片下一帧的运动学平移位置）

7    }

7    }

9    // Calculate Catmull curve

9    // 计算 Catmull-Rom 曲线

10    curve.points[0].copy(j3.current.translation())

10    curve.points[0].copy(j3.current.translation())（将关节 j3 当前平移位置复制为曲线第 0 个控制点）

11    curve.points[1].copy(j2.current.translation())

11    curve.points[1].copy(j2.current.translation())（将关节 j2 当前平移位置复制为曲线第 1 个控制点）

12    curve.points[2].copy(j1.current.translation())

12    curve.points[2].copy(j1.current.translation())（将关节 j1 当前平移位置复制为曲线第 2 个控制点）

13    curve.points[3].copy(fixed.current.translation())

13    curve.points[3].copy(fixed.current.translation())（将固定节点当前平移位置复制为曲线第 3 个控制点）

14    band.current.geometry.setPoints(curve.getPoints(32))

14    band.current.geometry.setPoints(curve.getPoints(32))

15    // Tilt the card back towards the screen

15    // 将卡片向屏幕方向倾斜

16    ang.copy(card.current.angvel())

16    ang.copy(card.current.angvel())

17    rot.copy(card.current.rotation())

17    rot.copy(card.current.rotation())

18    card.current.setAngvel({ x: ang.x, y: ang.y - rot.y * 0.25, z: ang.z })

18    card.current.setAngvel({ x: ang.x, y: ang.y - rot.y * 0.25, z: ang.z })

19  })
19  })

Calculating the dragged state is the complicated bit of the code. Without going into too much detail, if you want to translate a pointer event coordinate to a 3D object, this is called a camera unprojection. Three.js has a method for this, `unproject(state.camera)`, which does most of the math.

计算拖拽状态是这段代码中较复杂的一部分。若不深入细节，当需要将指针事件（pointer event）的二维坐标转换为三维空间中的物体位置时，这一过程称为“相机反投影”（camera unprojection）。Three.js 提供了对应方法 `unproject(state.camera)`，它已封装了大部分相关数学运算。

The obtained vector gets applied as a kinematic translation. We move the card with the mouse/trackpad, and the lanyard joints will follow it where it goes.

所获得的向量被用作运动学平移（kinematic translation）。我们通过鼠标或触控板移动卡片，而挂绳的关节会随之跟随其运动轨迹。

Another hard nut to crack is that we allow the card to rotate, but we want it to always rotate from back to front—which is not physically accurate, of course, but the experience would suffer otherwise. To solve this, we use the current rotational velocity `card.current.angvel()` and the rotation `card.current.rotation()`, and spin the y-axis towards the front.

另一个难点在于：我们允许卡片旋转，但希望其始终沿“由后向前”的方向转动——这在物理上并不完全准确，但若不如此处理，用户体验将大打折扣。为解决该问题，我们利用当前的角速度 `card.current.angvel()` 和当前旋转姿态 `card.current.rotation()`，对 y 轴施加一个朝向正前方的旋转修正。

### The card’s rigid body and pointer events

### 卡片的刚体与指针事件

We use a `<CuboidCollider>` (a box shape) for the card and drop a `<mesh>` inside that will move along with the `<RigidBody>`. This mesh will later be exchanged with the Blender model.

我们为卡片使用 `<CuboidCollider>`（一个盒状碰撞体），并在其中嵌入一个 `<mesh>`，该网格将随 `<RigidBody>` 一同运动。此网格后续将被替换为 Blender 导出的模型。

The pointer events for up and down set the `drag` state. On the down point, we grab the current point of the model, `e.point`, and subtract the card’s position in space, `card.current.translation()`. We need this offset for the `useFrame` above to calculate the correct kinematic position:

鼠标指针的按下（`onPointerDown`）与抬起（`onPointerUp`）事件用于设置 `drag` 状态。在按下时，我们获取模型当前在世界空间中的点击位置 `e.point`，并减去卡片当前位置 `card.current.translation()`，从而得到一个偏移量。该偏移量将在上方的 `useFrame` 中用于计算正确的运动学位置：

App.js

App.js

```jsx
1      <RigidBody ref={card} type={dragged ? 'kinematicPosition' : 'dynamic'} >

2        <CuboidCollider args={[0.8, 1.125, 0.01]} />

3        <mesh

4          onPointerUp={(e) => drag(false)}

5          onPointerDown={(e) => drag(new THREE.Vector3().copy(e.point).sub(vec.copy(card.current.translation())))}>

6          <planeGeometry args={[0.8 * 2, 1.125 * 2]} />

7          <meshBasicMaterial color="white" side={THREE.DoubleSide} />
```

8        </mesh>

8        </mesh>

9      </RigidBody>
```

9      </RigidBody>
```

## Adding the dynamic name

## 添加动态姓名

We wanted the card to display the name of the user dynamically. To achieve that, we’ll create a new scene that renders the user's name alongside a base texture. Then, we’ll use Drei's `<RenderTexture>` component to render that scene into a texture.

我们希望卡片能够动态显示用户的姓名。为实现这一目标，我们将创建一个新场景，该场景同时渲染用户姓名和基础纹理；随后，我们将使用 Drei 的 `<RenderTexture>` 组件将该场景渲染为一张纹理。

We start by creating a scene that renders the base of the badge texture:

我们首先创建一个用于渲染徽章纹理底图的场景：

App.js

App.js

```jsx
1<PerspectiveCamera makeDefault manual aspect={1.05} position={[0.49, 0.22, 2]} />

1<PerspectiveCamera makeDefault manual aspect={1.05} position={[0.49, 0.22, 2]} />

2<mesh>

2<mesh>

3  <planeGeometry args={[planeWidth, -planeWidth / textureAspect]} />

3  <planeGeometry args={[planeWidth, -planeWidth / textureAspect]} />

4  <meshBasicMaterial transparent alphaMap={texture} side={THREE.BackSide} />
```

4  <meshBasicMaterial transparent alphaMap={texture} side={THREE.BackSide} />
```

5</mesh>
```

![The result of using Drei's <RenderTexture> component to render our badge texture.](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_001.jpg)  
使用 Drei 的 `<RenderTexture>` 组件渲染徽章纹理的效果。

我们已经拥有了徽章纹理，但姓名部分尚未添加。我们将使用 Drei 的 `<Text3D>` 组件将姓名加入场景中：

App.js

```jsx
1<Center bottom right>

2  <Resize key={resizeId} maxHeight={0.45} maxWidth={0.925}>

3    <Text3D

4      bevelEnabled={false}

5      bevelSize={0}

6      font="/ship/2024/badge/Geist_Regular.json"

7      height={0}

7      height={0}

8      rotation={[0, Math.PI, Math.PI]}>

8      rotation={[0, Math.PI, Math.PI]}>

9      {user.firstName}

9      {user.firstName}

10    </Text3D>

10    </Text3D>

11    <Text3D

11    <Text3D

12      bevelEnabled={false}

12      bevelEnabled={false}

13      bevelSize={0}

13      bevelSize={0}

14      font="/ship/2024/badge/Geist_Regular.json"

14      font="/ship/2024/badge/Geist_Regular.json"

15      height={0}

15      height={0}

16      position={[0, 1.4, 0]}

16      position={[0, 1.4, 0]}

17      rotation={[0, Math.PI, Math.PI]}>

17      rotation={[0, Math.PI, Math.PI]}>

18      {user.lastName}

18      {user.lastName}

19    </Text3D>

19    </Text3D>

20  </Resize>

20  </Resize>

21</Center>

21</Center>
```

```

This is an entirely different scene—we want to add the result of the render into our badge as a color. We achieve this using the `<RenderTexture>` component, which will render our scene into a texture we can attach to the `mesh.map`:

这是一个完全不同的场景——我们希望将渲染结果作为颜色添加到徽章中。我们通过 `<RenderTexture>` 组件实现这一目标，该组件会将我们的场景渲染为一张纹理，然后我们可以将其赋值给 `mesh.map`：

App.js

App.js

```jsx
1<mesh geometry={nodes.card.geometry}>

1<mesh geometry={nodes.card.geometry}>

2  <meshPhysicalMaterial

2  <meshPhysicalMaterial

3    clearcoat={1}

3    clearcoat={1}

4    clearcoatRoughness={0.15}

4    清漆粗糙度={0.15}

5    iridescence={1}

5    彩虹色={1}

6    iridescenceIOR={1}

6    彩虹色折射率={1}

7    iridescenceThicknessRange={[0, 2400]}

7    彩虹色厚度范围={[0, 2400]}

8    metalness={0.5}

8    金属度={0.5}

9    roughness={0.3}

9    粗糙度={0.3}

10  >

10  >

11    <RenderTexture attach="map" height={2000} width={2000}>

11    <RenderTexture attach="map" height={2000} width={2000}>

12      <BadgeTexture user={user} />

12      <BadgeTexture user={user} />

13    </RenderTexture>

13    </RenderTexture>

14  </meshPhysicalMaterial>

14  </meshPhysicalMaterial>

15</mesh>
```

15</mesh>
```

## Finishing touches

## 收尾工作

We have everything in place now. The basic meshes are quickly changed out for the Blender models, and with a little bit of tweaking and math, we make the simulation more stable and less shaky. Here's the sandbox we used to prototype the component for the Ship site:

目前所有要素均已就位。基础网格可快速替换为 Blender 模型，再辅以少量微调和数学计算，即可使模拟效果更加稳定、减少抖动。以下是我们在 Ship 网站中用于该组件原型开发的沙盒环境：

App.jsindex.jsstyles.css

App.jsindex.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

要进入代码编辑模式，请按 Enter 键；要退出编辑模式，请按 Escape 键。

You are editing the code. To exit the edit mode, press Escape

您当前正在编辑代码。要退出编辑模式，请按 Escape 键。

999

999

1

1

2

2

3

3

4

4

5

5

6

6

7

7

8

8

9

9

10

10

11

11

12

12

13

13

14

14

15

15

16

16

17

17

18

18

19

19

20

20

21

21

22

22

23

23

24

24

25

25

26

26

27

27

28

28

29

29

30

30

31

31

32

32

33

33

34

34

35

35

36

36

```javascript
import * as THREE from 'three'
```

```javascript
import * as THREE from 'three'
```

```javascript
import { useEffect, useRef, useState } from 'react'
```

```javascript
import { useEffect, useRef, useState } from 'react'
```

```javascript
import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'
```

```javascript
import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'
```

```javascript
import { useGLTF, useTexture, Environment, Lightformer } from '@react-three/drei'
```

```javascript
import { useGLTF, useTexture, Environment, Lightformer } from '@react-three/drei'
```

```javascript
import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'
```

```javascript
import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'
```

```javascript
import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

```javascript
import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

```javascript
import { useControls } from 'leva'

extend({ MeshLineGeometry, MeshLineMaterial })

useGLTF.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5huRVDzcoDwnbgrKUo1Lzs/53b6dd7d6b4ffcdbd338fa60265949e1/tag.glb')

useTexture.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/SOT1hmCesOHxEYxL7vkoZ/c57b29c85912047c414311723320c16b/band.jpg')

export default function App() {

  const { debug } = useControls({ debug: false })

  return (
    <Canvas camera={{ position: [0, 0, 13], fov: 25 }}>
      <ambientLight intensity={Math.PI} />
      <Physics debug={debug} interpolate gravity={[0, -40, 0]} timeStep={1 / 60}>
```

```javascript
import { useControls } from 'leva'

导入 useControls 钩子（来自 leva 库）

extend({ MeshLineGeometry, MeshLineMaterial })

向 Three.js 扩展自定义几何体与材质（MeshLineGeometry 和 MeshLineMaterial）

useGLTF.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5huRVDzcoDwnbgrKUo1Lzs/53b6dd7d6b4ffcdbd338fa60265949e1/tag.glb')

预加载 GLB 格式的 3D 模型资源（tag.glb）

useTexture.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/SOT1hmCesOHxEYxL7vkoZ/c57b29c85912047c414311723320c16b/band.jpg')

预加载纹理图片资源（band.jpg）

export default function App() {

导出默认的 React 函数组件 App

  const { debug } = useControls({ debug: false })

  使用 leva 控制面板创建一个布尔型调试开关（初始值为 false）

  return (
    <Canvas camera={{ position: [0, 0, 13], fov: 25 }}>
      <ambientLight intensity={Math.PI} />
      <Physics debug={debug} interpolate gravity={[0, -40, 0]} timeStep={1 / 60}>
```

> ⚠️ Note: The original markdown snippet is actually JavaScript/JSX code (not prose), and contains syntax errors (e.g., `interpolategravity` should be `interpolate` and `gravity` as separate props — likely a typo). The bilingual rendering above preserves the original code verbatim in the first block, then provides line-by-line explanatory translations in the second block — matching the requested bilingual markdown format while respecting code integrity and technical accuracy.

<Band/>

<Band/>

</Physics>

</Physics>

<Environment backgroundBlur={0.75}>

<Environment 背景模糊度={0.75}>

<color attach="background" args={['black']}/>

<color 附加到="背景" 参数={['黑色']}/>

<Lightformer intensity={2} color="white" position={[0, -1, 5]} rotation={[0, 0, Math.PI / 3]} scale={[100, 0.1, 1]}/>

<Lightformer 强度={2} 颜色="白色" 位置={[0, -1, 5]} 旋转={[0, 0, Math.PI / 3]} 缩放={[100, 0.1, 1]}/>

<Lightformer intensity={3} color="white" position={[-1, -1, 1]} rotation={[0, 0, Math.PI / 3]} scale={[100, 0.1, 1]}/>

<Lightformer 强度={3} 颜色="白色" 位置={[-1, -1, 1]} 旋转={[0, 0, Math.PI / 3]} 缩放={[100, 0.1, 1]}/>

<Lightformer intensity={3} color="white" position={[1, 1, 1]} rotation={[0, 0, Math.PI / 3]} scale={[100, 0.1, 1]}/>

<Lightformer 强度={3} 颜色="白色" 位置={[1, 1, 1]} 旋转={[0, 0, Math.PI / 3]} 缩放={[100, 0.1, 1]}/>

<Lightformer intensity={10} color="white" position={[-10, 0, 14]} rotation={[0, Math.PI / 2, Math.PI / 3]} scale={[100, 10, 1]}/>

<Lightformer 强度={10} 颜色="白色" 位置={[-10, 0, 14]} 旋转={[0, Math.PI / 2, Math.PI / 3]} 缩放={[100, 10, 1]}/>

</Environment>

</Environment>

</Canvas>

</Canvas>

)

}

function Band({maxSpeed = 50, minSpeed = 10}) {

const band = useRef(), fixed = useRef(), j1 = useRef(), j2 = useRef(), j3 = useRef(), card = useRef(); // prettier-ignore

const vec = new THREE.Vector3(), ang = new THREE.Vector3(), rot = new THREE.Vector3(), dir = new THREE.Vector3(); // prettier-ignore

const segmentProps = {type: 'dynamic', canSleep: true, colliders: false, angularDamping: 2, linearDamping: 2};

const {nodes, materials} = useGLTF('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5huRVDzcoDwnbgrKUo1Lzs/53b6dd7d6b4ffcdbd338fa60265949e1/tag.glb');

在 CodeSandbox 中打开

就这样！一旦你掌握了基础知识，并开始尝试简单的几何形状，可能性将无穷无尽。

[**领取你的虚拟徽章。**  
注册参加 Vercel Ship '24，了解面向 AI 的用户体验、可组合式 Web 应用的构建方法，以及来自我们的合作伙伴与社区的最新动态。  
立即注册](https://vercel.com/ship/ticket)

Blog post

博客文章

Apr 9, 2024

2024年4月9日

### Composable AI for ecommerce: Hands-on with Vercel’s AI SDK

### 面向电商的可组合 AI：动手实践 Vercel 的 AI SDK

![](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_002.jpg)

Malte Ubl

Malte Ubl

Blog post

博客文章

Nov 29, 2023

2023年11月29日

### Guide to fast websites with Next.js: Tips for maximizing server speeds and minimizing client burden

### 使用 Next.js 构建高速网站指南：提升服务器响应速度与减轻客户端负担的实用技巧

![](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_003.jpg)

Seif Ghezala

Seif Ghezala