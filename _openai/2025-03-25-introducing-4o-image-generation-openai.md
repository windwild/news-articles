---
render_with_liquid: false
title: "Introducing 4o Image Generation | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-4o-image-generation"
date: "2025-03-25"
scraped_at: "2026-03-02T10:13:39.837823685+00:00"
language: "en-US"
translated: false
description: "At OpenAI, we have long believed image generation should be a primary capability of our language models. That’s why we’ve built our most advanced image generator yet into GPT‑4o. The result—im..."
tags: ["Product"]
---

March 25, 2025

[Product](https://openai.com/news/product-releases/) [Release](https://openai.com/research/index/release/)

# Introducing 4o Image Generation

Unlocking useful and valuable image generation with a natively multimodal model capable of precise, accurate, photorealistic outputs.

[Try in ChatGPT (opens in a new window)](https://chatgpt.com/?openaicom-did=4ebb3be2-525f-479b-a244-0aca21e4b36d&openaicom_referred=true)



At OpenAI, we have long believed image generation should be a primary capability of our language models. That’s why we’ve built our most advanced image generator yet into GPT‑4o. The result—image generation that is not only beautiful, but useful.

A wide image taken with a phone of a glass whiteboard, in a room overlooking the Bay Bridge. The field of view shows a woman writing, sporting a tshirt wiith a large OpenAI logo. The handwriting looks natural and a bit messy, and we see the photographer's reflection.

The text reads:

(left)

"Transfer between Modalities:

Suppose we directly model

p(text, pixels, sound) \[equation\]

with one big autoregressive transformer.

Pros:

\\* image generation augmented with vast world knowledge

\\* next-level text rendering

\\* native in-context learning

\\* unified post-training stack

Cons:

\\* varying bit-rate across modalities

\\* compute not adaptive"

(Right)

"Fixes:

\\* model compressed representations

\\* compose autoregressive prior with a powerful decoder"

On the bottom right of the board, she draws a diagram:

"tokens -> \[transformer\] -> \[diffusion\] -> pixels"

Read more

![oai_image-generation_whiteboard1](images/introducing-4o-image-generation-openai/img_001.png)

_Best of 8_

selfie view of the photographer, as she turns around to high five him

![oai_image-generation_whiteboard2](images/introducing-4o-image-generation-openai/img_002.png)

_Best of 8_

## Useful image generation

From the first cave paintings to modern infographics, humans have used visual imagery to communicate, persuade, and analyze—not just to decorate. Today's generative models can conjure surreal, breathtaking scenes, but struggle with the workhorse imagery people use to share and create information. From logos to diagrams, images can convey precise meaning when augmented with symbols that refer to shared language and experience.

GPT‑4o image generation excels at accurately rendering text, precisely following prompts, and leveraging 4o’s inherent knowledge base and chat context—including transforming uploaded images or using them as visual inspiration. These capabilities make it easier to create exactly the image you envision, helping you communicate more effectively through visuals and advancing image generation into a practical tool with precision and power.

00:00

00:00

00:00

00:00

00:00

## Improved capabilities

We trained our models on the joint distribution of online images and text, learning not just how images relate to language, but how they relate to each other. Combined with aggressive post-training, the resulting model has surprising visual fluency, capable of generating images that are useful, consistent, and context-aware.

### Text rendering

A picture is worth a thousand words, but sometimes generating a few words in the right place can elevate the meaning of an image. 4o’s ability to blend precise symbols with imagery turns image generation into a tool for visual communication.

Create a photorealistic image of two witches in their 20s (one ash balayage, one with long wavy auburn hair) reading a street sign.

Context:

a city street in a random street in Williamsburg, NY with a pole covered entirely by numerous detailed street signs (e.g., street sweeping hours, parking permits required, vehicle classifications, towing rules), including few ridiculous signs at the middle: (paraphrase it to make these legitimate street signs)"Broom Parking for Witches Not Permitted in Zone C" and "Magic Carpet Loading and Unloading Only (15-Minute Limit)" and "Reindeer Parking by Permit Only (Dec 24–25)

Violators will be placed on Naughty List." The signpost is on the right of a street. Do not repeat signs. Signs must be realistic.

Characters:

one witch is holding a broom and the other has a rolled-up magic carpet. They are in the foreground, back slightly turned towards the camera and head slightly tilted as they scrutinize the signs.

Composition from background to foreground:

streets + parked cars + buildings -> street sign -> witches. Characters must be closest to the camera taking the shot

Read more

![image-gen-4o-street-sign](images/introducing-4o-image-generation-openai/img_003.png)

_Best of ~8_

### Multi-turn generation

Because image generation is now native to GPT‑4o, you can refine images through natural conversation. GPT‑4o can build upon images and text in chat context, ensuring consistency throughout. For example, if you’re designing a video game character, the character’s appearance remains coherent across multiple iterations as you refine and experiment.

![minnias cat input](images/introducing-4o-image-generation-openai/img_004.png)

Give this cat a detective hat and a monocle

![minnias-cat-2](images/introducing-4o-image-generation-openai/img_005.png)

_Best of 1_

turn this into a triple A video games made with a 4k game engine and add some User interface as overlay from a mystery RPG where we can see a health bar and a minimap at the top as well as spells at the bottom with consistent and iconography

![minnias cat2](images/introducing-4o-image-generation-openai/img_006.png)

_Best of 1_

update to a landscape image 16:9 ratio, add more spells in the UI, and unzoom the visual so that we see the cat in a third person view walking through a steampunk manhattan creating beautiful contrast and lighting like in the best triple A game, with cool-toned colors

![minnias cat3](images/introducing-4o-image-generation-openai/img_007.png)

_Best of 2_

create the interface when the player opens the menu and we see the cat's character profile with his equipment and another page showing active quests (and it should make sense in relationship with the universe worldbuilding we are describing in the image)

![minnias cat4](images/introducing-4o-image-generation-openai/img_008.png)

_Best of 8_

credit creator: Manuel Sainsily

### Instruction following

GPT‑4o’s image generation follows detailed prompts with attention to detail. While other systems struggle with ~5-8 objects, GPT‑4o can handle up to 10-20 different objects. The tighter binding of objects to their traits and relations allows for better control.

A square image containing a 4 row by 4 column grid containing 16 objects on a white background. Go from left to right, top to bottom. Here's the list:

1\. a blue star

2\. red triangle

3\. green square

4\. pink circle

5\. orange hourglass

6\. purple infinity sign

7\. black and white polka dot bowtie

8\. tiedye "42"

9\. an orange cat wearing a black baseball cap

10\. a map with a treasure chest

11\. a pair of googly eyes

12\. a thumbs up emoji

13\. a pair of scissors

14\. a blue and white giraffe

15\. the word "OpenAI" written in cursive

16\. a rainbow-colored lightning bolt

Read more

![Screenshot 2025-03-24 at 10.07.12 AM](images/introducing-4o-image-generation-openai/img_009.png)

_Best of 5_

### In-context learning

GPT‑4o can analyze and learn from user-uploaded images, seamlessly integrating their details into its context to inform image generation.

![in-context-learning-prompt](images/introducing-4o-image-generation-openai/img_010.png)

- draw a design for a vehicle with triangular wheels, using these images as reference.
- label the front wheel, the back wheel, and at the of the diagram say (in small caps)
- TRIANGLE WHEELED VEHICLE. English Patent. 2025. OPENAI.

![Screenshot 2025-03-24 at 10.41.56 AM](images/introducing-4o-image-generation-openai/img_011.png)

_Best of ~16_

now put this in a photo taken in new york city.

![Screenshot 2025-03-24 at 10.42.45 AM](images/introducing-4o-image-generation-openai/img_012.png)

_Best of ~16_

### World knowledge

Native image generation enables 4o to link its knowledge between text and images, resulting in a model that feels smarter and more efficient.

**Code Example (Three.js)**

Unknown component type: {componentType}

make an image of what this means to you

![Screenshot 2025-03-18 at 11.46.24 AM](images/introducing-4o-image-generation-openai/img_013.png)

## Photorealism and style

Training on images reflecting a vast variety of image styles allows the model to create or transform images convincingly.

![A candid paparazzi-style photo of Karl Marx hurriedly walking through the parking lot of the Mall of America, glancing over his shoulder with a startled expression as he tries to avoid being photographed. He’s clutching multiple glossy shopping bags filled with luxury goods. His coat flutters behind him in the wind, and one of the bags is swinging as if he’s mid-stride. Blurred background with cars and a glowing mall entrance to emphasize motion. Flash glare from the camera partially overexposes the image, giving it a chaotic, tabloid feel.](images/introducing-4o-image-generation-openai/img_014.png)

![A cat looking into a puddle of water on a street, but its reflection is that of a tiger, and both reflections are realistically distorted by ripples in the water](images/introducing-4o-image-generation-openai/img_015.png)

![Generate a candid, Polaroid-style photograph of four diverse friends in their early 20s at a gritty dive bar. The lighting features a very harsh, direct flash, creating sharp shadows and giving the photo a very overexposed, vintage instant-camera feel. Colors should be slightly muted, evoking nostalgic, early-2000s party vibes. The aesthetic is casually emo. No border or logos or signs. There's an interesting looking wall behind them with some light graffiti. Quality of the image should be very sharp and detailed (very little grain). The energy should be silly and chaotic. They're either playfully grimacing, smiling, or pretending to look tough. One of them should have their friend in a silly, playful headlock. Their mouths are closed.](images/introducing-4o-image-generation-openai/img_016.png)

![Generate a photorealistic image of farmer's market in toronto on a saturday in summer 2006, it's a beautiful late june day, people are shopping and eating sandwiches. in focus should be a young asian girl wearing denim overalls and sipping on a strawberry banana smoothie - rest can be blurred. the photo should be reminiscent of that a digital camera from 2006 would take, with a timestamp like a printed photo would have. aspect ratio should be 3:2](images/introducing-4o-image-generation-openai/img_017.png)

![blurry old analog film photograph, picture of parked car on side street, quiet night. credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_018.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2R9czqCiP1nqec6UED0AJd/0f24e9e9299c871ffd3d5b76f5635d16/roope-car.png?w=3840&q=90&fm=webp)

![Create image super-realistic picture of these 4 creatures playing poker on a picnic blanket, zoomed out, in dolores park. photorealistic. The tabby long haired cat is holding a hand; right next to it are 2 tall vertical black chips (with stripes) as it has been raking in the dough.  Tabby's pupils are large and cute, and ii looking down and scrutinizing its cards, focused. Derpy black cat went all in. Two dogs are peering over cat's shoulder to see their cards. All cards are face down and of the same back color except for an exposed three of diamonds. small stack of poker chips are in front of each creature, but black cat went all in. the two dogs folded. All chips are from the same set and all cards have same color. photorealistic, shot on iphone, raw format.](images/introducing-4o-image-generation-openai/img_019.png)

![Best of 1 | Generate an portrait ad on a solid pastel background.  In solid white san serif text, "ChatGPT image generation" in the top left, about a third of the way down.  In solid white san serif text, "Form follows function", in the bottom right, about a third of the way up.  In the background, put a photo of a really sleek, modern sculpture. It should gradually transition from a wireframe sketch on the left to the fully photorealistic version on the right.   At the very bottom, in medium-small text, say "This entire poster was generated by ChatGPT image generation."](images/introducing-4o-image-generation-openai/img_020.png)

![A lone astronaut floats inside a vast space station, painting swirling galaxies onto a massive canvas that hangs weightlessly in the air. Their paintbrush leaves behind trails of cosmic dust, and their suit is stained with nebula-colored hues. Their helmet is off, revealing eyes filled with the reflection of distant planets. Outside the glass window, a black hole looms, twisting light into mesmerizing patterns.](images/introducing-4o-image-generation-openai/img_021.png)

![Realistic photograph of a horse galloping from right to left across a vast, calm ocean surface, accurately depicting splashes, reflections, and subtle ripple patterns beneath their hooves. Exaggerate horse movements but everything else should be still, quiet to show contrast with the horse's strength. clean composition, cinematographic. A wide, panoramic composition showcasing a distant horizon. Atmospheric perspective creating depth. zoomed out so the horse appears minuscule compared to vast ocean.  horse is right at the horizon where ocean meets sky. use rule of thirds to position horse. size of horse is 1% size of entire image because camera is so far away from subject. camera view is super close to the ground/ocean like a worm's eye view. horse is galloping right where ocean meets the sky](images/introducing-4o-image-generation-openai/img_022.png)

![A realistic underwater scene with dolphins swimming through the windows of an abandoned subway car, with bubbles and detailed water flow accurately simulated.](images/introducing-4o-image-generation-openai/img_023.png)

![Photo of a fruit bowl consisting of real fruits mixed with miniature planets (Jupiter, Saturn, Mars, Earth), maintaining realistic reflections, lighting, and shadows consistent with original photo, clean composition, authentic textures, crisp detailed rendering](images/introducing-4o-image-generation-openai/img_024.png)

A candid paparazzi-style photo of Karl Marx hurriedly walking through the parking lot of the Mall of America, glancing over his shoulder with a startled expression as he tries to avoid being photographed. He’s clutching multiple glossy shopping bags filled with luxury goods. His coat flutters behind him in the wind, and one of the bags is swinging as if he’s mid-stride. Blurred background with cars and a glowing mall entrance to emphasize motion. Flash glare from the camera partially overexposes the image, giving it a chaotic, tabloid feel.

A candid paparazzi-style photo of Karl Marx hurriedly walking through the parking lot of the Mall of America, glancing over his shoulder with a startled expression as he tries to avoid being photographed. He’s clutching multiple glossy shopping bags filled with luxury goods. His coat flutters behind him in the wind, and one of the bags is swinging as if he’s mid-stride. Blurred background with cars and a glowing mall entrance to emphasize motion. Flash glare from the camera partially overexposes the image, giving it a chaotic, tabloid feel.

A candid paparazzi-style photo of Karl Marx hurriedly walking through the parking lot of the Mall of America, glancing over his shoulder with a startled expression as he tries to avoid being photographed. He’s clutching multiple glossy shopping bags filled with luxury goods. His coat flutters behind him in the wind, and one of the bags is swinging as if he’s mid-stride. Blurred background with cars and a glowing mall entrance to emphasize motion. Flash glare from the camera partially overexposes the image, giving it a chaotic, tabloid feel.

Read more

- ![A candid paparazzi-style photo of Karl Marx hurriedly walking through the parking lot of the Mall of America, glancing over his shoulder with a startled expression as he tries to avoid being photographed. He’s clutching multiple glossy shopping bags filled with luxury goods. His coat flutters behind him in the wind, and one of the bags is swinging as if he’s mid-stride. Blurred background with cars and a glowing mall entrance to emphasize motion. Flash glare from the camera partially overexposes the image, giving it a chaotic, tabloid feel.](images/introducing-4o-image-generation-openai/img_014.png)

- ![A cat looking into a puddle of water on a street, but its reflection is that of a tiger, and both reflections are realistically distorted by ripples in the water](images/introducing-4o-image-generation-openai/img_015.png)

- ![Generate a candid, Polaroid-style photograph of four diverse friends in their early 20s at a gritty dive bar. The lighting features a very harsh, direct flash, creating sharp shadows and giving the photo a very overexposed, vintage instant-camera feel. Colors should be slightly muted, evoking nostalgic, early-2000s party vibes. The aesthetic is casually emo. No border or logos or signs. There's an interesting looking wall behind them with some light graffiti. Quality of the image should be very sharp and detailed (very little grain). The energy should be silly and chaotic. They're either playfully grimacing, smiling, or pretending to look tough. One of them should have their friend in a silly, playful headlock. Their mouths are closed.](images/introducing-4o-image-generation-openai/img_016.png)

- ![Generate a photorealistic image of farmer's market in toronto on a saturday in summer 2006, it's a beautiful late june day, people are shopping and eating sandwiches. in focus should be a young asian girl wearing denim overalls and sipping on a strawberry banana smoothie - rest can be blurred. the photo should be reminiscent of that a digital camera from 2006 would take, with a timestamp like a printed photo would have. aspect ratio should be 3:2](images/introducing-4o-image-generation-openai/img_017.png)

- ![blurry old analog film photograph, picture of parked car on side street, quiet night. credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_018.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2R9czqCiP1nqec6UED0AJd/0f24e9e9299c871ffd3d5b76f5635d16/roope-car.png?w=3840&q=90&fm=webp)

- ![Create image super-realistic picture of these 4 creatures playing poker on a picnic blanket, zoomed out, in dolores park. photorealistic. The tabby long haired cat is holding a hand; right next to it are 2 tall vertical black chips (with stripes) as it has been raking in the dough.  Tabby's pupils are large and cute, and ii looking down and scrutinizing its cards, focused. Derpy black cat went all in. Two dogs are peering over cat's shoulder to see their cards. All cards are face down and of the same back color except for an exposed three of diamonds. small stack of poker chips are in front of each creature, but black cat went all in. the two dogs folded. All chips are from the same set and all cards have same color. photorealistic, shot on iphone, raw format.](images/introducing-4o-image-generation-openai/img_019.png)

- ![Best of 1 | Generate an portrait ad on a solid pastel background.  In solid white san serif text, "ChatGPT image generation" in the top left, about a third of the way down.  In solid white san serif text, "Form follows function", in the bottom right, about a third of the way up.  In the background, put a photo of a really sleek, modern sculpture. It should gradually transition from a wireframe sketch on the left to the fully photorealistic version on the right.   At the very bottom, in medium-small text, say "This entire poster was generated by ChatGPT image generation."](images/introducing-4o-image-generation-openai/img_020.png)

- ![A lone astronaut floats inside a vast space station, painting swirling galaxies onto a massive canvas that hangs weightlessly in the air. Their paintbrush leaves behind trails of cosmic dust, and their suit is stained with nebula-colored hues. Their helmet is off, revealing eyes filled with the reflection of distant planets. Outside the glass window, a black hole looms, twisting light into mesmerizing patterns.](images/introducing-4o-image-generation-openai/img_021.png)

- ![Realistic photograph of a horse galloping from right to left across a vast, calm ocean surface, accurately depicting splashes, reflections, and subtle ripple patterns beneath their hooves. Exaggerate horse movements but everything else should be still, quiet to show contrast with the horse's strength. clean composition, cinematographic. A wide, panoramic composition showcasing a distant horizon. Atmospheric perspective creating depth. zoomed out so the horse appears minuscule compared to vast ocean.  horse is right at the horizon where ocean meets sky. use rule of thirds to position horse. size of horse is 1% size of entire image because camera is so far away from subject. camera view is super close to the ground/ocean like a worm's eye view. horse is galloping right where ocean meets the sky](images/introducing-4o-image-generation-openai/img_022.png)

- ![A realistic underwater scene with dolphins swimming through the windows of an abandoned subway car, with bubbles and detailed water flow accurately simulated.](images/introducing-4o-image-generation-openai/img_023.png)

- ![Photo of a fruit bowl consisting of real fruits mixed with miniature planets (Jupiter, Saturn, Mars, Earth), maintaining realistic reflections, lighting, and shadows consistent with original photo, clean composition, authentic textures, crisp detailed rendering](images/introducing-4o-image-generation-openai/img_024.png)


## Limitations

Our model isn’t perfect. We’re aware of multiple limitations at the moment which we will work to address through model improvements after the initial launch.

![cropping](images/introducing-4o-image-generation-openai/img_036.png)

We’ve noticed that GPT‑4o can occasionally crop longer images, like posters, too tightly, especially near the bottom.

## Safety

In line with our Model Spec, we aim to maximize creative freedom by supporting valuable use cases like game development, historical exploration, and education—while maintaining strong safety standards. At the same time, it remains as important as ever to block requests that violate those standards. Below are evaluations of additional risk areas where we're working to enable safe, high-utility content and support broader creative expression for users.

**Provenance via C2PA and internal reversible search** All generated images come with C2PA⁠ metadata, which will identify an image as coming from GPT‑4o, to provide transparency. We’ve also built an internal search tool that uses technical attributes of generations to help verify if content came from our model.

**Blocking the bad stuff** We’re continuing to block requests for generated images that may violate our content policies, such as child sexual abuse materials and sexual deepfakes. When images of real people are in context, we have heightened restrictions regarding what kind of imagery can be created, with particularly robust safeguards around nudity and graphic violence. As with any launch, safety is never finished and is rather an ongoing area of investment. As we learn more about real-world use of this model, we’ll adjust our policies accordingly.

For more on our approach, visit the image generation [addendum to the GPT‑4o system card⁠](https://openai.com/index/gpt-4o-image-generation-system-card-addendum/).

**Using reasoning to power safety** Similar to our [deliberative alignment⁠](https://openai.com/index/deliberative-alignment/) work, we’ve trained a reasoning LLM to work directly from human-written and interpretable safety specifications. We used this reasoning LLM during development to help us identify and address ambiguities in our policies. Together with our multimodal advancements and existing safety techniques developed for ChatGPT and Sora, this allows us to [moderate⁠](https://openai.com/index/upgrading-the-moderation-api-with-our-new-multimodal-moderation-model/) both input text and output images against our policies.

## Access and availability

4o image generation rolls out starting today to Plus, Pro, Team, and Free users as the default image generator in ChatGPT, with access coming soon to Enterprise and Edu. It’s also available to use in Sora. For those who hold a special place in their hearts for DALL·E, it can still be accessed through a dedicated DALL·E GPT.

Developers will soon be able to generate images with GPT‑4o via the API, with access rolling out in the next few weeks.

Creating and customizing images is as simple as chatting using GPT‑4o - just describe what you need, including any specifics like aspect ratio, exact colors using hex codes, or a transparent background. Because this model creates more detailed pictures, images take longer to render, often up to one minute.

![credit creator: [Alex Duffy](images/introducing-4o-image-generation-openai/img_037.jpg)](https://images.ctfassets.net/kftzwdyauwt9/4mDKmV3ex9OT8wyAFGDAQS/1b0e1baacb80125e1f92e66dbdf1e32a/Alex_Duffy1.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/30DNW3QcEb1BosJhJqPAfA/56e4708045e63d40d5fe31c122da2bfb/August_Kamp_2.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2ukMfLwQHGEnwMbS43M3Hf/6f5fa57419fdc16ca603e41c1ac290ff/August_Kamp_3.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2KZaGKW5emVRwnYBMcMYCP/560cd7d513aed92b4a943b66b6b5e836/August_Kamp_4.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2PVNlktDwuJJgAlrviWfF1/bf374f33e21c41e770068f4f66a22394/August_Kamp_5.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/39oS3hSQqMSqHHNAS0q3DB/0624bcc17a3e7a3fd318a1eb5c63146e/August_Kamp.png?w=3840&q=90&fm=webp)

![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5WdHD3ToXx1mj13bjDhdQh/46c283533309492585f3538a5ed3a2fd/August_Kamp_1_.png?w=3840&q=90&fm=webp)

![credit creator: Cassandra Ansara](images/introducing-4o-image-generation-openai/img_044.png)

![credit creator: [Isa](images/introducing-4o-image-generation-openai/img_045.jpg)](https://images.ctfassets.net/kftzwdyauwt9/37BlQeBhtmTAazdT7LyRIU/7e6472d3ba12c22748cf14a670c0a725/Copy_of_Isa.png?w=3840&q=90&fm=webp)

![credit creator: [Isa](images/introducing-4o-image-generation-openai/img_045.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2pRf2V2Zmd1YF7GfBtfRwG/92ac8188795fcdd4be9152a27a971289/Copy_of_Isa2.png?w=3840&q=90&fm=webp)

![credit creator: Les Morgan](images/introducing-4o-image-generation-openai/img_047.png)

![credit creator: Les Morgan](images/introducing-4o-image-generation-openai/img_048.png)

![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2D1UY4SXAHAxN0uCGT4KCd/43da3a5152c1a823fdf2bed6acea5cf8/Derya_Unutmaz1.png?w=3840&q=90&fm=webp)

![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1jRz4YFkVwGIVQC6yz5DJV/af2ed5507df32860b8b82a4a326c437e/Derya2.jpg?w=3840&q=90&fm=webp)

![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1hakInZjBH5SENKVLD68Gl/0140eb82eae9e5cd2f1fbc7ef8f5c46c/Derya3.png?w=3840&q=90&fm=webp)

![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/3viXLb1u1ZsUXju6gc0Izh/51b37635165df801077399b26e6c0ff5/Elene_6.png?w=3840&q=90&fm=webp)

![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/6EoS1QOv0KOi4aESduy0cU/12705b1ca86abce06bf7366f98e9a8c7/Elene_Chekurishvili.png?w=3840&q=90&fm=webp)

![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5sKaN7iVvtLlzGJQtFmfMg/4ef6d51d2e54d4effd3019401401deb1/Elene3.jpeg?w=3840&q=90&fm=webp)

![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1iA7pHLA84KDCRIuoG5pTk/ae8e52600bfbd53a10a749dcd78b2382/Elene4.jpeg?w=3840&q=90&fm=webp)

![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5MPmWWYE3fDk6M5QSpA0X8/ac729246785fc8d052be4427085bbcda/Elene5.png?w=3840&q=90&fm=webp)

![credit creator: [Eugenio Marongiu](images/introducing-4o-image-generation-openai/img_057.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2CrXaGuZ3fcCIyKNcDaiRr/26fb7c949919a2de82f7b8340ad4e708/Eugenio_Marongiu.png?w=3840&q=90&fm=webp)

![credit creator: [Eugenio Marongiu](images/introducing-4o-image-generation-openai/img_057.jpg)](https://images.ctfassets.net/kftzwdyauwt9/6JJh92fHC6diXnnj0rz6DP/53a43e30200729a648cfda1faa6328a5/Eugenio2.png?w=3840&q=90&fm=webp)

![credit creator: Jesse Kramme](images/introducing-4o-image-generation-openai/img_059.png)

![credit creator: Jesse Kramme](images/introducing-4o-image-generation-openai/img_060.png)

![credit creator: Matthew Dear](images/introducing-4o-image-generation-openai/img_061.png)

![credit creator: [Minh Do](images/introducing-4o-image-generation-openai/img_062.jpg)](https://images.ctfassets.net/kftzwdyauwt9/tZr3EpmNfrkZBQAIYMffM/d85415f7a01a49718adf2509bb9ad8f1/Minh_Do1.png?w=3840&q=90&fm=webp)

![credit creator: [Niceaunties](images/introducing-4o-image-generation-openai/img_063.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1TQS4fCbgIOjdnML4u6i5o/bc81b9ff76e503e32b69dbf447a967e6/niceaunties.png?w=3840&q=90&fm=webp)

![credit creator: Eskcanta](images/introducing-4o-image-generation-openai/img_064.png)

![credit creator: Eskcanta](images/introducing-4o-image-generation-openai/img_065.png)

![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1TYYxCnSFWzwoEOHJ7OlfC/767ce4ec94b972138598cce0be1e8d79/Roope_2.png?w=3840&q=90&fm=webp)

![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2Gr22uAGGIQjmDBQt2ccKx/620417fa3b9667f7e95a1fd98c692203/Roope_3.png?w=3840&q=90&fm=webp)

![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5neXFSFNWbbdhruFManjbU/3a084e08790a90af52cb7005372539b9/Roope_Rainisto1.png?w=3840&q=90&fm=webp)

![credit creator: Shane Copenhagen](images/introducing-4o-image-generation-openai/img_069.png)

![credit creator: Will Maberry](images/introducing-4o-image-generation-openai/img_070.jpg)

![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_071.png)

![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_072.png)

![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_073.png)

![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_074.png)

![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_075.png)

credit creator: Manuel Sainsily

credit creator: Manuel Sainsily

credit creator: Manuel Sainsily

Read more

- ![credit creator: [Alex Duffy](images/introducing-4o-image-generation-openai/img_037.jpg)](https://images.ctfassets.net/kftzwdyauwt9/4mDKmV3ex9OT8wyAFGDAQS/1b0e1baacb80125e1f92e66dbdf1e32a/Alex_Duffy1.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/30DNW3QcEb1BosJhJqPAfA/56e4708045e63d40d5fe31c122da2bfb/August_Kamp_2.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2ukMfLwQHGEnwMbS43M3Hf/6f5fa57419fdc16ca603e41c1ac290ff/August_Kamp_3.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2KZaGKW5emVRwnYBMcMYCP/560cd7d513aed92b4a943b66b6b5e836/August_Kamp_4.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2PVNlktDwuJJgAlrviWfF1/bf374f33e21c41e770068f4f66a22394/August_Kamp_5.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/39oS3hSQqMSqHHNAS0q3DB/0624bcc17a3e7a3fd318a1eb5c63146e/August_Kamp.png?w=3840&q=90&fm=webp)

- ![credit creator: [August Kamp](images/introducing-4o-image-generation-openai/img_038.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5WdHD3ToXx1mj13bjDhdQh/46c283533309492585f3538a5ed3a2fd/August_Kamp_1_.png?w=3840&q=90&fm=webp)

- ![credit creator: Cassandra Ansara](images/introducing-4o-image-generation-openai/img_044.png)

- ![credit creator: [Isa](images/introducing-4o-image-generation-openai/img_045.jpg)](https://images.ctfassets.net/kftzwdyauwt9/37BlQeBhtmTAazdT7LyRIU/7e6472d3ba12c22748cf14a670c0a725/Copy_of_Isa.png?w=3840&q=90&fm=webp)

- ![credit creator: [Isa](images/introducing-4o-image-generation-openai/img_045.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2pRf2V2Zmd1YF7GfBtfRwG/92ac8188795fcdd4be9152a27a971289/Copy_of_Isa2.png?w=3840&q=90&fm=webp)

- ![credit creator: Les Morgan](images/introducing-4o-image-generation-openai/img_047.png)

- ![credit creator: Les Morgan](images/introducing-4o-image-generation-openai/img_048.png)

- ![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2D1UY4SXAHAxN0uCGT4KCd/43da3a5152c1a823fdf2bed6acea5cf8/Derya_Unutmaz1.png?w=3840&q=90&fm=webp)

- ![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1jRz4YFkVwGIVQC6yz5DJV/af2ed5507df32860b8b82a4a326c437e/Derya2.jpg?w=3840&q=90&fm=webp)

- ![credit creator: [Derya Unatmaz](images/introducing-4o-image-generation-openai/img_049.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1hakInZjBH5SENKVLD68Gl/0140eb82eae9e5cd2f1fbc7ef8f5c46c/Derya3.png?w=3840&q=90&fm=webp)

- ![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/3viXLb1u1ZsUXju6gc0Izh/51b37635165df801077399b26e6c0ff5/Elene_6.png?w=3840&q=90&fm=webp)

- ![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/6EoS1QOv0KOi4aESduy0cU/12705b1ca86abce06bf7366f98e9a8c7/Elene_Chekurishvili.png?w=3840&q=90&fm=webp)

- ![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5sKaN7iVvtLlzGJQtFmfMg/4ef6d51d2e54d4effd3019401401deb1/Elene3.jpeg?w=3840&q=90&fm=webp)

- ![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1iA7pHLA84KDCRIuoG5pTk/ae8e52600bfbd53a10a749dcd78b2382/Elene4.jpeg?w=3840&q=90&fm=webp)

- ![credit creator: [Elene Chekurishvili](images/introducing-4o-image-generation-openai/img_052.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5MPmWWYE3fDk6M5QSpA0X8/ac729246785fc8d052be4427085bbcda/Elene5.png?w=3840&q=90&fm=webp)

- ![credit creator: [Eugenio Marongiu](images/introducing-4o-image-generation-openai/img_057.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2CrXaGuZ3fcCIyKNcDaiRr/26fb7c949919a2de82f7b8340ad4e708/Eugenio_Marongiu.png?w=3840&q=90&fm=webp)

- ![credit creator: [Eugenio Marongiu](images/introducing-4o-image-generation-openai/img_057.jpg)](https://images.ctfassets.net/kftzwdyauwt9/6JJh92fHC6diXnnj0rz6DP/53a43e30200729a648cfda1faa6328a5/Eugenio2.png?w=3840&q=90&fm=webp)

- ![credit creator: Jesse Kramme](images/introducing-4o-image-generation-openai/img_059.png)

- ![credit creator: Jesse Kramme](images/introducing-4o-image-generation-openai/img_060.png)

- ![credit creator: Matthew Dear](images/introducing-4o-image-generation-openai/img_061.png)

- ![credit creator: [Minh Do](images/introducing-4o-image-generation-openai/img_062.jpg)](https://images.ctfassets.net/kftzwdyauwt9/tZr3EpmNfrkZBQAIYMffM/d85415f7a01a49718adf2509bb9ad8f1/Minh_Do1.png?w=3840&q=90&fm=webp)

- ![credit creator: [Niceaunties](images/introducing-4o-image-generation-openai/img_063.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1TQS4fCbgIOjdnML4u6i5o/bc81b9ff76e503e32b69dbf447a967e6/niceaunties.png?w=3840&q=90&fm=webp)

- ![credit creator: Eskcanta](images/introducing-4o-image-generation-openai/img_064.png)

- ![credit creator: Eskcanta](images/introducing-4o-image-generation-openai/img_065.png)

- ![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/1TYYxCnSFWzwoEOHJ7OlfC/767ce4ec94b972138598cce0be1e8d79/Roope_2.png?w=3840&q=90&fm=webp)

- ![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/2Gr22uAGGIQjmDBQt2ccKx/620417fa3b9667f7e95a1fd98c692203/Roope_3.png?w=3840&q=90&fm=webp)

- ![credit creator: [Roope Rainisto](images/introducing-4o-image-generation-openai/img_066.jpg)](https://images.ctfassets.net/kftzwdyauwt9/5neXFSFNWbbdhruFManjbU/3a084e08790a90af52cb7005372539b9/Roope_Rainisto1.png?w=3840&q=90&fm=webp)

- ![credit creator: Shane Copenhagen](images/introducing-4o-image-generation-openai/img_069.png)

- ![credit creator: Will Maberry](images/introducing-4o-image-generation-openai/img_070.jpg)

- ![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_071.png)

- ![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_072.png)

- ![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_073.png)

- ![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_074.png)

- ![credit creator: Manuel Sainsily](images/introducing-4o-image-generation-openai/img_075.png)


## Livestream replay

![](images/introducing-4o-image-generation-openai/img_115.png)

Play video