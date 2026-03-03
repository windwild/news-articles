---
title: "New GPT-3 capabilities: Edit & insert | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-3-edit-insert"
date: "2022-03-15"
scraped_at: "2026-03-02T10:25:46.834121512+00:00"
language: "en-US"
translated: false
description: "We’ve released new versions of GPT-3 and Codex which can edit or insert content into existing text, rather than just completing existing text."
tags: ["Product"]
---

March 15, 2022


# New GPT‑3 capabilities: Edit & insert

We’ve released new versions of GPT‑3 and Codex which can edit or insert content into existing text, rather than just completing existing text.

![GPT-3 Edit and Insert](images/new-gpt-3-capabilities-edit-insert-openai/img_001.png)



_**Update on May 16, 2025:**_ _We launched Codex, a cloud-based software engineering agent that can work on many tasks in parallel._ [_Learn more_ ⁠](https://openai.com/index/introducing-codex/) _._

* * *

We’ve released new versions of [GPT‑3⁠(opens in a new window)](https://beta.openai.com/docs/engines/gpt-3) and [Codex⁠(opens in a new window)](https://beta.openai.com/docs/engines/codex-series-private-beta) which can edit or insert content into existing text, rather than just completing existing text. These new capabilities make it practical to use the [OpenAI API⁠(opens in a new window)](https://beta.openai.com/) to revise existing content, such as rewriting a paragraph of text or refactoring code. This unlocks new use cases and improves existing ones; for example, insertion is already being piloted in [GitHub Copilot⁠(opens in a new window)](https://copilot.github.com/) with promising early results.

- [Read edit docs(opens in a new window)](https://beta.openai.com/docs/api-reference/edits)
- [Read insert docs(opens in a new window)](https://beta.openai.com/docs/guides/comp)

```
def___

fib(10)
```

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the runtime

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the runtime complexity

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the runtime complexity of the

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the runtime complexity of the function

```
def fib(n):
    if n <= 1:
        return 1
    return fib(n-1) + fib(n-2)

fib(10)
```

Improve the runtime complexity of the function

```
def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        f = 1
    else:
        f = fib(n-1, memo) + fib(n-2, memo)
    memo[n] = f
    return f
```

```
def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        f = 1
    else:
        f = fib(n-1, memo) + fib(n-2, memo)
    memo[n] = f
    return f
```

Translate

```
def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        f = 1
    else:
        f = fib(n-1, memo) + fib(n-2, memo)
    memo[n] = f
    return f
```

Translate to

```
def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        f = 1
    else:
        f = fib(n-1, memo) + fib(n-2, memo)
    memo[n] = f
    return f
```

Translate to JavaScript

```
def fib(n, memo={}):
    if n in memo:
        return memo[n]
    if n <= 1:
        f = 1
    else:
        f = fib(n-1, memo) + fib(n-2, memo)
    memo[n] = f
    return f
```

Translate to JavaScript

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this as

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this as a

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this as a one

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this as a one-liner

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        if (n in memo) return memo[n];
        var f;
        if (n <= 1) f = 1;
        else
            f = fib(n-1, memo) + fib(n-2, memo);
        memo[n] = f;
        return f;
    })(n, memo);
}
```

Write this as a one-liner

```
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

```

function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

```
/
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

```
/**
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

```
/**___
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

```
/**​
 * Recursive Fibonacci function with memoization.
 * @param {number} n
 * @returns {number}
 */
function fibonacci(n) {
    var memo = {};
    return (function fib(n, memo) {
        return n in memo ? memo[n] : (memo[n] = n <= 1 ? 1 : fib(n-1, memo) + fib(n-2, memo));
    })(n, memo);
}
```

GPT‑3 and Codex have traditionally added text to the end of existing content, based on the text that came before. Whether working with text or code, writing is more than just appending—it’s an iterative process where existing text is revised. GPT‑3 and Codex can now edit text, changing what’s currently there or adding text to the middle of content.

## Inserting into the middle of text

The new [insert⁠(opens in a new window)](https://beta.openai.com/docs/guides/completion/inserting-text) [capability⁠(opens in a new window)](https://beta.openai.com/docs/guides/code/inserting-code) adds contextually relevant text in the middle of existing content. Providing future context to the model can improve the quality of completions for applications such as writing long-form text, transitioning between paragraphs, following an outline, or guiding the model toward an ending.

Section 1. High school graduation

Today's the big day!\\_\\_\\_

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section 2.

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section 2. Moving

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section 2. Moving to

Section 1. High school graduation

Today's the big day! Congratulations to all our high school graduates!

We hope you enjoy your graduation ceremonies and wish you the best of luck in your future endeavors.

Section 2. Moving to San Francisco

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited. I'm going to move to San Francisco and start a new life. I can't wait to get there.

Section 2. Moving to San Francisco

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited. I'm going to move to San Francisco and start a new life. I can't wait to get there.

Section 2. Moving to

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited. I'm going to move to San Francisco and start a new life. I can't wait to get there.

Section 2. Moving to Istanbul

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited to be moving on to the next chapter of my life. I'm going to Istanbul!

Section 2. Moving to Istanbul

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited to be moving on to the next chapter of my life. I'm going to Istanbul!

Section 2. Moving to

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited to be moving on to the next chapter of my life. I'm going to Istanbul!

Section 2. Moving to the

Section 1. High school graduation

Today's the big day! I'm graduating from high school. I'm so excited to be moving on to the next chapter of my life. I'm going to Istanbul!

Section 2. Moving to the farm

Section 1. High school graduation

Today's the big day! My high school graduation! I'm so excited! I can't wait to leave the city and move to the farm. I want to live a simple, quiet life. I want to get up in the morning, milk the cows, feed the horses, then sit and watch the sunrise. I want to spend the rest of my days traveling the world, reading and writing. I'm so tired of this city life.

Section 2. Moving to the farm

In the example above, the desire is to fill-in text between two section headers of an outline. Without the context of future sections, the model generates a completion that isn’t relevant to the second section. When the context of future sections are accounted for, the model generates a completion that ties the two sections together.

```
def get_files(path: str, size: int):
    def___
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
def get_files(path: str, size: int):
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```

def get_files(path: str, size: int):
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
___
def get_files(path: str, size: int):
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
import os
def get_files(path: str, size: int):
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
import os
def get_files(path: str, size: int):
    """
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
import os
def get_files(path: str, size: int):
    """___
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
import os
def get_files(path: str, size: int):
    """___"""
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

```
import os
def get_files(path: str, size: int):
    """Yields files in the path tree of min size"""
    def prune(dirp, files):
        for file in files:
            file = os.path.join(dirp, file)
            if os.path.getsize(file) > size:
                yield file
    for (dirp, _, files) in os.walk(path):
        yield from prune(dirp, files)
```

Insert is particularly useful for writing code. In fact, Codex was our original motivation for developing this capability, since in software development we typically add code to the middle of an existing file where code is present before and after the completion. In the example above, the model successfully completes the missing function `prune`, while connecting to code already written. We also add a docstring and missing imports, which is not possible without knowing the code that comes after. In GitHub Copilot, Insert is currently being piloted with early promising results.

The insert capability is available in the API today in beta, as part of the [completions endpoint⁠(opens in a new window)](https://beta.openai.com/docs/guides/completion/introduction) and via a new interface in [Playground⁠(opens in a new window)](https://beta.openai.com/playground). The capability can be used with the latest versions of GPT‑3 and Codex, `text-davinci-002` and `code-davinci-002`. [Pricing⁠](https://openai.com/api/pricing/) is the same as previous versions of Davinci.

## Editing existing text

A meaningful part of writing text and code is spent editing existing content. We’ve released a new endpoint in beta called [edits⁠(opens in a new window)](https://beta.openai.com/docs/api-reference/edits) that changes existing text via an instruction, instead of completing it.

Add

Add a

Add a short poem

Add a short poem about

Add a short poem about GPT-3

Add a short poem about GPT-3

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make this

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make this in the

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make this in the voice

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make this in the voice of GPT-3

GPT-3 is a very nice AI

That's pretty good at writing replies

When it's asked a question

It gives its suggestion

This is a poem it made that rhymes

Make this in the voice of GPT-3

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this like a

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this like a letter

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this like a letter and sign

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this like a letter and sign from GPT-3

I am a very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem it made that rhymes

Format this like a letter and sign from GPT-3

Dear Human,

I am very nice AI

I am pretty good at writing replies

When I am asked a question

I give my suggestion

This is a poem I made that rhymes

Kind regards,

GPT-3

Editing works by specifying existing text as a prompt and an instruction on how to modify it. The edits endpoint can be used to change the tone or structure of text, or make targeted changes like fixing spelling. We’ve also observed edits to work well on empty prompts, thus enabling text generation similar to the [completions endpoint⁠(opens in a new window)](https://beta.openai.com/docs/guides/completion/introduction). In the example above, we use edits to (1) add a poem, (2) change the poem to be in first-person, (3) transform the poem into a letter, with the appropriate salutation and signature.

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file with rank

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file with rank, city

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file with rank, city, state

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file with rank, city, state, and hours

```
The three US cities with the worst traffic are:

1. Boston, MA (164 hours)
2. Washington, DC (155 hours)
3. Chicago, IL (138 hours)
```

Convert the list to JSONL file with rank, city, state, and hours

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

Remove

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

Remove rank

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

Remove rank and write out

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

Remove rank and write out full state names

```
[\
  {"rank": 1, "city": "Boston", "state": "MA", "hours": 164},\
  {"rank": 2, "city": "Washington DC", "state": "DC", "hours": 155},\
  {"rank": 3, "city": "Chicago", "state": "IL", "hours": 138}\
]
```

Remove rank and write out full state names

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn into YAML

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn into YAML and return

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn into YAML and return from a function

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn into YAML and return from a function called get\_yaml

```
[\
  {"city": "Boston", "state": "Massachusetts", "hours": 164},\
  {"city": "Washington DC", "state": "District of Columbia", "hours": 155},\
  {"city": "Chicago", "state": "Illinois", "hours": 138}\
]
```

Turn into YAML and return from a function called get\_yaml

```
def get_yaml():
    return """
    - city: Boston
      state: Massachusetts
      hours: 164
    - city: Washington DC
      state: District of Columbia
      hours: 155
    - city: Chicago
      state: Illinois
      hours: 138
    """
```

The edits endpoint is particularly useful for writing code. It works well for tasks like refactoring, adding documentation, translating between programming languages, and changing coding style. The example above starts with JSON input containing cities ranked by population. With our first edit, Codex removes the rank field from the JSON, and changes the state abbreviations into full names. The second edit converts the JSON file into YAML returned from a function.

Editing is available as a [specialized endpoint in the API⁠(opens in a new window)](https://beta.openai.com/docs/api-reference/edits) and through a new interface in [Playground⁠(opens in a new window)](https://beta.openai.com/playground). It is supported by models `text-davinci-edit-001` and `code-davinci-edit-001`. The edits endpoint is currently [free to use⁠](https://openai.com/api/pricing/) and publicly available as a beta.

- [Read edit docs(opens in a new window)](https://beta.openai.com/docs/api-reference/edits)
- [Read insert docs(opens in a new window)](https://beta.openai.com/docs/guides/comp)

- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [2022](https://openai.com/news/?tags=2022)