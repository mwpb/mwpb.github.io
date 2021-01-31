---
layout: blog
title:  "Java common tasks"
tags: coding java
---
## String split on line break

```java
String lines[] = input.split("\\R");
```

## Parsing and reading

The class `java.util.Scanner` provides a iterator-like methods to parse input.

For console input:

```java
Scanner scanner = new Scanner(System.in);
int i = scanner.nextInt();
```

For file input:
```java
Scanner scanner = new Scanner(new File("myNumbers"));
long nextLong = scanner.nextLong();
```

Note that the `.nextLine()` method reads and returns the rest of the current line.

## Formatting strings

Use `String.format()`.

### Fixed width strings

The number between the `%` and the `s` gives the fixed width.
If negative the the string will be left justified.

```java
String.format("%-15s", s);
```

### Adding leading zeros to integer

```java
String.format("%03d", n);
```