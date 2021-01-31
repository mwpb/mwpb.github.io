---
layout: blog
title:  "Roads and libraries"
tags: coding python
---

(Inspired by the 'roads and libraries' challenge on Hackerrank.)

Both the breadth-first (bfs) and depth-first (dfs) graph traversal algorithms have  time complexity equal to `O(v+e)` where `v` is the number of vertices and `e` is the number of edges.
This is because in the worst case we must visit each vertex and consider each edge.
So unless the problem is particularly simple it is probably a good idea to use one of these traversals.
Both bfs and dfs work on adjacency lists.
If one has an edge list one can convert it to an adjacency list in `O(n+m)` time.
But if one has an adjacency matrix one has to use `O(n^2)` time to convert to an adjacency list.

If we are searching for a specific element then the choice between the two is dictated by the structure of the graph and where we might expect the solution to be given the problem at hand.
(If we are trying to find the shortest distance then BFS is the better as it can be slightly modified to deterministically calculate the shortest distance.)
In terms of time complexity the choice of BFS vs DFS shouldn't matter if we plan to traverse the whole graph.

DFS generally has the better space complexity as it only keeps track of a 'search path' as a stack whereas BFS has to keep track of a queue.
Every time one removes a vertex from this queue one adds all of the unvisited neighbours of that queue so the space usage can increase quite rapidly.

Side note: the standard pre-order, post-order and in-order tree traversals appear to be examples of DFSs.
It appears that one can use a BFS on a tree also.

This post is a reaction to my attempts at the 'roads and libraries' challenge on Hackerrank.
Initially I tried to use a cache to keep track of the connected components that a vertex belonged to.
However it quickly became apparent that my attempts to keep this cache updated correctly wasn't going to get better than `O(v+e)`.
Then I tried a BFS with *an inappropriate Python queue library*.
(I used `queue.Queue()` rather than `collections.deque`.)

{% highlight python %}
def bfs_wrong_queue(start, adj_list, visited): # O(??)
    q = queue.Queue()
    q.put(start)
    out = [start]
    visited.add(start)
    while q.qsize():
        node = q.get()
        for x in adj_list[node]:
            if x not in visited:
                q.put(x)
                visited.add(x)
                out.append(x)
    return out, visited
{% endhighlight %}

With this mistake a single Hackerrank test case gave me a: `Terminated due to timeout`.
(All the rest passed.)
Next using the usual Python list as a stack I implemented a DFS which passed all of the Hackerrank test cases.
{% highlight python %}
def dfs(start, adj_list, visited): # O(v+e)
    search_path = [start]
    visited.add(start)
    out = [start]
    while search_path:
        node = search_path[-1]
        if not adj_list[node]:
            search_path.pop()
        else:
            next_node = adj_list[node].pop()
            if next_node not in visited:
                visited.add(next_node)
                search_path.append(next_node)
                out.append(next_node)
    return out, visited
{% endhighlight %}
At this point I tried quite hard (and in vain) to find a good reason why DFS was a better choice *in terms of time complexity*.
This was complicated by the fact that people seem to prefer DFS when visiting every vertex.
(Presumably this is for the space-saving advantages mentioned above.)
When I realised my mistake and used the appropriate queue library my BFS solution passed the Hackerrank test cases also:
{% highlight python%}
def bfs(start, adj_list, visited): # O(v+e)
    q = deque()
    q.append(start)
    out = [start]
    visited.add(start)
    while len(q):
        node = q.popleft()
        for x in adj_list[node]:
            if x not in visited:
                q.append(x)
                visited.add(x)
                out.append(x)
    return out, visited
{% endhighlight%}
The complete solution is displayed below:
{% highlight python %}
import queue
from collections import deque

def get_adj_list(nodes, edges): # O(v+e)
    out = [[] for i in nodes]
    for edge in edges:
        a, b = edge
        out[a-1].append(b-1)
        out[b-1].append(a-1)
    return out

def bfs(start, adj_list, visited): # O(v+e)
    q = deque()
    q.append(start)
    out = [start]
    visited.add(start)
    while len(q):
        node = q.popleft()
        for x in adj_list[node]:
            if x not in visited:
                q.append(x)
                visited.add(x)
                out.append(x)
    return out, visited

def bfs_wrong_queue(start, adj_list, visited): # O(??)
    q = queue.Queue()
    q.put(start)
    out = [start]
    visited.add(start)
    while q.qsize():
        node = q.get()
        for x in adj_list[node]:
            if x not in visited:
                q.put(x)
                visited.add(x)
                out.append(x)
    return out, visited

def dfs(start, adj_list, visited): # O(v+e)
    search_path = [start]
    visited.add(start)
    out = [start]
    while search_path:
        node = search_path[-1]
        if not adj_list[node]:
            search_path.pop()
        else:
            next_node = adj_list[node].pop()
            if next_node not in visited:
                visited.add(next_node)
                search_path.append(next_node)
                out.append(next_node)
    return out, visited


def roadsAndLibraries(n, c_lib, c_road, cities): # O(v*(v+e))
    if c_lib <= c_road:
        return n*c_lib
    adj_list = get_adj_list(list(range(n)), cities)
    nodes = list(range(n))
    cost = 0
    visited = set([])
    for start in nodes:
        if start not in visited: # repeated for every connected component
            comp, visited = bfs(start, adj_list, visited)
            cost += c_lib + (len(comp)-1)*c_road
    return cost
{% endhighlight %}