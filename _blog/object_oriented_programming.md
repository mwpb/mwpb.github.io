---
layout: blog
title:  "Object oriented programming"
tags: coding
---

## Four principles of object oriented programming

### 1. Encapsulation

A class keeps some things private and makes others public.
A third-party library can prevent consumers using certain methods.

### 2. Abstraction - the main one

Using encapsulation to hide implementation details.
This means that the implementation can be changed without affecting other code.
Reduces the amount of code changes in a refactor.

For instance using a class to manage access to a database table.

### 3. Inheritance

Reuse code between classes.
Usually a more specific class extends a more abstract class.
But methods can be overridden also.

### 4. Polymorphism

Cast a class to a more abstract class that it implements.

For instance might want a list of nodes for a table of contents but these nodes could be either folder nodes or content nodes.