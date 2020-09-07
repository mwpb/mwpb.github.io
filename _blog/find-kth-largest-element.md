---
layout: blog
title:  "Find kth largest element"
tags: coding python
---

(Elements of programming interviews 11.8.)

Consider the problem of finding the `k`th largest element in an unsorted array.
We can use the following modification of heap sort.
{% highlight python %}
import heapq
def kth_largest(l, k): # O(n log(k))
    min_heap = []
    for i in l:
        if len(min_heap) < k:
            heapq.heappush(min_heap, i)
        elif min_heap[0] < i:
            heapq.heappushpop(min_heap, i)
    return min_heap[0]
{% endhighlight %}
which runs in `O(N*log(K))` time because each call to `heappush` or `heappushpop` is `O(log(K))`.

In fact if we use a variation of quicksort we can get an *average-case* time complexity of `O(N)` but a worst-case time complexity of `O(N^2)`.
The idea is that by partitioning the array around a pivot element we can eliminate many elements of the array at once.
An extremely rough implementation might be as follows:
{% highlight python %}
from random import randrange
def qs_imitation(l, k): # worst case O(N^2) average case O(N)
    print(f'qs_imitation({l}, {k})')
    m = randrange(len(l))
    pivot = l[m]
    above = []
    below = []
    same = []
    for i in l:
        if i > pivot:
            above.append(i)
        elif i < pivot:
            below.append(i)
        else:
            same.append(i)
    print(m, below, same, above)
    if len(above) == k-1:
        return pivot
    elif len(above) >= k:
        return qs_imitation(above, k)
    elif len(above) + len(same) > k:
        return pivot
    else:
        return qs_imitation(below, k-len(above)-len(same))
{% endhighlight %}
where the problem is that we have no way of guaranteeing that the randomly chosen element isn't the largest element each time.