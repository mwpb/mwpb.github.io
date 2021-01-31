---
layout: blog
title:  "Java initialisation shortcuts"
tags: coding java
---

In Java some of the standard constructors can be a little unwieldy when trying to inline some kind of condition.
On this page I am collecting initialisation shortcuts that I have found useful.
The purpose is to make the code more readable and performance has not been considered.

At the moment they all require:

```java
import java.util.*;
```

## Initialising an array of characters

Rather than
```java
new char[] {'A', 'C', 'G', 'T'};
```
instead:
```java
"ACGT".toCharArray();
```

## Initialising a set

If we want to check if a value is in a collection then use:
```java
Set.of("a", "b");
```
Note that this produces an immutable set.
This is fine if for example we use it in an `if` statement:
```java
if (Set.of("a", "b").contains(c)) {
	// run if c is either "a" or "b"
}
```