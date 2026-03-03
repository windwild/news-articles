---
title: "DALL·E: Creating images from text | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/dall-e"
date: "2021-01-05"
scraped_at: "2026-03-02T10:26:54.461981789+00:00"
language: "en-US"
translated: false
description: "We’ve trained a neural network called DALL·E that creates images from text captions for a wide range of concepts expressible in natural language."
tags: ["Research"]
---

January 5, 2021


# DALL·E: Creating images from text

We’ve trained a neural network called DALL·E that creates images from text captions for a wide range of concepts expressible in natural language.

![DALL·E](images/dall_e-creating-images-from-text-openai/img_001.jpg)

Illustration: Justin Jay Wang



DALL·E is a 12-billion parameter version of [GPT‑3⁠(opens in a new window)](https://arxiv.org/abs/2005.14165) trained to generate images from text descriptions, using a dataset of text–image pairs. We’ve found that it has a diverse set of capabilities, including creating anthropomorphized versions of animals and objects, combining unrelated concepts in plausible ways, rendering text, and applying transformations to existing images.

_See also:_ [_DALL·E 2_ ⁠](https://openai.com/index/dall-e-2/) _, which generates more realistic and accurate images with 4x greater resolution._

Text Prompt

an illustration of a baby daikon radish in a tutu walking a dog

AI Generated images

![](images/dall_e-creating-images-from-text-openai/img_002.png)

![](images/dall_e-creating-images-from-text-openai/img_003.png)

![](images/dall_e-creating-images-from-text-openai/img_004.png)

![](images/dall_e-creating-images-from-text-openai/img_005.png)

![](images/dall_e-creating-images-from-text-openai/img_006.png)

Edit prompt or view more images

Text Prompt

an armchair in the shape of an avocado. . . .

AI Generated images

![](images/dall_e-creating-images-from-text-openai/img_007.png)

![](images/dall_e-creating-images-from-text-openai/img_008.png)

![](images/dall_e-creating-images-from-text-openai/img_009.png)

![](images/dall_e-creating-images-from-text-openai/img_010.png)

![](images/dall_e-creating-images-from-text-openai/img_011.png)

Edit prompt or view more images

Text Prompt

a store front that has the word ‘openai’ written on it. . . .

AI Generated images

![](images/dall_e-creating-images-from-text-openai/img_012.png)

![](images/dall_e-creating-images-from-text-openai/img_013.png)

![](images/dall_e-creating-images-from-text-openai/img_014.png)

![](images/dall_e-creating-images-from-text-openai/img_015.png)

![](images/dall_e-creating-images-from-text-openai/img_016.png)

Edit prompt or view more images

Text Prompt

the exact same cat on the top as a sketch on the bottom

AI Generated images

![](images/dall_e-creating-images-from-text-openai/img_017.png)

![](images/dall_e-creating-images-from-text-openai/img_018.png)

![](images/dall_e-creating-images-from-text-openai/img_019.png)

![](images/dall_e-creating-images-from-text-openai/img_020.png)

![](images/dall_e-creating-images-from-text-openai/img_021.png)

Edit prompt or view more images

GPT‑3 showed that language can be used to instruct a large neural network to perform a variety of text generation tasks. [Image GPT⁠](https://openai.com/index/image-gpt/) showed that the same type of neural network can also be used to generate images with high fidelity. We extend these findings to show that manipulating visual concepts through language is now within reach.

## Overview

Like GPT‑3, DALL·E is a transformer language model. It receives both the text and the image as a single stream of data containing up to 1280 tokens, and is trained using maximum likelihood to generate all of the tokens, one after another. [A](https://openai.com/index/dall-e/#citation-bottom-A)

This training procedure allows DALL·E to not only generate an image from scratch, but also to regenerate any rectangular region of an existing image that extends to the bottom-right corner, in a way that is consistent with the text prompt.

We recognize that work involving generative models has the potential for significant, broad societal impacts. In the future, we plan to analyze how models like DALL·E relate to societal issues like economic impact on certain work processes and professions, the potential for bias in the model outputs, and the longer term ethical challenges implied by this technology.

## Capabilities

We find that DALL·E is able to create plausible images for a great variety of sentences that explore the compositional structure of language. We illustrate this using a series of interactive visuals in the next section. The samples shown for each caption in the visuals are obtained by taking the top 32 of 512 after reranking with [CLIP⁠](https://openai.com/index/clip/), but we do not use any manual cherry-picking, aside from the thumbnails and standalone images that appear outside.[B](https://openai.com/index/dall-e/#citation-bottom-B)

### Controlling attributes

We test DALL·E’s ability to modify several of an object’s attributes, as well as the number of times that it appears.

Click to edit text prompt or view more AI-generated images

a pentagonal green click. a green clock in the shape of a pentagon.

![](images/dall_e-creating-images-from-text-openai/img_022.png)

Text Prompt

AI generated images

We find that DALL·E can render familiar objects in polygonal shapes that are sometimes unlikely to occur in the real world. For some objects, such as “picture frame” and “plate,” DALL·E can reliably draw the object in any of the polygonal shapes except heptagon. For other objects, such as “manhole cover” and “stop sign,” DALL·E’s success rate for more unusual shapes, such as “pentagon,” is considerably lower.

For several of the visuals in this post, we find that repeating the caption, sometimes with alternative phrasings, improves the consistency of the results.

a cube made of porcupine. a cube with the texture of a porcupine.

![](images/dall_e-creating-images-from-text-openai/img_023.png)

Text Prompt

AI generated images

We find that DALL·E can map the textures of various plants, animals, and other objects onto three dimensional solids. As in the preceding visual, we find that repeating the caption with alternative phrasing improves the consistency of the results.

a collection of glasses is sitting on a table

![](images/dall_e-creating-images-from-text-openai/img_024.png)

Text Prompt

AI generated images

We find that DALL·E is able to draw multiple copies of an object when prompted to do so, but is unable to reliably count past three. When prompted to draw nouns for which there are multiple meanings, such as “glasses,” “chips,” and “cups” it sometimes draws both interpretations, depending on the plural form that is used.

### Drawing multiple objects

Simultaneously controlling multiple objects, their attributes, and their spatial relationships presents a new challenge. For example, consider the phrase “a hedgehog wearing a red hat, yellow gloves, blue shirt, and green pants.” To correctly interpret this sentence, DALL·E must not only correctly compose each piece of apparel with the animal, but also form the associations (hat, red), (gloves, yellow), (shirt, blue), and (pants, green) without mixing them up [C](https://openai.com/index/dall-e/#citation-bottom-C)

We test DALL·E’s ability to do this for relative positioning, stacking objects, and controlling multiple attributes.

a small red block sitting on a large green block

![](images/dall_e-creating-images-from-text-openai/img_025.png)

Text Prompt

AI generated images

We find that DALL·E correctly responds to some types of relative positions, but not others. The choices “sitting on” and “standing in front of” sometimes appear to work, “sitting below,” “standing behind,” “standing left of,” and “standing right of” do not. DALL·E also has a lower success rate when asked to draw a large object sitting on top of a smaller one, when compared to the other way around.

a stack of 3 cubes. a red cube is on the top, sitting on a green cube. the green cube is in the middle, sitting on a blue cube. the blue cube is on the bottom.

![](images/dall_e-creating-images-from-text-openai/img_026.png)

Text Prompt

AI generated images

We find that DALL·E typically generates an image with one or two of the objects having the correct colors. However, only a few samples for each setting tend to have exactly three objects colored precisely as specified.

an emoji of a baby penguin wearing a blue hat, red gloves, green shirt, and yellow pants

![](images/dall_e-creating-images-from-text-openai/img_027.png)

Text Prompt

AI generated images

We find that DALL·E typically generates an image with two or three articles of clothing having the correct colors. However, only a few of the samples for each setting tend to have all four articles of clothing with the specified colors.

While DALL·E does offer some level of controllability over the attributes and positions of a small number of objects, the success rate can depend on how the caption is phrased. As more objects are introduced, DALL·E is prone to confusing the associations between the objects and their colors, and the success rate decreases sharply. We also note that DALL·E is brittle with respect to rephrasing of the caption in these scenarios: alternative, semantically equivalent captions often yield no correct interpretations.

### Visualizing perspective and three-dimensionality

We find that DALL·E also allows for control over the viewpoint of a scene and the 3D style in which a scene is rendered.

an extreme close-up view of a capybara sitting in a field

![](images/dall_e-creating-images-from-text-openai/img_028.png)

Text Prompt

AI generated images

We find that DALL·E can draw each of the animals in a variety of different views. Some of these views, such as “aerial view” and “rear view,” require knowledge of the animal’s appearance from unusual angles. Others, such as “extreme close-up view,” require knowledge of the fine-grained details of the animal’s skin or fur.

a capybara made of voxels sitting in a field

![](images/dall_e-creating-images-from-text-openai/img_029.png)

Text Prompt

AI generated images

We find that DALL·E is often able to modify the surface of each of the animals according to the chosen 3D style, such as “claymation” and “made of voxels,” and render the scene with plausible shading depending on the location of the sun. The “x-ray” style does not always work reliably, but it shows that DALL·E can sometimes orient the bones within the animal in plausible (though not anatomically correct) configurations.

To push this further, we test DALL·E’s ability to repeatedly draw the head of a well-known figure at each angle from a sequence of equally spaced angles, and find that we can recover a smooth animation of the rotating head.

a photograph of a bust of homer

![](images/dall_e-creating-images-from-text-openai/img_030.png)

Text Prompt

a photograph of a bust of
Alexander the GreatAristotleAthenaCleopatraHomerMedusaPlatoSocratesVenus
homer

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_031.png)

AI generated images

We prompt DALL·E with both a caption describing a well-known figure and the top region of an image showing a hat drawn at a particular angle. Then, we ask DALL·E to complete the remaining part of the image given this contextual information. We do this repeatedly, each time rotating the hat a few more degrees, and find that we are able to recover smooth animations of several well-known figures, with each frame respecting the precise specification of angle and ambient lighting.

DALL·E appears to be able to apply some types of optical distortions to scenes, as we see with the options “fisheye lens view” and “a spherical panorama.” This motivated us to explore its ability to generate reflections.

a plain white cube looking at its own reflection in a mirror. a plain white cube gazing at itself in a mirror.

![](images/dall_e-creating-images-from-text-openai/img_032.png)

Text Prompt

a
catgolden retrieverplain white cuberubik's cubestatue of davidtennis ballwhite teapot
plain white cube looking at its own reflection in a mirror. a
catgolden retrieverplain white cuberubik's cubestatue of davidtennis ballwhite teapot
plain white cube gazing at itself in a mirror.

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_033.png)

AI generated images

We prompt DALL·E with both a caption describing a well-known figure and the top region of an image showing a hat drawn at a particular angle. Then, we ask DALL·E to complete the remaining part of the image given this contextual information. We do this repeatedly, each time rotating the hat a few more degrees, and find that we are able to recover smooth animations of several well-known figures, with each frame respecting the precise specification of angle and ambient lighting.

### Visualizing internal and external structure

The samples from the “extreme close-up view” and “x-ray” style led us to further explore DALL·E’s ability to render internal structure with cross-sectional views, and external structure with macro photographs.

a cross-section view of a walnut

![](images/dall_e-creating-images-from-text-openai/img_034.png)

Text Prompt

a cross-section view of a
airplanebeehivebraincarearthenginegeodehearthuman headmushroompomegranaterocketstrawberrytreevolcanowalnutwatermelonwheel of blue cheese
walnut

AI generated images

We find that DALL·E is able to draw the interiors of several different kinds of objects.

a macro photograph of brain coral

![](images/dall_e-creating-images-from-text-openai/img_035.png)

Text Prompt

a macro photograph of
bismuthbrain coralbutterfly wingcotton candyespressoflowerfrozen berry on a tree branchknife's edgeleafmorel mushroommushroom gillsorchidpeppercornsporcupine's skinsalt crystalsseaweedsequin vestsnake's skinsucculent
brain coral

AI generated images

We find that DALL·E is able to draw the fine-grained external details of several different kinds of objects. These details are only apparent when the object is viewed up close.

## Inferring contextual details

The task of translating text to images is underspecified: a single caption generally corresponds to an infinitude of plausible images, so the image is not uniquely determined. For instance, consider the caption “a painting of a capybara sitting on a field at sunrise.” Depending on the orientation of the capybara, it may be necessary to draw a shadow, though this detail is never mentioned explicitly. We explore DALL·E’s ability to resolve underspecification in three cases: changing style, setting, and time; drawing the same object in a variety of different situations; and generating an image of an object with specific text written on it.

a painting of a capybara sitting in a field at sunrise

![](images/dall_e-creating-images-from-text-openai/img_036.png)

Text Prompt

a  …  of a
capybaracougareaglefoxowlpangolinturtle
capybara
sitting in a fieldsitting in a forestsitting on a mountain
sitting in a field
at dawnat duskat nightat sunriseat sunsetat twilightin the morningin the afternoonduring summerduring fallduring winterduring spring
at sunrise

AI generated images

painting

painting in pop art style

painting in cubist style

painting in surrealist style

painting in the style of van gogh

painting in the style of claude monet

drawing

charcoal drawing

crayon drawing

chalk drawing

pencil sketch

pixel art illustration

illustration

sepia tone photograph

black and white photograph

cartoon

ukiyo-e print

wood engraving

postage stamp

poster

We find that DALL·E is able to render the same scene in a variety of different styles, and can adapt the lighting, shadows, and environment based on the time of day or season.

a stained glass window with an image of a blue strawberry

![](images/dall_e-creating-images-from-text-openai/img_037.png)

Text Prompt

a
bag of chipsbillboardbusiness cardbuttoncan of soupcapcell phone casecomputer monitordrawn on the sidewalkiphone app iconlatte artmuralneon signplastic lunchboxplaying cardpostage stamppursequiltroad signrugsoda canspherestained glass windowt-shirttattootea cupwine bottle
stained glass window with an image of a
blackbluemagentapinkwhite
blue
artichokebroccolicarrotcucumbereggplantpearpineapplepumpkinradishstrawberry
strawberry

AI generated images

We find that DALL·E is able to flexibly adapt the representation of the object based on the medium on which it is being drawn. For “a mural,” “a soda can,” and “a teacup,” DALL·E must change how it draws the object based on the angle and curvature of the drawing surface. For “a stained glass window” and “a neon sign,” it must alter the appearance of the object from how it usually appears.

a store front that has the word ‘openai’ written on it. a store front that has the word ‘openai’ written on it. a store front that has the word ‘openai’ written on it. ‘openai’ store front.

![](images/dall_e-creating-images-from-text-openai/img_014.png)

Text Prompt

a
bag of chipsbottle of mouthwashbox of tissuesbusiness cardcan of sodacan of soupgrocery baglicense plateneon signroad signstore frontt-shirtwritten in coffee beanswritten in scrabble letterswritten in the sky
store front that has the word
agigptsgdacmeclipdall-eopenaiskynethogwashpytorchbackpropmeatloafpeekaboo
'openai' written on it. a
bag of chipsbottle of mouthwashbox of tissuesbusiness cardcan of sodacan of soupgrocery baglicense plateneon signroad signstore frontt-shirtwritten in coffee beanswritten in scrabble letterswritten in the sky
store front that has the word
agigptsgdacmeclipdall-eopenaiskynethogwashpytorchbackpropmeatloafpeekaboo
'openai' written on it. a
bag of chipsbottle of mouthwashbox of tissuesbusiness cardcan of sodacan of soupgrocery baglicense plateneon signroad signstore frontt-shirtwritten in coffee beanswritten in scrabble letterswritten in the sky
store front that has the word
agigptsgdacmeclipdall-eopenaiskynethogwashpytorchbackpropmeatloafpeekaboo
'openai' written on it.
agigptsgdacmeclipdall-eopenaiskynethogwashpytorchbackpropmeatloafpeekaboo
openai store front.

AI generated images

We find that DALL·E is able to draw the fine-grained external details of several different kinds of objects. These details are only apparent when the object is viewed up close.

With varying degrees of reliability, DALL·E provides access to a subset of the capabilities of a 3D rendering engine via natural language. It can independently control the attributes of a small number of objects, and to a limited extent, how many there are, and how they are arranged with respect to one another. It can also control the location and angle from which a scene is rendered, and can generate known objects in compliance with precise specifications of angle and lighting conditions.

Unlike a 3D rendering engine, whose inputs must be specified unambiguously and in complete detail, DALL·E is often able to “fill in the blanks” when the caption implies that the image must contain a certain detail that is not explicitly stated.

### Applications of preceding capabilities

Next, we explore the use of the preceding capabilities for fashion and interior design.

a male mannequin dressed in an orange and black flannel shirt

![](images/dall_e-creating-images-from-text-openai/img_039.png)

Text Prompt

a male mannequin dressed in an
blackwhiteredorangebluenavygreenolive
orange
t-shirtpolo shirtbutton-down shirtand black checkered button-down shirtand white checkered button-down shirtand black striped button-down shirtand white striped button-down shirtand black polka dotted button-down shirtand white polka dotted button-down shirtflannel shirtand black flannel shirtand white flannel shirtbomber jacketand black bomber jacketand white bomber jacketleather jacketturtleneck sweaterand black turtleneck sweater
and black flannel shirt and
blackwhitegraybeigebrownnavyolive
black
jeanspleated trouserssweatpants
jeans

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_040.png)

AI generated images

We explore DALL·E’s ability to render male mannequins in a variety of different outfits. When prompted with two colors, e.g., “an orange and white bomber jacket” and “an orange and black turtleneck sweater,” DALL·E often exhibits a range of possibilities for how both colors can be used for the same article of clothing.

DALL·E also seems to occasionally confuse less common colors with other neighboring shades. For example, when prompted to draw clothes in “navy,” DALL·E sometimes uses lighter shades of blue, or shades very close to black. Similarly, DALL·E sometimes confuses “olive” with shades of brown or brighter shades of green.

a female mannequin dressed in a black leather jacket and gold pleated skirt

![](images/dall_e-creating-images-from-text-openai/img_041.png)

Text Prompt

a female mannequin dressed in a
whitegrayblackivorybeigebrownnavyolive
black
button-down shirtleather jacketcardigan sweatercropped sweaterpullover sweaterturtleneck sweater
leather jacket and
blackwhitegoldredpurplepinkorangeyellowbluegreen
gold
jeanspalazzo pantssweatpantsbubble skirtmini skirtpleated skirtwrap skirt
pleated skirt

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_042.png)

AI generated images

We explore DALL·E’s ability to render female mannequins in a variety of different outfits. We find that DALL·E is able to portray unique textures such as the sheen of a “black leather jacket” and “gold” skirts and leggings. As before, we see that DALL·E occasionally confuses less common colors, such as “navy” and “olive,” with other neighboring shades.

a living room with two white armchairs and a painting of the colosseum. the painting is mounted above a modern fireplace.

![](images/dall_e-creating-images-from-text-openai/img_043.png)

Text Prompt

a living room with two
redblackwhitegraybeigeolive
white armchairs and a painting of
a braina mustachea t-rexa squida lobstera rhinoceroscattailsa lotusa sequoiaa cactusa beeta mushrooma galleona fortressa windmillmount fujithe golden gate bridgethe stonehengethe sydney opera housethe collosseumbatmandarth vaderyodagoku
the collosseum. the painting is mounted
above a traditional fireplaceabove a modern fireplaceabove a coffee tablebehind a ceiling fanbehind a ceiling lampbehind an indoor plantbehind an indoor palm
above a modern fireplace.

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_044.png)

AI generated images

We explore DALL·E’s ability to generate images of rooms with several details specified. We find that it can generate paintings of a wide range of different subjects, including real-world locations such as “the colosseum” and fictional characters like “yoda.” For each subject, DALL·E exhibits a variety of interpretations. While the painting is almost always present in the scene, DALL·E sometimes fails to draw the fireplace or the correct number of armchairs.

a loft bedroom with a white bed next to a nightstand. there is a fish tank beside the bed.

![](images/dall_e-creating-images-from-text-openai/img_045.png)

Text Prompt

a loft bedroom with a
bedwhite bedgray bedpink bedking bedwhite king bedgray king bedpink king bed
white bed next to a
nightstandshelf
nightstand. there is a
aloe plantcactuscatfish tankguitarpaintingtelescope
fish tank standing beside the bed.

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_046.png)

AI generated images

We explore DALL·E’s ability to generate bedrooms with several details specified. Despite the fact that we do not tell DALL·E what should go on top of the nightstand or shelf beside the bed, we find that it sometimes decides to place the other specified object on top. As before, we see that it often fails to draw one or more of the specified objects.

### Combining unrelated concepts

The compositional nature of language allows us to put together concepts to describe both real and imaginary things. We find that DALL·E also has the ability to combine disparate ideas to synthesize objects, some of which are unlikely to exist in the real world. We explore this ability in two instances: transferring qualities from various concepts to animals, and designing products by taking inspiration from unrelated concepts.

a snail made of harp. a snail with the texture of a harp.

![](images/dall_e-creating-images-from-text-openai/img_047.png)

Text Prompt

a
catelephanthedgehogkangaroopeacockpenguinpigsnailtapir
snail made of
accordionappleavocadobaguettebananabasilbeetrootbroomburgerburritocabbagecakecalamaricarpetcarrotchilicoconutcomfortcoral reefcorkscrewcroissantcuckoo clockcucumbercursive letterscymbalseggplanteraserfaucetfossilfried chickenfriesgarlicgeiger counterglaciergourdgraterharmonicaharpkettlelettuceloaf of breadlotus rootlycheemangomangosteenmaple leafmeatloafmotorcyclemushroomorangeparsnippeacepeachpianopicklepiepineapplepizzaplatepolygonspotato chippretzelraspberryrosemaryrubik’s cuberussian dollsalamisardinessoda canspiralsubmarinesushitacotamaletanktarragontempuratissuetissue boxtoastertomatotubaturnipviolinwafflewatermelonxylophone
harp. a
catelephanthedgehogkangaroopeacockpenguinpigsnailtapir
snail with the texture of a
accordionappleavocadobaguettebananabasilbeetrootbroomburgerburritocabbagecakecalamaricarpetcarrotchilicoconutcomfortcoral reefcorkscrewcroissantcuckoo clockcucumbercursive letterscymbalseggplanteraserfaucetfossilfried chickenfriesgarlicgeiger counterglaciergourdgraterharmonicaharpkettlelettuceloaf of breadlotus rootlycheemangomangosteenmaple leafmeatloafmotorcyclemushroomorangeparsnippeacepeachpianopicklepiepineapplepizzaplatepolygonspotato chippretzelraspberryrosemaryrubik’s cuberussian dollsalamisardinessoda canspiralsubmarinesushitacotamaletanktarragontempuratissuetissue boxtoastertomatotubaturnipviolinwafflewatermelonxylophone
harp.

AI generated images

We find that DALL·E can generate animals synthesized from a variety of concepts, including musical instruments, foods, and household items. While not always successful, we find that DALL·E sometimes takes the forms of the two objects into consideration when determining how to combine them. For example, when prompted to draw “a snail made of harp,” it sometimes relates the pillar of the harp to the spiral of the snail’s shell.

In a previous section, we saw that as more objects are introduced into the scene, DALL·E is liable to confuse the associations between the objects and their specified attributes. Here, we see a different sort of failure mode: sometimes, rather than binding some attribute of the specified concept (say, “a faucet”) to the animal (say, “a snail”), DALL·E just draws the two as separate items.

an armchair in the shape of an avocado. an armchair imitating an avocado.

![](images/dall_e-creating-images-from-text-openai/img_007.png)

Text Prompt

an
armchairbenchclockcoffee tablelampleather armchairleather pursepursesoap dispenserteapottissue box
armchair in the
shapeformstyle
shape of an
avocadobrain coralbutterfly wingdoughnutfossilglaciergourdhibiscusjapanese maplelotus rootorchidpeachpeacockpigpikachurubik's cubesardinesstrawberryturtle
avocado. an
armchairbenchclockcoffee tablelampleather armchairleather pursepursesoap dispenserteapottissue box
armchair imitating an
avocadobrain coralbutterfly wingdoughnutfossilglaciergourdhibiscusjapanese maplelotus rootorchidpeachpeacockpigpikachurubik's cubesardinesstrawberryturtle
avocado.

AI generated images

In the preceding visual, we explored DALL·E’s ability to generate fantastical objects by combining two unrelated ideas. Here, we explore its ability to take inspiration from an unrelated idea while respecting the form of the thing being designed, ideally producing an object that appears to be practically functional. We found that prompting DALL·E with the phrases “in the shape of,” “in the form of,” and “in the style of” gives it the ability to do this.

When generating some of these objects, such as “an armchair in the shape of an avocado”, DALL·E appears to relate the shape of a half avocado to the back of the chair, and the pit of the avocado to the cushion. We find that DALL·E is susceptible to the same kinds of mistakes mentioned in the previous visual.

## Animal illustrations

In the previous section, we explored DALL·E’s ability to combine unrelated concepts when generating images of real-world objects. Here, we explore this ability in the context of art, for three kinds of illustrations: anthropomorphized versions of animals and objects, animal chimeras, and emojis.

an illustration of a baby daikon radish in a tutu walking a dog

![](images/dall_e-creating-images-from-text-openai/img_005.png)

Text Prompt

an illustration of
avocadobaby bok choybaby capybarababy chipmunkbaby cucumberbaby daikon radishbaby foxbaby hedgehogbaby lemurbaby manateebaby pandababy penguinbaby sharkbaby tapirbunnyeggplantpikachushrimp
a baby daikon radish
in a beaniein a capein a christmas sweaterin a helmetin a leather jacketin a suitin a tutuin a wizard hatin pajamaswith a mustachewith headphoneswith sunglasses
in a tutu
blowing its noseflying a kiteholding an umbrella in the rainigniting a fireworkmaking a snowmanplaying a grand pianoplaying a guitarplaying chessriding a carriding a motorcycleriding a unicyclerunning a marathonserving ice creamsipping a latteskating on icestaring at its reflection in a mirrorusing a calculatorwalking a dogwatching tvwielding a blue lightsaberwriting a letter
walking a dog

AI generated images

We find that DALL·E is sometimes able to transfer some human activities and articles of clothing to animals and inanimate objects, such as food items. We include “pikachu” and “wielding a blue lightsaber” to explore DALL·E’s ability to incorporate popular media.

We find it interesting how DALL·E adapts human body parts onto animals. For example, when asked to draw a daikon radish blowing its nose, sipping a latte, or riding a unicycle, DALL·E often draws the kerchief, hands, and feet in plausible locations.

a professional high quality illustration of a giraffe turtle chimera. a giraffe imitating a turtle. a giraffe made of turtle.

![](images/dall_e-creating-images-from-text-openai/img_050.png)

Text Prompt

a professional high quality
illustrationemoji
illustration of a
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
giraffe
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
turtle chimera. a
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
giraffe imitating a
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
turtle. a
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
giraffe made of
alligatoralpacabatbeavercatchickendragoneagleeelelephantemuflamingogiraffehedgehogisopodjellyfishkangarookoalalionlobstermammothmantisoctopusowlpandapenguinphoenixpigpikachurabbitrobotsnailsnakespidersquidstarfishtigertoadtoucanturtlewalruswarthogwhalezebra
turtle.

AI generated images

We find that DALL·E is sometimes able to combine distinct animals in plausible ways. We include “pikachu” to explore DALL·E’s ability to incorporate knowledge of popular media, and “robot” to explore its ability to generate animal cyborgs. Generally, the features of the second animal mentioned in the caption tend to be dominant.

We also find that inserting the phrase “professional high quality” before “illustration” and “emoji” sometimes improves the quality and consistency of the results.

a professional high quality emoji of a lovestruck cup of boba

![](images/dall_e-creating-images-from-text-openai/img_051.png)

Text Prompt

a professional high quality emoji of a
confusedcryingcutedepressedevilhappylaughinglovestruckscaredscarysleepy
lovestruck
albatrossalpacaavocadoaxolotlbeaverbok choybowl of ramencapybaracatcockatoocup of bobadaikon radishdogdragonfruitdurianeagleelephantfrogice cream conejellyfishkoalamooseowlpenguinpigpineconeslice of pepperoni pizzasnailsnakesquashsquidstarfishsucculentsunviruswombat
cup of boba

AI generated images

We find that DALL·E is sometimes able to combine distinct animals in plausible ways. We include “pikachu” to explore DALL·E’s ability to incorporate knowledge of popular media, and “robot” to explore its ability to generate animal cyborgs. Generally, the features of the second animal mentioned in the caption tend to be dominant.

We also find that inserting the phrase “professional high quality” before “illustration” and “emoji” sometimes improves the quality and consistency of the results.

### Zero-shot visual reasoning

GPT‑3 can be instructed to perform many kinds of tasks solely from a description and a cue to generate the answer supplied in its prompt, without any additional training. For example, when prompted with the phrase “here is the sentence ‘a person walking his dog in the park’ translated into French:”, GPT‑3 answers “un homme qui promène son chien dans le parc.” This capability is called _zero-shot reasoning._ We find that DALL·E extends this capability to the visual domain, and is able to perform several kinds of image-to-image translation tasks when prompted in the right way.

the exact same cat on the top as a sketch on the bottom

![](images/dall_e-creating-images-from-text-openai/img_020.png)

Text Prompt

the exact same cat on the top
photo in grayscalephoto colored pinkphoto colored violetphoto colored bluephoto reflected upside-downanimal in extreme close-up viewanimal colored redanimal colored pinkanimal colored violetanimal colored blueanimal with sunglassesanimal with headphonesanimal wearing a hatanimal wearing a bow tiea sketch of the animala postage stamp with the animala greeting card with the animala cell phone case with the animal
as a sketch on the bottom

Image Prompt

AI generated images

We find that DALL·E is able to apply several kinds of image transformations to photos of animals, with varying degrees of reliability. The most straightforward ones, such as “photo colored pink” and “photo reflected upside-down,” also tend to be the most reliable, although the photo is often not copied or reflected exactly. The transformation “animal in extreme close-up view” requires DALL·E to recognize the breed of the animal in the photo, and render it up close with the appropriate details. This works less reliably, and for several of the photos, DALL·E only generates plausible completions in one or two instances.

Other transformations, such as “animal with sunglasses” and “animal wearing a bow tie,” require placing the accessory on the correct part of the animal’s body. Those that only change the color of the animal, such as “animal colored pink,” are less reliable, but show that DALL·E is sometimes capable of segmenting the animal from the background. Finally, the transformations “a sketch of the animal” and “a cell phone case with the animal” explore the use of this capability for illustrations and product design.

the exact same teapot on the top with ’gpt’ written on it on the bottom

![](images/dall_e-creating-images-from-text-openai/img_053.png)

Text Prompt

the exact same teapot on the top
tinybrokencolored bluecolored purplecolored pinkcolored greencolored orangecolored yellowwith stripeswith checkerswith polka dotswith a heartwith a brainwith a starwith a smiley facewith a cherry blossomwith a blue strawberrywith 'gpt' written on itwith 'sgd' written on it
with 'gpt' written on it on the bottom

Image Prompt

AI generated images

We find that DALL·E is able to apply several different kinds of image transformations to photos of teapots, with varying degrees of reliability. Aside from being able to modify the color of the teapot (e.g., “colored blue”) or its pattern (e.g., “with stripes”), DALL·E can also render text (e.g., “with ‘gpt’ written on it”) and map the letters onto the curved surface of the teapot in a plausible way. With much less reliability, it can also draw the teapot in a smaller size (for the “tiny” option) and in a broken state (for the “broken” option).

We did not anticipate that this capability would emerge, and made no modifications to the neural network or training procedure to encourage it. Motivated by these results, we measure DALL·E’s aptitude for analogical reasoning problems by testing it on Raven’s progressive matrices, a visual IQ test that saw widespread use in the 20th century.

a sequence of geometric shapes.

![](images/dall_e-creating-images-from-text-openai/img_054.png)

Text Prompt

a sequence of geometric shapes. \[\
Set BSet B, invertedSet CSet C, invertedSet DSet D, invertedSet ESet E, inverted\
Set D\]

Image Prompt

![](images/dall_e-creating-images-from-text-openai/img_055.png)Set BSet CSet DSet E Inverted

AI generated images

Rather than treating the IQ test a multiple-choice problem as originally intended, we ask DALL·E to complete the bottom-right corner of each image using argmax sampling, and consider its completion to be correct if it is a close visual match to the original.

DALL·E is often able to solve matrices that involve continuing simple patterns or basic geometric reasoning, such as those in sets B and C. It is sometimes able to solve matrices that involve recognizing permutations and applying boolean operations, such as those in set D. The instances in set E tend to be the most difficult, and DALL·E gets almost none of them correct.

For each of the sets, we measure DALL·E’s performance on both the original images, and the images with the colors inverted. The inversion of colors should pose no additional difficulty for a human, yet does generally impair DALL·E’s performance, suggesting its capabilities may be brittle in unexpected ways.

### Geographic knowledge

We find that DALL·E has learned about geographic facts, landmarks, and neighborhoods. Its knowledge of these concepts is surprisingly precise in some ways and flawed in others.

a photo of the food of china

![](images/dall_e-creating-images-from-text-openai/img_056.png)

Text Prompt

a photo of the
cafe incity streets offlag offlowers offood ofmuseum innational animal ofplants ofstadium inwildlife of
food of
AfghanistanAlbaniaAlgeriaAndorraAngolaAntigua and BarbudaArgentinaArmeniaAustraliaAustriaAzerbaijanBahamasBahrainBangladeshBarbadosBelarusBelgiumBelizeBeninBhutanBoliviaBosnia and HerzegovinaBotswanaBrazilBruneiBulgariaBurkina FasoBurundiCambodiaCameroonCanadaCape VerdeCentral African RepublicChadChileChinaColombiaComorosCongoCosta RicaCroatiaCubaCyprusCzech RepublicDenmarkDjiboutiDominicaDominican RepublicEast TimorEcuadorEgyptEl SalvadorEquatorial GuineaEritreaEstoniaEswatiniEthiopiaF.S. MicronesiaFijiFinlandFranceGabonGambiaGeorgiaGermanyGhanaGreeceGrenadaGuatemalaGuineaGuinea-BissauGuyanaHaitiHondurasHungaryIcelandIndiaIndonesiaIranIraqIrelandIsraelItalyIvory CoastJamaicaJapanJordanKazakhstanKenyaKiribatiKuwaitKyrgyzstanLaosLatviaLebanonLesothoLiberiaLibyaLiechtensteinLithuaniaLuxembourgMadagascarMalawiMalaysiaMaldivesMaliMaltaMarshall IslandsMauritaniaMauritiusMexicoMoldovaMonacoMongoliaMontenegroMoroccoMozambiqueMyanmarNamibiaNauruNepalNetherlandsNew ZealandNicaraguaNigerNigeriaNorth KoreaNorth MacedoniaNorwayOmanPakistanPalauPalestinePanamaPapua New GuineaParaguayPeruPhilippinesPolandPortugalQatarRomaniaRussiaRwandaSaint Kitts and NevisSaint LuciaSaint Vincent and the GrenadinesSan MarinoSaudi ArabiaSenegalSerbiaSeychellesSierra LeoneSingaporeSlovakiaSloveniaSolomon IslandsSomaliaSouth AfricaSouth KoreaSouth SudanSpainSri LankaSudanSurinameSwedenSwitzerlandSyriaSão Tomé and PríncipeTaiwanTajikistanTanzaniaThailandTogoTongaTrinidad and TobagoTunisiaTurkeyTurkmenistanTuvaluUgandaUkraineUnited Arab EmiratesUnited KingdomUnited StatesUruguayUzbekistanVanuatuVatican CityVenezuelaVietnamWestern SaharaWestern SamoaYemenZambiaZimbabwe
china

AI generated images

We test DALL·E’s understanding of simple geographical facts, such as country flags, cuisines, and local wildlife. While DALL·E successfully answers many of these queries, such as those involving national flags, it often reflects superficial stereotypes for choices like “food” and “wildlife,” as opposed to representing the full diversity encountered in the real world.

a photo of alamo square, san francisco, from a street at night

![](images/dall_e-creating-images-from-text-openai/img_057.png)

Text Prompt

a photo of
Alamo SquareAnza VistaAshbury HeightsBalboa ParkBalboa TerraceBayviewBelden PlaceBernal HeightsBuena VistaButchertown (Old and New)CastroCathedral HillCayuga TerraceChina BasinChinatownCivic CenterClarendon HeightsCole ValleyCorona HeightsCow HollowCrocker-AmazonDesign DistrictDiamond HeightsDogpatchDolores HeightsDuboce TriangleEmbarcaderoEureka ValleyExcelsiorFillmoreFinancial DistrictFinancial District SouthFisherman's WharfForest HillForest KnollsGlen ParkGolden Gate HeightsHaight-AshburyHayes ValleyHunters PointIndia BasinInglesideIngleside TerracesInner SunsetIrish HillIslais CreekJackson SquareJapantownJordan ParkLaguna HondaLake StreetLakesideLakeshoreLaurel HeightsLincoln ManorLittle HollywoodLittle RussiaLittle SaigonLone MountainLower HaightLower Pacific HeightsLower Nob HillMarina DistrictMerced HeightsMerced ManorMidtown TerraceMid-MarketMiraloma ParkMission BayMission DistrictMission DoloresMission TerraceMonterey HeightsMount DavidsonNob HillNoe ValleyNorth BeachNorth of PanhandleOceanviewOuter MissionOuter SunsetPacific HeightsParkmercedParksideParnassusPolk GulchPortolaPortola PlacePotrero HillPresidioPresidio HeightsRichmond DistrictRincon HillRussian HillSaint Francis WoodSea CliffSherwood ForestSilver TerraceSouth BeachSouth EndSouth of MarketSouth ParkSunnydaleSunnysideSunset DistrictTelegraph HillTenderloinTreasure IslandTwin PeaksUnion SquareUniversity MoundUpper MarketVisitacion ValleyVista del MarWest PortalWestern AdditionWestwood HighlandsWestwood ParkYerba Buena
alamo square, san francisco,
from a streetfrom the waterfrom a tall vantage point
from a street
at nightin the afternoonin the morning
at night

AI generated images

We find that DALL·E is sometimes capable of rendering semblances of certain locations in San Francisco. For locations familiar to the authors, such as San Francisco, they evoke a sense of déjà vu—eerie simulacra of streets, sidewalks and cafes that remind us of very specific locations that do not exist.

a photo of san francisco’s golden gate bridge

![](images/dall_e-creating-images-from-text-openai/img_058.png)

Text Prompt

a photo of san francisco’s
Castro TheatreCity HallFerry BuildingGolden Gate BridgeGolden Gate ParkGrace CathedralLombard StreetMission DoloresPalace of Fine ArtsPink LadiesSFMOMATransamerica Pyramid
golden gate bridge

Image Prompt

AI generated images

We can also prompt DALL·E to draw famous landmarks. In fact, we can even dictate when the photo was taken by specifying the first few rows of the sky. When the sky is dark, for example, DALL·E recognizes it is night, and turns on the lights in the buildings.

### Temporal knowledge

In addition to exploring DALL·E’s knowledge of concepts that vary over space, we also explore its knowledge of concepts that vary over time.

a photo of a phone from the 20s

![](images/dall_e-creating-images-from-text-openai/img_059.png)

Text Prompt

a photo of a
action movie postercameracomputerconveyance or vehiclemagazine covermusic devicephonetelevisionvacuum cleaner
phone from the  …

Image Prompt

AI generated images

1900

1910s

20s

30s

40s

50s

60s

70s

80s

90s

two thousands

twenty tens

today

future

distant future

We find that DALL·E has learned about basic stereotypical trends in design and technology over the decades. Technological artifacts appear to go through periods of explosion of change, dramatically shifting for a decade or two, then changing more incrementally, becoming refined and streamlined.

## Summary of approach and prior work

DALL·E is a simple decoder-only transformer that receives both the text and the image as a single stream of 1280 tokens—256 for the text and 1024 for the image—and models all of them autoregressively. The attention mask at each of its 64 self-attention layers allows each image token to attend to all text tokens. DALL·E uses the standard causal mask for the text tokens, and sparse attention for the image tokens with either a row, column, or convolutional attention pattern, depending on the layer. We provide more details about the architecture and training procedure in our [paper⁠(opens in a new window)](https://arxiv.org/abs/2102.12092).

Text-to-image synthesis has been an active area of research since the pioneering work of Reed et. al,[1](https://openai.com/index/dall-e/#citation-bottom-1) whose approach uses a GAN conditioned on text embeddings. The embeddings are produced by an encoder pretrained using a contrastive loss, not unlike CLIP. StackGAN[3](https://openai.com/index/dall-e/#citation-bottom-3) and StackGAN++[4](https://openai.com/index/dall-e/#citation-bottom-4) use multi-scale GANs to scale up the image resolution and improve visual fidelity. AttnGAN[5](https://openai.com/index/dall-e/#citation-bottom-5) incorporates attention between the text and image features, and proposes a contrastive text-image feature matching loss as an auxiliary objective. This is interesting to compare to our reranking with CLIP, which is done offline. Other work[2](https://openai.com/index/dall-e/#citation-bottom-2), [6](https://openai.com/index/dall-e/#citation-bottom-6), [7](https://openai.com/index/dall-e/#citation-bottom-7) incorporates additional sources of supervision during training to improve image quality. Finally, work by Nguyen et. al[8](https://openai.com/index/dall-e/#citation-bottom-8) and Cho et. al[9](https://openai.com/index/dall-e/#citation-bottom-9) explores sampling-based strategies for image generation that leverage pretrained multimodal discriminative models.

Similar to the rejection sampling used in [VQVAE-2⁠(opens in a new window)](https://arxiv.org/abs/1906.00446), we use [CLIP⁠](https://openai.com/index/clip/) to rerank the top 32 of 512 samples for each caption in all of the interactive visuals. This procedure can also be seen as a kind of language-guided search[16](https://openai.com/index/dall-e/#citation-bottom-16), and can have a dramatic impact on sample quality.

an illustration of a baby daikon radish in a tutu walking a dog \[caption 1, best 8 of 2048\]

![](images/dall_e-creating-images-from-text-openai/img_060.png)

Text Prompt

an illustration of a baby daikon radish in a tutu walking a dog \[\
caption 1caption 2caption 3caption 4caption 5caption 6caption 7caption 8caption 9caption 10\
caption 1, best  … \]

AI generated images

8 of 8

8 of 32

8 of 128

8 of 512

8 of 2048

Reranking the samples from DALL·E using CLIP can dramatically improve consistency and quality of the samples.

- [DALL·E](https://openai.com/research/index/?tags=dall-e)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Language](https://openai.com/research/index/?tags=language)
- [Transformers](https://openai.com/research/index/?tags=transformers)

## Footnotes

1. A
A token is any symbol from a discrete vocabulary; for humans, each English letter is a token from a 26-letter alphabet. DALL·E’s vocabulary has tokens for both text and image concepts. Specifically, each image caption is represented using a maximum of 256 BPE-encoded tokens with a vocabulary size of 16384, and the image is represented using 1024 tokens with a vocabulary size of 8192.


The images are preprocessed to 256x256 resolution during training. Similar to VQVAE, each image is compressed to a 32x32 grid of discrete latent codes using a discrete VAE that we pretrained using a continuous relaxation. We found that training using the relaxation obviates the need for an explicit codebook, EMA loss, or tricks like dead code revival, and can scale up to large vocabulary sizes.

1. B
Further details provided in [a later section⁠](https://openai.com/index/dall-e/#summary).

2. 17
This task is called variable binding, and has been extensively studied in the literature.


## References

01. 1
    Reed, S., Akata, Z., Yan, X., Logeswaran, L., Schiele, B., Lee, H. (2016). “ [Generative adversarial text to image synthesis⁠(opens in a new window)](https://arxiv.org/abs/1605.05396)”. In ICML 2016.

02. 2
    Reed, S., Akata, Z., Mohan, S., Tenka, S., Schiele, B., Lee, H. (2016). “ [Learning what and where to draw⁠(opens in a new window)](https://arxiv.org/abs/1610.02454)”. In NIPS 2016.

03. 3
    Zhang, H., Xu, T., Li, H., Zhang, S., Wang, X., Huang X., Metaxas, D. (2016). “ [StackGAN: Text to photo-realistic image synthesis with stacked generative adversarial networks⁠(opens in a new window)](https://arxiv.org/abs/1612.03242)”. In ICCY 2017.

04. 4
    Zhang, H., Xu, T., Li, H., Zhang, S., Wang, X., Huang, X., Metaxas, D. (2017). “ [StackGAN++: realistic image synthesis with stacked generative adversarial networks⁠(opens in a new window)](https://arxiv.org/abs/1710.10916)”. In IEEE TPAMI 2018.

05. 5
    Xu, T., Zhang, P., Huang, Q., Zhang, H., Gan, Z., Huang, X., He, X. (2017). “ [AttnGAN: Fine-grained text to image generation with attentional generative adversarial networks⁠(opens in a new window)](https://arxiv.org/abs/1711.10485).

06. 6
    Li, W., Zhang, P., Zhang, L., Huang, Q., He, X., Lyu, S., Gao, J. (2019). “ [Object-driven text-to-image synthesis via adversarial training⁠(opens in a new window)](https://arxiv.org/abs/1902.10740)”. In CVPR 2019.

07. 7
    Koh, J. Y., Baldridge, J., Lee, H., Yang, Y. (2020). “ [Text-to-image generation grounded by fine-grained user attention⁠(opens in a new window)](https://arxiv.org/abs/2011.03775)”. In WACV 2021.

08. 8
    Nguyen, A., Clune, J., Bengio, Y., Dosovitskiy, A., Yosinski, J. (2016). “ [Plug & play generative networks: conditional iterative generation of images in latent space⁠(opens in a new window)](https://arxiv.org/abs/1612.00005).

09. 9
    Cho, J., Lu, J., Schwen, D., Hajishirzi, H., Kembhavi, A. (2020). “ [X-LXMERT: Paint, caption, and answer questions with multi-modal transformers⁠(opens in a new window)](https://arxiv.org/abs/2009.11278)”. EMNLP 2020.

10. 10
    Kingma, Diederik P., and Max Welling. “ [Auto-encoding variational bayes⁠(opens in a new window)](https://arxiv.org/abs/1312.6114).” arXiv preprint (2013).

11. 11
    Rezende, Danilo Jimenez, Shakir Mohamed, and Daan Wierstra. “ [Stochastic backpropagation and approximate inference in deep generative models⁠(opens in a new window)](https://arxiv.org/abs/1401.4082).” arXiv preprint (2014).

12. 12
    Jang, E., Gu, S., Poole, B. (2016). “ [Categorical reparametrization with Gumbel-softmax⁠(opens in a new window)](https://arxiv.org/abs/1611.01144)”.

13. 13
    Maddison, C., Mnih, A., Teh, Y. W. (2016). “ [The Concrete distribution: a continuous relaxation of discrete random variables⁠(opens in a new window)](https://arxiv.org/abs/1611.00712)”.

14. 14
    van den Oord, A., Vinyals, O., Kavukcuoglu, K. (2017). “ [Neural discrete representation learning⁠(opens in a new window)](https://arxiv.org/abs/1711.00937)”.

15. 15
    Razavi, A., van der Oord, A., Vinyals, O. (2019). “ [Generating diverse high-fidelity images with VQ-VAE-2⁠(opens in a new window)](https://arxiv.org/abs/1906.00446)”.

16. 16
    Andreas, J., Klein, D., Levine, S. (2017). “ [Learning with Latent Language⁠(opens in a new window)](https://arxiv.org/abs/1711.00482)”.

17. 17
    Smolensky, P. (1990). “ [Tensor product variable binding and the representation of symbolic structures in connectionist systems⁠(opens in a new window)](http://www.lscp.net/persons/dupoux/teaching/AT1_2014/papers/Smolensky_1990_TensorProductVariableBinding.AI.pdf)”.

18. 18
    Plate, T. (1995). “ [Holographic reduced representations: convolution algebra for compositional distributed representations⁠(opens in a new window)](https://www.ijcai.org/Proceedings/91-1/Papers/006.pdf)”.

19. 19
    Gayler, R. (1998). “ [Multiplicative binding, representation operators & analogy⁠(opens in a new window)](http://cogprints.org/502/)”.

20. 20
    Kanerva, P. (1997). “ [Fully distributed representations⁠(opens in a new window)](http://www.cap-lore.com/RWC97-kanerva.pdf)”.


## Primary Authors

[Aditya Ramesh](https://openai.com/news/?author=aditya-ramesh#results), [Mikhail Pavlov](https://openai.com/news/?author=mikhail-pavlov#results), [Gabriel Goh](https://openai.com/news/?author=gabriel-goh#results), [Scott Gray](https://openai.com/news/?author=scott-gray#results)

## Supporting Authors

[Mark Chen](https://openai.com/news/?author=mark-chen#results), [Rewon Child](https://openai.com/news/?author=rewon-child#results), [Vedant Misra](https://openai.com/news/?author=vedant-misra#results), [Pamela Mishkin](https://openai.com/news/?author=pamela-mishkin#results), [Gretchen Krueger](https://openai.com/news/?author=gretchen-krueger#results), [Sandhini Agarwal](https://openai.com/news/?author=sandhini-agarwal#results), [Ilya Sutskever](https://openai.com/news/?author=ilya-sutskever#results)

## Related articles

[View all](https://openai.com/news/milestone/)

![Whisper](images/dall_e-creating-images-from-text-openai/img_061.png)

[Introducing Whisper\\
\\
ReleaseSep 21, 2022](https://openai.com/index/whisper/)

![An aerial view of a crowd of people facing away, wearing hats and bearing flags](images/dall_e-creating-images-from-text-openai/img_062.png)

[DALL·E 2 pre-training mitigations\\
\\
PublicationJun 28, 2022](https://openai.com/index/dall-e-2-pre-training-mitigations/)

![Hierarchical Text Conditional Image Generation With Clip Latents](images/dall_e-creating-images-from-text-openai/img_063.jpg)

[Hierarchical text-conditional image generation with CLIP latents\\
\\
PublicationApr 13, 2022](https://openai.com/index/hierarchical-text-conditional-image-generation-with-clip-latents/)

DALL·E: Creating images from text \| OpenAI