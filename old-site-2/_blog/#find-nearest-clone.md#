---
layout: blog
title:  "Find nearest clone"
tags: coding python
---
(Hackerrank 'Find the nearest clone' problem.)

One advantage of a breadth-first search over a depth-first search is that we can extract the shortest distance between two nodes.
One way of doing this (at the cost of a little extra space) is to use a queue whose elements consist not simply of nodes but of pairs `(d, n)` where `n` is a node and `d` is an integer recording the distance from the start node.
{% highlight python %}
def bfs(start, adj_dict, is_end_node):
    visited = set([])
    q = deque([(start, 0)])
    while len(q):
        node, distance = q.pop()
        for next_node in adj_dict[node]:
            if next_node not in visited:
                if is_end_node(next_node):
                    return distance+1, next_node
                visited.add(next_node)
                q.appendleft((next_node, distance+1))
    return -1, None
{% endhighlight %}
where we have assumed that we are given a function `is_end_node` that tells us if a particular node is the one we are searching for.
Consider the following problem (from Hackerrank):
* start with a *connected* and coloured graph
* given a single colour
* find the shortest path between nodes of that colour

The idea is to find the first node `n1` of the correct colour `c` and find the shortest path starting at that node to another node `n2` of colour `c`.
Then -- marking the nodes `n1` and `n2` as visited -- find the nearest `n3` of colour `c` to `n2` that is not marked as visited.
Repeating we will take into account every node of colour `c` because the graph is connected.
Then we can record the shortest of the lengths of the paths we calculated.
The full solution might look like:
{% highlight python%}
def get_adj_dict(graph_nodes, graph_from, graph_to):
    adj_dict = defaultdict(list)
    for i, start in enumerate(graph_from):
        adj_dict[start].append(graph_to[i])
        adj_dict[graph_to[i]].append(start)
    return adj_dict

def bfs(start, adj_dict, color, visited, color_lookup):
    q = deque([(start, 0)])
    while len(q):
        node, distance = q.pop()
        for next_node in adj_dict[node]:
            if next_node not in visited:
                visited.add(next_node)
                if color_lookup[next_node] == color:
                    return distance+1, next_node
                q.appendleft((next_node, distance+1))
    return -1, None

def get_color_lookup(ids):
    color_lookup = {}
    for i, color in enumerate(ids):
        color_lookup[i+1] = color
    return color_lookup

def findShortest(graph_nodes, graph_from, graph_to, ids, val):
    adj_dict = get_adj_dict(graph_nodes, graph_from, graph_to)
    color_lookup = get_color_lookup(ids)
    try:
        node = ids.index(val) + 1
    except:
        return -1
    visited = set([node])
    out = float('inf')
    while len(visited) < graph_nodes:
        x, node = bfs(node, adj_dict, val, visited, color_lookup)
        if x == -1:
            break
        elif x < out:
            out = x
    return -1 if out == float('inf') else out
{% endhighlight %}