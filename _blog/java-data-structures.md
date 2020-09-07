---
layout: blog
title:  "Java data structures"
tags: coding java
---

## Default values

* byte, short, int: `0`
* long: `0L`
* float: `0.0f`
* double: `0.0d`
* char: `'\u0000'` - the null character not `null`
* object (inc. String): `null`
* boolean: `false`

## ArrayList

For most uses of lists or arrays.

## ArrayDeque

For most requirements involving a double ended queue.

## Arrays

### Initialisation and accessing elements

Stores a fixed number of values of a single type in a continuous memory location.
Default initialisation using default values above.
Elements are accessed using the standard square brackets notation.

```java
int[] testArray = new int[4];
System.out.println(Arrays.toString(testArray));
// [0, 0, 0, 0]
testArray[0] = 0;
testArray[1] = 1;
testArray[2] = 1;
testArray[3] = 2;
System.out.println(Arrays.toString(testArray));
// [0, 1, 1, 2]
int[] secondTest = new int[5] {1, 1, 2, 3, 5};
System.out.println(testArray[3]);
// 2
System.out.println(secondTest[1]);
// 1
```

### Standard library functions for arrays

The `System` class provides a copy method that copies a specified number `length` of elements from a starting position `srcPos` of a source array `src` to a destination array `dest` beginning at the destination position `destPos`.

```java
System.arraycopy(   Object src, int srcPos,
                    Object dest, int destPos, int length);
```

The `java.util.Arrays` class contains other useful methods for instance:-
* `binarySearch`: binary search on a sorted array. (No guarantee which value is found.)
* `equals`: compares two arrays to see if they are equal.
* `sort` and `parallelSort` for sorting
* `fill` assigns multiple contiguous values at once

## Stacks

Use [java.util.Deque](https://docs.oracle.com/javase/7/docs/api/java/util/Deque.html) implemented by [java.util.ArrayDeque](https://docs.oracle.com/javase/7/docs/api/java/util/ArrayDeque.html).

Since a deque is a 'double ended queue' it can be used as a queue or a stack.

## Queues

Use [java.util.Deque](https://docs.oracle.com/javase/7/docs/api/java/util/Deque.html) implemented by [java.util.ArrayDeque](https://docs.oracle.com/javase/7/docs/api/java/util/ArrayDeque.html).

Since a deque is a 'double ended queue' it can be used as a queue or a stack.

## Hash tables

Use `java.util.Map` interface implemented by `HashMap` class.

* Provides `O(1)` lookup time for objects.
* It uniformly distributes the objects across an array.
* Then a 'hash function' converts lookup keys to the integers that specify the index where the object is in the array.

The hash function should be:-

1. Easy to compute.
2. Uniformly distribution in length of array.
3. Minimise collisions where the different keys give the same index.

In the case of collisions an `O(k)` lookup is performed where `k` is the number of entries with the same index.

```java
import java.util.Map;
import java.util.HashMap;
Map<String, Integer> cache = new HashMap<String, Integer>();
cache.put("first", 1);
cache.put("second", 2);
System.out.println(cache.get("first"));
// 1
cache.remove("second");
System.out.println(cache.get("second"));
// null
System.out.println(cache.getOrDefault("second", 0));
// 0
```

### Sets

Use `java.util.HashSet` which implements the `java.util.Set` interface.

* `.add(e)` adds the element `e`
* `.remove(e)` removes the element `e`
* `.contains(e)` checks if an element is in the set
* `.isEmpty()` and `.size()` do what their name suggests

## Linked lists

Use `java.util.LinkedList`.

This implements a *doubly linked* list which keeps pointers to both the first and the last elements.
So accessing the first and last elements as well as adding to the start and end are all `O(1)` operations.
If trying to do something with an inner node then it will go from either the start or end depending on what is closer.

Again there are two sets of operations.
The first throws exceptions:
```java
import java.util.LinkedList;
LinkedList<Integer> ll = new LinkedList<Integer>();
System.out.println(ll.size());
// 0
ll.addFirst(0);
ll.addFirst(-1);
ll.addLast(2);
System.out.println(ll.getFirst());
// -1
System.out.println(ll.getLast());
// 2
ll.removeFirst();
System.out.println(ll.getFirst());
// 0
ll.removeLast();
System.out.println(ll.getLast());
// 0
System.out.println(ll.size());
// 1
```
and the second returns `null` instead of an exception:
```java
import java.util.LinkedList;
LinkedList<Integer> ll = new LinkedList<Integer>();
System.out.println(ll.size());
// 0
ll.offerFirst(0);
ll.offerFirst(-1);
ll.offerLast(2);
System.out.println(ll.peekFirst());
// -1
System.out.println(ll.peekLast());
// 2
ll.pollFirst();
System.out.println(ll.peekFirst());
// 0
ll.pollLast();
System.out.println(ll.peekLast());
// 0
System.out.println(ll.size());
	// 1
```

## Trees

Use `java.swing.tree.DefaultMutableTreeNode` that implements the `java.swing.tree.TreeNode` interface.
This class and interface might not be available on all platforms.
(But seems to be present on a default Java install on MacOS.)

```java
import javax.swing.tree.TreeNode;
import javax.swing.tree.DefaultMutableTreeNode;
import java.util.*;
DefaultMutableTreeNode root = new DefaultMutableTreeNode("Root");
DefaultMutableTreeNode mercury = new DefaultMutableTreeNode("Mercury");
root.add(mercury);
DefaultMutableTreeNode venus = new DefaultMutableTreeNode("Venus");
root.add(venus);
DefaultMutableTreeNode mars = new DefaultMutableTreeNode("Mars");
root.add(mars);
Enumeration<TreeNode> children = root.children();
while (children.hasMoreElements()) {
	System.out.println(children.nextElement());
}
System.out.println("---");
Enumeration<TreeNode> postOrder = root.depthFirstEnumeration();
while (postOrder.hasMoreElements()) {
	System.out.println(postOrder.nextElement());
}
```

The implementation is that of an `n`-ary tree where the children are stored as an array.
However this array is protected an we instead get and `Enumeration` when accessing `node.children()`.
The class `DefaultMutableTreeNode` has quite a few 'extra' methods.
The most obviously useful one is an implementation of the postorder depth first search.

## Min heap

```PriorityQueue<Integer> minHeap = new PriorityQueue<Integer>();```