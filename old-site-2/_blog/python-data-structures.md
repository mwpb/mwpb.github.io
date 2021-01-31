---
layout: blog
title:  "Python data structures"
tags: coding python
---

Often the data structures in the `collections` module are better or more readable.

## Stacks

The built-in list type is pretty good.
But `collections.deque` is apparently better as it is implemented as a doubly linked list.
For instance:
{% highlight python%}
from collections import deque
s = deque()
s.append('a')
a = s.pop()
{% endhighlight %}
just like the usual list type.

## Heaps

Any list `l` can be transformed to a min-heap using `heapq.heapify(l)`.
(The heap uses the convention that the elements at `2n+1` and `2n+2` are the children of the element at `n`.)
Then `heapq.heappush(heap, ele)` provides the `O(log(n))` function to put `ele` in a legitimate position.
The smallest element can be accessed in `O(1)` time with `l[0]` (after heapifying).
To remove the top element use `heappop(heap)` which is `O(log(n))` because it has to rearrange the rest of the elements into a heap.
There is also `heappushpop(heap, ele)` which is slightly faster than the two separate commands and is useful when we want to keep the heap at a constant size.
{% highlight python%}
from heapq import heapify, heappush, heappop
l = [2, 4, 3, 6, 1, 5]
heapify(l) # l = [1, 2, 3, 6, 4, 5]
heappush(l, 45)
a = l.heappop(l) # a = 	1, l = [2, 4, 3, 6, 45, 5] 
{% endhighlight %}
where we note that each of the functions must take the heap as their first argument.

## Queues

Again `collections.deque` is the one to use.
For instance:
{% highlight python%}
from collections import deque
s = deque()
s.appendleft('a')
s.appendleft('b')
a = s.pop()
{% endhighlight %}
and `queue.Queue()` is probably not appropriate as it is intended to allow different threads to communicate.

## Hash tables

Here it is unclear whether to use the standard `dict` type or `collections.defaultdict`.
The distinction is that `dict` will throw an error on a missing key but `collections.defaultdict` will provide a default value.
For instance:
{% highlight python%}
from collections import defaultdict
d = defaultdict(int)
d['one'] = 1
four = d['four'] # four contains 0
{% endhighlight %}
where `0` is the default value for the `int` type and `[]` is the default value for the `list` type.
Further one can specify a function to customise the default value returned.