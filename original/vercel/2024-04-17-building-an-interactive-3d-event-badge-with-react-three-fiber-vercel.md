---
title: "Building an interactive 3D event badge with React Three Fiber - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-an-interactive-3d-event-badge-with-react-three-fiber"
date: "2024-04-17"
scraped_at: "2026-03-02T09:45:35.188024792+00:00"
language: "en"
translated: false
description: "See a full working demo of how we built the interactive Vercel Ship '24 badge using React Three Fiber and react-three-rapier."
---




Apr 17, 2024

In this post, we’ll look at how we made the dropping lanyard for the [Vercel Ship 2024 site](https://vercel.com/ship), diving into the inspiration, tech stack, and code behind the finished product.

## Inspiration

We’ve shared digital tickets for event attendance in the past, but this time, we wanted to take it one step further by creating a tangible experience.

When [Studio Basement](https://basement.studio/) made a video in Blender that depicted a virtual badge dropping down, we liked the idea of it so much that we started to wonder whether we could make it interactive and run it in the browser.

Ultimately, we wanted a highly shareable element that rewards the user for signing up and makes it worth their time.

## The stack

To accomplish the task, we chose the following stack:

- Blender, to prepare and optimize the original models for the web

- React and [React Three Fiber](https://github.com/pmndrs/react-three-fiber), which is a reactive, declarative renderer for [Three.js](https://threejs.org/)

- [Drei](https://github.com/pmndrs/drei), an ecosystem of components and helpers for the Three.js space in React

- [`react-three-rapier`](https://github.com/pmndrs/react-three-rapier), a declarative physics library based on the [Dimforge Rapier physics engine](https://rapier.rs/)

- [MeshLine](https://github.com/pmndrs/meshline), a shader-based thick-line implementation


While some of the concepts we’re about to cover may not look familiar, don’t let them overwhelm you. The implementation is about 80 lines of mostly declarative code, with a sprinkle of math.

Check out this sandbox first to get an idea of what we’re building:

App.jsindex.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

You are editing the code. To exit the edit mode, press Escape

99

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

import\*asTHREEfrom'three'

import{useRef,useState}from'react'

import{Canvas,extend,useThree,useFrame}from'@react-three/fiber'

import{BallCollider,CuboidCollider,Physics,RigidBody,useRopeJoint,useSphericalJoint}from'@react-three/rapier'

import{MeshLineGeometry,MeshLineMaterial}from'meshline'

extend({MeshLineGeometry,MeshLineMaterial})

exportdefaultfunctionApp(){

return(

<Canvascamera={{position:\[0,0,13\],fov:25}}>

<Physicsdebuginterpolategravity={\[0, -40,0\]}timeStep={1 / 60}>

<Band/>

</Physics>

</Canvas>

)

}

functionBand(){

constband = useRef(),fixed = useRef(),j1 = useRef(),j2 = useRef(),j3 = useRef(),card = useRef()// prettier-ignore

constvec = newTHREE.Vector3(),ang = newTHREE.Vector3(),rot = newTHREE.Vector3(),dir = newTHREE.Vector3()// prettier-ignore

const{width,height} = useThree((state)=>state.size)

const\[curve\] = useState(()=>newTHREE.CatmullRomCurve3(\[newTHREE.Vector3(),newTHREE.Vector3(),newTHREE.Vector3(),newTHREE.Vector3()\]))

const\[dragged,drag\] = useState(false)

useRopeJoint(fixed,j1,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useRopeJoint(j1,j2,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useRopeJoint(j2,j3,\[\[0,0,0\],\[0,0,0\],1\])// prettier-ignore

useSphericalJoint(j3,card,\[\[0,0,0\],\[0,1.45,0\]\])// prettier-ignore

useFrame((state,delta)=>{

if(dragged){

vec.set(state.pointer.x,state.pointer.y,0.5).unproject(state.camera)

dir.copy(vec).sub(state.camera.position).normalize()

vec.add(dir.multiplyScalar(state.camera.position.length()))

;\[card,j1,j2,j3,fixed\].forEach((ref)=>ref.current?.wakeUp())

Open on CodeSandbox

## Building a rough draft

The basic imports we need revolve around our canvas, physics, and the thick line for the lanyard:

App.js

```jsx
import * as THREE from 'three'

import { useRef, useState } from 'react'

import { Canvas, extend, useThree, useFrame } from '@react-three/fiber'

import { BallCollider, CuboidCollider, Physics, RigidBody, useRopeJoint, useSphericalJoint } from '@react-three/rapier'

import { MeshLineGeometry, MeshLineMaterial } from 'meshline'
```

In order to use the MeshLine library, which is vanilla Three.js in React, we need to [extend it](https://docs.pmnd.rs/react-three-fiber/api/objects#using-3rd-party-objects-declaratively). The `extend` function extends React Three Fiber's catalog of known JSX elements. Components added this way can then be referenced in the scene graph using camel casing, similar to native primitives (e.g., `<mesh>`):

App.js

```jsx
extend({ MeshLineGeometry, MeshLineMaterial })
```

### Setting up the canvas

Now we can set up a basic canvas. We need React Three Fiber’s `<Canvas>` component, which is a doorway into declarative Three.js. We also add a `<Physics>` provider, which allows us to tie shapes to physics; in Rapier, this is called a `<RigidBody>`.

With this, we have everything we need:

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

Now let’s make the band happen. We need a couple of references to access them later on. The canvas size is important for `meshline`, and a `THREE.CatmullRomCurve3` helps us to calculate a smooth curve with just a few points. We only need four points for the physics joints:

App.js

```jsx
function Band() {

2  // References for the band and the joints

3  const band = useRef()

4  const fixed = useRef()

5  const j1 = useRef()

6  const j2 = useRef()

7  const j3 = useRef()

8  // Canvas size

9  const { width, height } = useThree((state) => state.size)

10  // A Catmull-Rom curve

11  const [curve] = useState(() => new THREE.CatmullRomCurve3([\
\
12    new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3(), new THREE.Vector3()\
\
13  ]))
```

### Defining the physics joints

A joint is a physics constraint that tells the engine how shapes interact with one another. We’ll now start to connect the joints, and we’ll later define a fixed `<RigidBody>` that cannot move.

We hang the first joint on the `useRopeJoint` the Rapier provides (there are a lot of different constraints for rotations, distances, etc.). The other joints will hang on each other. Basically, we will have made a chain that hangs on a fixed point.

`useRopeJoint` requires two `<RigidBody>` references:

1. Two anchor points for each (we’re using `[0, 0, 0]`, which is the center point)

2. A length (we’re using `1`)


Our rope is ready to swing!

App.js

```jsx
1  useRopeJoint(fixed, j1, [[0, 0, 0], [0, 0, 0], 1])

2  useRopeJoint(j1, j2, [[0, 0, 0], [0, 0, 0], 1])

3  useRopeJoint(j2, j3, [[0, 0, 0], [0, 0, 0], 1])
```

### Creating a curve

Rapier will now move the joints along an invisible rope, and we can feed our [Catmull-Rom curve](https://threejs.org/docs/#api/en/extras/curves/CatmullRomCurve3) the positions of these joints. We let it make a smooth, interpolated curve with 32 points and forward that to the `meshline`.

We do this at runtime at 60 or 120 FPS, depending on the monitor’s refresh rate. React Three Fiber gives us an out to handle frame-based animations with the `useFrame` Hook:

App.js

```jsx
1  useFrame(() => {

2    curve.points[0].copy(j3.current.translation())

3    curve.points[1].copy(j2.current.translation())

4    curve.points[2].copy(j1.current.translation())

5    curve.points[3].copy(fixed.current.translation())

6    band.current.geometry.setPoints(curve.getPoints(32))

7  })
```

### The view

Now we need the view. It consists of the fixed `<RigidBody type="fixed">`, three `<RigidBody>`'s for the joints (`j1`, `j2`, and `j3`), and the `meshline` that we extended above. The joints are positioned in a way that makes them fall down with a slight swing:

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

11        <BallCollider args={[0.1]} />

12      </RigidBody >

13      <mesh ref={band}>

14        <meshLineGeometry />

15        <meshLineMaterial color="white" resolution={[width, height]} lineWidth={1} />

16      </mesh>

17    </>

18  )

19}
```

## The card component

All that’s missing is the interactive card, which we need to attach to the end of the last joint. For this, we’ll need a new reference, some variables for math, a state for dragging, and a new joint. This time, we use a spherical joint so the card can rotate:

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

- `fixed`, which isn’t affected by anything

- `dynamic`, the default, which reacts to any other rigid body

- `kinematicPosition`, which is the position controlled by the user, not the engine


The card needs to be kinematic when dragged and dynamic when it’s not. We will later use `pointerEvents` to set the `dragged` state.

Our previous `useFrame` now changes to this:

App.js

```jsx
1  useFrame((state) => {

2    if (dragged) {

3      vec.set(state.pointer.x, state.pointer.y, 0.5).unproject(state.camera)

4      dir.copy(vec).sub(state.camera.position).normalize()

5      vec.add(dir.multiplyScalar(state.camera.position.length()))

6      card.current.setNextKinematicTranslation({ x: vec.x - dragged.x, y: vec.y - dragged.y, z: vec.z - dragged.z })

7    }



9    // Calculate Catmull curve

10    curve.points[0].copy(j3.current.translation())

11    curve.points[1].copy(j2.current.translation())

12    curve.points[2].copy(j1.current.translation())

13    curve.points[3].copy(fixed.current.translation())

14    band.current.geometry.setPoints(curve.getPoints(32))

15    // Tilt the card back towards the screen

16    ang.copy(card.current.angvel())

17    rot.copy(card.current.rotation())

18    card.current.setAngvel({ x: ang.x, y: ang.y - rot.y * 0.25, z: ang.z })

19  })
```

Calculating the dragged state is the complicated bit of the code. Without going into too much detail, if you want to translate a pointer event coordinate to a 3D object, this is called a camera unprojection. Three.js has a method for this, `unproject(state.camera)`, which does most of the math.

The obtained vector gets applied as a kinematic translation. We move the card with the mouse/trackpad, and the lanyard joints will follow it where it goes.

Another hard nut to crack is that we allow the card to rotate, but we want it to always rotate from back to front—which is not physically accurate, of course, but the experience would suffer otherwise. To solve this, we use the current rotational velocity `card.current.angvel()` and the rotation `card.current.rotation()`, and spin the y-axis towards the front.

### The card’s rigid body and pointer events

We use a `<CuboidCollider>` (a box shape) for the card and drop a `<mesh>` inside that will move along with the `<RigidBody>`. This mesh will later be exchanged with the Blender model.

The pointer events for up and down set the `drag` state. On the down point, we grab the current point of the model, `e.point`, and subtract the card’s position in space, `card.current.translation()`. We need this offset for the `useFrame` above to calculate the correct kinematic position:

App.js

```jsx
1      <RigidBody ref={card} type={dragged ? 'kinematicPosition' : 'dynamic'} >

2        <CuboidCollider args={[0.8, 1.125, 0.01]} />

3        <mesh

4          onPointerUp={(e) => drag(false)}

5          onPointerDown={(e) => drag(new THREE.Vector3().copy(e.point).sub(vec.copy(card.current.translation())))}>

6          <planeGeometry args={[0.8 * 2, 1.125 * 2]} />

7          <meshBasicMaterial color="white" side={THREE.DoubleSide} />

8        </mesh>

9      </RigidBody>
```

## Adding the dynamic name

We wanted the card to display the name of the user dynamically. To achieve that, we’ll create a new scene that renders the user's name alongside a base texture. Then, we’ll use Drei's `<RenderTexture>` component to render that scene into a texture.

We start by creating a scene that renders the base of the badge texture:

App.js

```jsx
1<PerspectiveCamera makeDefault manual aspect={1.05} position={[0.49, 0.22, 2]} />

2<mesh>

3  <planeGeometry args={[planeWidth, -planeWidth / textureAspect]} />

4  <meshBasicMaterial transparent alphaMap={texture} side={THREE.BackSide} />

5</mesh>
```

![The result of using Drei's <RenderTexture> component to render our badge texture.](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_001.jpg)The result of using Drei's <RenderTexture> component to render our badge texture.

We have the badge texture, but we’re still missing the name. We’ll add it to the scene using Drei's `<Text3D>` component:

App.js

```jsx
1<Center bottom right>

2  <Resize key={resizeId} maxHeight={0.45} maxWidth={0.925}>

3    <Text3D

4      bevelEnabled={false}

5      bevelSize={0}

6      font="/ship/2024/badge/Geist_Regular.json"

7      height={0}

8      rotation={[0, Math.PI, Math.PI]}>

9      {user.firstName}

10    </Text3D>

11    <Text3D

12      bevelEnabled={false}

13      bevelSize={0}

14      font="/ship/2024/badge/Geist_Regular.json"

15      height={0}

16      position={[0, 1.4, 0]}

17      rotation={[0, Math.PI, Math.PI]}>

18      {user.lastName}

19    </Text3D>

20  </Resize>

21</Center>
```

This is an entirely different scene—we want to add the result of the render into our badge as a color. We achieve this using the `<RenderTexture>` component, which will render our scene into a texture we can attach to the `mesh.map`:

App.js

```jsx
1<mesh geometry={nodes.card.geometry}>

2  <meshPhysicalMaterial

3    clearcoat={1}

4    clearcoatRoughness={0.15}

5    iridescence={1}

6    iridescenceIOR={1}

7    iridescenceThicknessRange={[0, 2400]}

8    metalness={0.5}

9    roughness={0.3}

10  >

11    <RenderTexture attach="map" height={2000} width={2000}>

12      <BadgeTexture user={user} />

13    </RenderTexture>

14  </meshPhysicalMaterial>

15</mesh>
```

## Finishing touches

We have everything in place now. The basic meshes are quickly changed out for the Blender models, and with a little bit of tweaking and math, we make the simulation more stable and less shaky. Here's the sandbox we used to prototype the component for the Ship site:

App.jsindex.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

You are editing the code. To exit the edit mode, press Escape

999

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

25

26

27

28

29

30

31

32

33

34

35

36

import\*asTHREEfrom'three'

import{useEffect,useRef,useState}from'react'

import{Canvas,extend,useThree,useFrame}from'@react-three/fiber'

import{useGLTF,useTexture,Environment,Lightformer}from'@react-three/drei'

import{BallCollider,CuboidCollider,Physics,RigidBody,useRopeJoint,useSphericalJoint}from'@react-three/rapier'

import{MeshLineGeometry,MeshLineMaterial}from'meshline'

import{useControls}from'leva'

extend({MeshLineGeometry,MeshLineMaterial})

useGLTF.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5huRVDzcoDwnbgrKUo1Lzs/53b6dd7d6b4ffcdbd338fa60265949e1/tag.glb')

useTexture.preload('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/SOT1hmCesOHxEYxL7vkoZ/c57b29c85912047c414311723320c16b/band.jpg')

exportdefaultfunctionApp(){

const{debug} = useControls({debug:false})

return(

<Canvascamera={{position:\[0,0,13\],fov:25}}>

<ambientLightintensity={Math.PI}/>

<Physicsdebug={debug}interpolategravity={\[0, -40,0\]}timeStep={1 / 60}>

<Band/>

</Physics>

<Environmentbackgroundblur={0.75}>

<colorattach="background"args={\['black'\]}/>

<Lightformerintensity={2}color="white"position={\[0, -1,5\]}rotation={\[0,0,Math.PI / 3\]}scale={\[100,0.1,1\]}/>

<Lightformerintensity={3}color="white"position={\[-1, -1,1\]}rotation={\[0,0,Math.PI / 3\]}scale={\[100,0.1,1\]}/>

<Lightformerintensity={3}color="white"position={\[1,1,1\]}rotation={\[0,0,Math.PI / 3\]}scale={\[100,0.1,1\]}/>

<Lightformerintensity={10}color="white"position={\[-10,0,14\]}rotation={\[0,Math.PI / 2,Math.PI / 3\]}scale={\[100,10,1\]}/>

</Environment>

</Canvas>

)

}

functionBand({maxSpeed = 50,minSpeed = 10}){

constband = useRef(),fixed = useRef(),j1 = useRef(),j2 = useRef(),j3 = useRef(),card = useRef()// prettier-ignore

constvec = newTHREE.Vector3(),ang = newTHREE.Vector3(),rot = newTHREE.Vector3(),dir = newTHREE.Vector3()// prettier-ignore

constsegmentProps = {type:'dynamic',canSleep:true,colliders:false,angularDamping:2,linearDamping:2}

const{nodes,materials} = useGLTF('https://assets.vercel.com/image/upload/contentful/image/e5382hct74si/5huRVDzcoDwnbgrKUo1Lzs/53b6dd7d6b4ffcdbd338fa60265949e1/tag.glb')

Open on CodeSandbox

And that's it! Once you get the hang of the basics and start playing with simple shapes, the possibilities are endless.

[**Get your virtual badge.**\\
\\
Register for Vercel Ship '24 to learn about AI-native user experiences, building composable web applications, and the latest from our partners and community.\\
\\
Register Today](https://vercel.com/ship/ticket)

Blog post

Apr 9, 2024

### Composable AI for ecommerce: Hands-on with Vercel’s AI SDK

![](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_002.jpg)

Malte Ubl

Blog post

Nov 29, 2023

### Guide to fast websites with Next.js: Tips for maximizing server speeds and minimizing client burden

![](images/building-an-interactive-3d-event-badge-with-react-three-fiber-vercel/img_003.jpg)

Seif Ghezala