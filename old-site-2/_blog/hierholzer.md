---
layout: blog
title:  "Hierholzer’s algorithm for Eulerian circuits"
tags: coding java
---

This entry is inspired by the `Dominoes` exercise on [exercism](https://exercism.io).
In the `Dominoes` exercise we are given a list of dominoes (simply pairs of integers) and need to return a chain that starts and ends at the same number.
By a chain of dominoes we mean a sequence such as:
```
[1, 3] [3, 2] [2, 9] [9, 1]
```
so that the second entry of any domino is the first entry of the next domino.
(We are allowed to rotate the dominoes so that e.g. `[3, 2]` could be used as `[2, 3]`.)
If it is not possible we must return an exception.

We choose to model this problem using a graph.
Each of the numbers occurring on the dominoes becomes a vertex.
Each of the dominoes `[i, j]` describes an edge from `i` to `j` and an edge from `j` to `i`.
Then the problem has been transformed to the problem of finding a Eulerian cycle in this graph.
Once we have used a domino `[i, j]` we remove precisely one edge from `i` to `j` and precisely one edge from `j` to `i`.
So first we convert the list of dominoes to an adjacency list within a `Dominoes` class:

```java
Map<Integer, List<Integer>> adjList;
void getAdjList(List<Domino> dominoes) {
  Map<Integer, List<Integer>> adjList = new HashMap<Integer, List<Integer>>();
  for (Domino domino: dominoes) {
    List<Integer> leftList = adjList.getOrDefault(domino.getLeft(), new LinkedList<Integer>());
    leftList.add(domino.getRight());
    adjList.put(domino.getLeft(), leftList);
    if (domino.getLeft() != domino.getRight()) {
      List<Integer> rightList = adjList.getOrDefault(domino.getRight(), new LinkedList<Integer>());
      rightList.add(domino.getLeft());
      adjList.put(domino.getRight(), rightList);
    }
  }
  this.adjList = adjList;
}
```

To check if it is possible to find a chain we use Euler's criteria:

```java
void existsEulerCycle() throws ChainNotFoundException {
  for (int v: this.adjList.keySet()) {
    List<Integer> noLoop = new LinkedList<Integer>(this.adjList.get(v));
    noLoop.removeAll(Collections.singleton(v));
    if (noLoop.size() % 2 != 0) {
      throw new ChainNotFoundException("No domino chain found.");
    }
  }
}
```

The idea behind Hierholzer's algorithm is to find any cycle in the graph and then iteratively enlarge the cycle to find a Eulerian cycle.
So first we need a method that finds any cycle starting at a vertex:

```java
Map<Integer, List<Integer>> adjList;
List<Integer> getCycle(int start) {
  List<Integer> cycle = new LinkedList<Integer>();
  cycle.add(start);
  int second = this.adjList.get(start).get(0);
  this.removeEdge(start, second);
  cycle.add(second);
  int current = second;
  while (current != start) {
    int next = this.adjList.get(current).get(0);
    this.removeEdge(current, next);
    cycle.add(next);
    current = next;
  }
  return cycle;
}
```
Note that we remove the edges from the adjacency list as we add them to the cycle.
Now we need to iterate through the cycle we have just created to locate vertices that still are associated to edges in the adjacency list.
For each of these we use `getCycle` to get a new cycle starting *and ending* at that vertex and add it to the original cycle:

```java
boolean addCycle() {
  int i = findFirstNonZeroValence();
  if (i < 0) {
    return false;
  }
  List<Integer> newCycle = this.getCycle(i);
  newCycle.remove(newCycle.size() - 1);
  int j = this.cycle.indexOf(new Integer(i));
  for (int n: newCycle) {
    this.cycle.add(j+1, n);
  }
  return true;
}
```
If we repeatedly call the `addCycle` method until there are no vertices left in the adjacency list then `this.cycle` will contain a Eulerian cycle.
The whole Java class is as follows and it passes all the tests on the `Exercism` platform.

```java
import java.util.*;

class Dominoes {

  Map<Integer, List<Integer>> adjList;
  List<Integer> cycle;

  void getAdjList(List<Domino> dominoes) {
    Map<Integer, List<Integer>> adjList = new HashMap<Integer, List<Integer>>();
    for (Domino domino: dominoes) {
      List<Integer> leftList = adjList.getOrDefault(domino.getLeft(), new LinkedList<Integer>());
      leftList.add(domino.getRight());
      adjList.put(domino.getLeft(), leftList);
      if (domino.getLeft() != domino.getRight()) {
        List<Integer> rightList = adjList.getOrDefault(domino.getRight(), new LinkedList<Integer>());
        rightList.add(domino.getLeft());
        adjList.put(domino.getRight(), rightList);
      }
    }
    this.adjList = adjList;
  }

  void removeEdge(int start, int end) {
    List<Integer> newStartList = adjList.get(start);
    newStartList.remove(new Integer(end));
    adjList.put(start, newStartList);
    if (start != end) {
      List<Integer> newEndList = adjList.get(end);
      newEndList.remove(new Integer(start));
      adjList.put(end, newEndList);
    }
  }

  List<Integer> getCycle(int start) {
    List<Integer> cycle = new LinkedList<Integer>();
    cycle.add(start);
    int second = this.adjList.get(start).get(0);
    this.removeEdge(start, second);
    cycle.add(second);
    int current = second;
    while (current != start) {
      int next = this.adjList.get(current).get(0);
      this.removeEdge(current, next);
      cycle.add(next);
      current = next;
    }
    return cycle;
  }

  List<Domino> cycleToDominoes(int start, List<Integer> cycle) {
    if (cycle.size() == 2) {
      return List.of(new Domino(start, start));
    }
    int current = start;
    List<Domino> dominoes = new LinkedList<Domino>();
    cycle.remove(0);
    for (int i: cycle) {
      dominoes.add(new Domino(current, i));
      current = i;
    }
    // dominoes.add(new Domino(current, start));
    return dominoes;
  }

  void existsEulerCycle() throws ChainNotFoundException {
    for (int v: this.adjList.keySet()) {
      List<Integer> noLoop = new LinkedList<Integer>(this.adjList.get(v));
      noLoop.removeAll(Collections.singleton(v));
      if (noLoop.size() % 2 != 0) {
        throw new ChainNotFoundException("No domino chain found.");
      }
    }
  }

  int findFirstNonZeroValence() {
    for (int i: this.cycle) {
      if (this.adjList.get(i).size() != 0) {
        return i;
      }
    }
    return -1;
  }

  boolean addCycle() {
    int i = findFirstNonZeroValence();
    if (i < 0) {
      return false;
    }
    List<Integer> newCycle = this.getCycle(i);
    newCycle.remove(newCycle.size() - 1);
    int j = this.cycle.indexOf(new Integer(i));
    for (int n: newCycle) {
      this.cycle.add(j+1, n);
    }
    return true;
  }

  List<Domino> formChain(List<Domino> dominoes) throws ChainNotFoundException {
    if (dominoes.size() == 0) {
      return List.of();
    }
    this.getAdjList(dominoes);
    this.existsEulerCycle();
    int start = dominoes.get(0).getLeft();
    this.cycle = this.getCycle(start);
    while (this.addCycle()) {}
    List<Domino> out = this.cycleToDominoes(start, this.cycle);
    if (out.size() != dominoes.size()) {
      throw new ChainNotFoundException("No domino chain found.");
    }
    return out;
  }
}
```