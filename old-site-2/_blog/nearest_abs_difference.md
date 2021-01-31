---
layout: blog
title:  "Nearest absolute difference"
tags: coding python
---

(Example from Hackerrank problem 'Minimum Absolute Difference in an Array'.)

The built-in Python array sorting algorithm invoked by `sorted(-)` uses the [timsort](https://en.wikipedia.org/wiki/Timsort) algorithm which has worst case time complexity `O(n log(n))`. 
This means that if we have a programme involving arrays which has complexity worse than `O(n log(n))` it might be appropriate to sort the arrays first.
(Note that finding a way to use a hash table cache as in [Find the nearest repeated entries in an array](nearest_repeated_entries.md) is even better. But that might not be possible.)

Consider the following example from the Hackerrank problem 'Minimum Absolute Difference in an Array':-

* given an array of integers
* find the difference between the closest two numbers in the array

The brute-force algorithm that comes immediately to mind is to iterate twice through the array thereby comparing each pair of numbers:
{% highlight python %}
def nearest_dist(arr): # O(n^2)
    minimum = float('inf')
    for i in range(len(arr)):
        for j in range(i+1, len(arr)):
            if abs(arr[i] - arr[j]) < minimum:
                minimum = abs(arr[i] - arr[j])
    return minimum
{% endhighlight %}
which has time complexity `O(n^2)`.

However this solution takes too long to solve the Hackerrank exercise (one gets a `timed out`-style error).
Reasoning as above: we see that `O(n^2)` is worse than `O(n log(n))` and furthermore a moment's thought tells us that solving the problem would be much easier with a sorted array.
So we can try:
{% highlight python %}
def nearest_dist(arr): # O(n log(n))
    minimum = float('inf')
    a = sorted(arr)
    for i, _ in enumerate(a):
        if abs(a[i] - a[i+1]) < minimum:
            minimum = abs(a[i] - a[i+1])
    return minimum
{% endhighlight %}
which has time complexity `O(n log(n))` and passes as a Hackerrank submission.
