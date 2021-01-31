---
layout: blog
title:  "Implement a queue with two stacks"
tags: coding python
---
(Hackerrank exercise.)

In this implementation of a queue the dequeue operation will have *average-case* time complexity `O(1)` but worst-case time complexity `O(n)`.
So there are better ways to implement a queue.
The idea is to use one list as an inbox and the other as an outbox.
The key tactic to implement this idea is that reversing a stack amounts to popping each element and appending it to a new stack:
{% highlight python %}
def rev_stack(stk):
    out_stk = []
    while stk:
        ele = stk.pop()
        out_stk.append(ele)
    return out_stk
{% endhighlight %}
which in the abstract arises from the fact that a stack has the *first-in-last-out* property.
So the algorithm as a whole is:
* maintain two stacks: call them in_stack and out_stack
* enqueue: append the new item to the in_stack (`O(1)` worst case)
* dequeue: pop an item from the out_stack *then if the out_stack has now become empty* pop the elements of the in_stack one by one and append them onto the out_stack (`O(n)` worst-case but `O(1)` average-case)

and note that the last bullet contains the operation `rev_stack` as described above.
In total we have:
{% highlight python %}
class MyQueue(object):
   def __init__(self):
       self.instack = []
       self.outstack = []

   def peek(self):
       out = self.outstack[-1]
       return out

   def shuffle(self):
       if not self.outstack:
           while self.instack:
               ele = self.instack.pop()
               self.outstack.append(ele)

   def pop(self):
       out = self.outstack.pop()
       self.shuffle()
       return out

   def put(self, value):
       self.instack.append(value)
{% endhighlight %}
where we have written `enqueue` as `put` and `dequeue` as `pop`.