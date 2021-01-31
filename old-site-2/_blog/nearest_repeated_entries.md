---
layout: blog
title:  "Find the nearest repeated entries in an array"
tags: coding python
---

(Elements of programming interviews 12.5.)

One way of improving time complexity at the expense of space complexity is to use a cache.
If a programme makes multiple passes over the same data or calls to the same function a cache might be useful.
We avoid redundant computations because the results to previous work can be accessed in `O(1)` time.

For instance consider the problem:-
* given an array of strings
* find the distance between the two closest equal strings.

A brute-force approach might be to find -- for each element of the array -- the next element of the array equal to it.
So a carefree solution might be the following:
{% highlight python %}
def bf_nearest_repeat(l): # O(n^2)
    gap = len(l)
    for j in range(len(l)):
        for i in range(j + 1, min(len(l), j + gap)):
            if (l[j] == l[i]) and (i - j < gap):
                gap = i - j
            break
    return gap
{% endhighlight %}
which has `O(n^2)` time complexity and `O(1)` space complexity.
Notice also that we are making multiple passes over the data.

A cache improves the time complexity because it makes the outer loop redundant.
We don't have to iterate through the array for each element but only keep track of the most recent occurrence of each element.
This could look like:
{% highlight python %}
def nearest_repeat(l): # O(n)
    last_occurrence = {}
    gap = float('inf')
    for i, ele in enumerate(l):
        if ele in last_occurrence and gap > i-last_occurrence[ele]:
            gap = i-last_occurrence[ele]
        last_occurrence[ele] = i
    return gap
{% endhighlight %}
which has time complexity `O(n)` and `O(n)` space complexity.