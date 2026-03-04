---
title: "Custom instructions for ChatGPT | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/custom-instructions-for-chatgpt"
date: "2023-07-20"
scraped_at: "2026-03-02T10:23:18.858890551+00:00"
language: "en-US"
translated: false
description: "We’re rolling out custom instructions to give you more control over how ChatGPT responds. Set your preferences, and ChatGPT will keep them in mind for all future conversations."
tags: ["Product"]
---
{% raw %}

July 20, 2023


# Custom instructions for ChatGPT

We’re rolling out custom instructions to give you more control over how ChatGPT responds. Set your preferences, and ChatGPT will keep them in mind for all future conversations.

![Custom Instructions For Chatgpt](images/custom-instructions-for-chatgpt-openai/img_001.png)



We’re introducing custom instructions so that you can tailor ChatGPT to better meet your needs. This feature will be available in beta starting with the Plus plan today, expanding to all users in the coming weeks. Custom instructions allow you to add preferences or requirements that you’d like ChatGPT to consider when generating its responses.

We’ve heard your feedback about the friction of starting each ChatGPT conversation afresh. Through our conversations with [users across 22 countries⁠](https://openai.com/index/insights-from-global-conversations/), we’ve deepened our understanding of the essential role steerability plays in enabling our models to effectively reflect the diverse contexts and unique needs of each person.

ChatGPT will consider your custom instructions for every conversation going forward. The model will consider the instructions every time it responds, so you won’t have to repeat your preferences or information in every conversation.

For example, a teacher crafting a lesson plan no longer has to repeat that they're teaching 3rd grade science. A developer preferring efficient code in a language that’s not Python – they can say it once, and it's understood. Grocery shopping for a big family becomes easier, with the model accounting for 6 servings in the grocery list.

- [Lesson plan](https://openai.com/index/custom-instructions-for-chatgpt/#)
- [Code generation](https://openai.com/index/custom-instructions-for-chatgpt/#)
- [Grocery list](https://openai.com/index/custom-instructions-for-chatgpt/#)

Custom instructions

Scroll to see change

Scroll down to see output change

What would you like ChatGPT to know about you to provide better responses?

I work on science education programs for third-grade students.

How would you like ChatGPT to respond?

When discussing potential solutions for work-related items, present the information in a table format, outlining the pros and cons of each option—allowing for easier comparison and decision-making.

What would be three important things to teach about the moon?

OAI

1. Formation and Structure: One of the most important aspects to teach about the Moon is its formation and structure. It's believed that the Moon was formed about 4.5 billion years ago, shortly after the formation of the Solar System. A popular theory is the Giant Impact Hypothesis, which suggests that a Mars-sized body, referred to as Theia, collided with Earth, and the debris from this collision eventually coalesced to form the Moon. In terms of structure, the Moon has a thin crust, a mantle, and a small, partly molten core, similar to Earth but much less geologically active.
2. Moon Phases and Tides: Understanding the phases of the Moon is a crucial aspect of astronomy. The Moon orbits Earth about once every 27.3 days, and as it does, the angle at which sunlight hits it changes, causing the visible portion from Earth to cycle through phases: new moon, waxing crescent, first quarter, waxing gibbous, full moon, waning gibbous, last quarter, and waning crescent. Additionally, the Moon's gravitational pull affects Earth's oceans, causing tides. The Moon, in conjunction with the Sun, causes high and low tides, an effect that has significant implications for marine life and human activities.
3. The Moon and Space Exploration: The Moon plays a crucial role in human space exploration. The Apollo missions of the 1960s and 1970s marked a significant milestone in space exploration, with Apollo 11 landing the first two people on the Moon in 1969. These missions brought back lunar rocks that have greatly contributed to our understanding of the Moon and the Solar System. The Moon continues to be a focal point for future space exploration missions, as establishing a human base there could serve as a stepping stone for further exploration into the Solar System, including Mars.

What would be three important things to teach about the moon?

OAI

Teaching third-grade students about the moon involves several core concepts. Here are three key topics to consider:

1. Phases of the Moon
2. The Moon's Relationship with the Earth
3. Physical Features of the Moon

| Topic | Pros | Cons |
| --- | --- | --- |
| Phases of the Moon | Helps students understand cyclical patterns and time. It's also quite observable, offering an immediate connection to their own experiences. | It may be a slightly complex concept for some students to grasp initially, particularly the reasons behind the moon's different phases. |
| The Moon's Relationship with the Earth | This topic is vital for explaining concepts like gravity, tides, and how the moon orbits the earth. It can also lead to further discussions about the solar system. | Understanding the moon's impact on Earth requires some basic understanding of physical science, which may be challenging for some third graders. |
| Physical Features of the Moon | Students usually find this interesting, particularly topics like craters and the absence of atmosphere. This can lead to discussions about space exploration. | Without proper visual aids (like high-quality images or models), this topic can be somewhat abstract for third-grade students. |

Ultimately, your choice of what to emphasize will depend on your students' existing knowledge, the curriculum you are following, and the resources you have available.

Custom instructions

Scroll to see change

Scroll down to see output change

What would you like ChatGPT to know about you to provide better responses?

I’m a software developer and solely use golang.

How would you like ChatGPT to respond?

When I ask you for code, please just give me the code without any explanation on how it works. Bias towards the most efficient solution.

Write me code for getting the nth number in the Fibonacci sequence

OAI

Sure, here is a simple Python function to compute the nth number in the Fibonacci sequence using a recursive method:

```python
                  def fibonacci_recursive(n):
    if n ≤ 0:
        print("Input should be a positive integer")
        return None
    elif n == 1:
        return 0
    elif n == 2:
        return 1
    else:
        return fibonacci_recursive(n-1) + fibonacci_recursive(n-2)

# Test
print(fibonacci_recursive(10))

```

This recursive solution, however, is not very efficient (it has an exponential time complexity due to repeated calculations), especially for larger values of `n`.

Here's a more efficient version using dynamic programming (this has linear time complexity):

```maxima
                  def fibonacci_dp(n):
    if n ≤ 0:
        print("Input should be a positive integer")
        return None
    elif n == 1:
        return 0
    elif n == 2:
        return 1

    fib = [0, 1]
    while len(fib) < n:
        fib.append(fib[-1] + fib[-2])

    return fib[-1]

print(fibonacci_dp(10))

```

In these functions, `n=1` corresponds to the first number in the Fibonacci sequence (which is 0), `n=2` corresponds to the second number (which is 1), and so on.

Write me code for getting the nth number in the Fibonacci sequence

OAI

```go
package main

import "fmt"

func Fibonacci(n int) int {
    if n ≤ 1 {
        return n
    }
    a, b := 0, 1
    for i := 2; i ≤ n; i++ {
        a, b = b, a+b
    }
    return b
}

func main() {
    fmt.Println(Fibonacci(10)) // replace 10 with the nth number
}
```

Custom instructions

Scroll to see change

Scroll down to see output change

What would you like ChatGPT to know about you to provide better responses?

I live in North Carolina with my four children and wife.

How would you like ChatGPT to respond?

When planning meals, consider that I need to cater to a family of six. Ensure that recipe recommendations are suitable for larger groups and offer meal options that can be easily scaled up.

What should I get at the store for pizza night?

OAI

Pizza night can be a great opportunity to get creative and involve everyone in the preparation process. Here's a general shopping list that should cover a variety of tastes:

1. Pizza Dough: You can buy pre-made pizza dough at most grocery stores, or you can make your own from scratch. You will need flour, yeast, sugar, salt, and olive oil if you decide to make your own.
2. Pizza Sauce: You can either buy pre-made pizza sauce, or make your own with tomatoes (canned crushed tomatoes or fresh), garlic, onion, olive oil, and a mixture of herbs like oregano, basil, and thyme.
3. Cheese: Mozzarella is a must, but also consider getting other types like fresh buffalo mozzarella, gorgonzola, ricotta, or parmesan.
4. Toppings:
   - Vegetables: bell peppers, mushrooms, onions, tomatoes, spinach, olives, artichoke hearts, pineapple, etc.
   - Meats: pepperoni, sausage, ham, bacon, grilled chicken, etc.
   - Additional toppings: fresh basil, anchovies, capers, prosciutto, arugula after baking, etc.
5. Extras:
   - Olive oil: For brushing on the crust before baking.
   - Spices: Crushed red pepper, oregano, garlic powder, etc.
   - Cornmeal or flour: For dusting the pizza peel or baking sheet to prevent sticking.
6. Drinks: Depending on the crowd, you might want to pick up some sodas, craft beers, or wine. A nice Chianti or Sangiovese pairs well with pizza.
7. Dessert: To finish off the night, consider getting some ice cream or ingredients for a simple dessert like chocolate chip cookies or brownies.

What should I get at the store for pizza night?

OAI

Great! Planning for pizza night is always fun. Here's a shopping list for a pizza night for six people, assuming you'll be making two large pizzas:

Pizza Dough

1. Bread flour - 1kg (Enough for two large pizza doughs)
2. Dry yeast - 2 packets (14 grams) Sugar - small pack (you'll need 4 teaspoons)
3. Olive oil - 1 small bottle (you'll need 4 tablespoons)
4. Salt - small pack (you'll need 2 teaspoons)

Pizza Sauce

1. Canned tomatoes (diced or whole) - 2 cans (28 oz each)
2. Garlic - 1 bulb (you'll need 4 cloves)
3. Dried oregano - 1 small pack
4. Dried basil - 1 small pack
5. Salt - (already listed above)
6. Olive oil - (already listed above)

Toppings

1. Mozzarella cheese - 800 grams (28 oz)
2. Your family's favorite meats like pepperoni, sausage, or chicken - about 500 grams (18 oz)
3. Your family's favorite veggies like bell peppers, onions, mushrooms, olives - 4 to 6 total depending on size
4. Fresh basil - 1 bunch

Optional

1. Parmesan cheese - 1 small block for grating
2. Chili flakes - 1 small pack
3. Fresh ground black pepper - 1 small pack

## Plugins

Adding instructions can also help improve your experience with [plugins⁠(opens in a new window)](https://help.openai.com/en/articles/7183286-how-do-i-access-plugins#h_3f79a921af) by sharing relevant information with the plugins that you use. For example, if you specify the city you live in within your instructions and use a plugin that helps you make restaurant reservations, the model might include your city when it calls the plugin.

## Beta

Especially during the beta period, ChatGPT won’t always interpret custom instructions perfectly—at times it might overlook instructions, or apply them when not intended.

## Safety

We’ve adapted our safety measures to account for the new ways that users can instruct the model.  For example, our Moderation API is designed to help ensure instructions won't be saved if they violate our [Usage Policies⁠](https://openai.com/policies/usage-policies/). The model can also refuse or ignore instructions that lead to responses that violate our usage policies.

## Privacy

We may use your custom instructions to improve model performance for our users, but you can disable this via your [data controls⁠(opens in a new window)](https://help.openai.com/en/articles/7730893-data-controls-faq). [As with ChatGPT conversations⁠(opens in a new window)](https://help.openai.com/en/articles/5722486-how-your-data-is-used-to-improve-model-performance), we take steps to remove personal identifiers found in custom instructions before they are used to improve model performance. Learn more about how we use conversations to improve model performance and your choices in our [Help Center⁠(opens in a new window)](https://help.openai.com/en/articles/5722486-how-your-data-is-used-to-improve-model-performance).

## Try it now

Plus users can start using custom instructions today by opting into the beta for custom instructions:

- On web, click on your name → Settings → Beta features → opt into Custom instructions. Custom instructions will appear in the menu when you click on your name going forward.
- On iOS, go to Settings → New Features → turn on Custom instructions. Custom instructions will appear in settings.

This feature is not yet available in the UK and EU.

- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [2023](https://openai.com/news/?tags=2023)
{% endraw %}
