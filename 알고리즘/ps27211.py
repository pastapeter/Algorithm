import sys
import heapq
from itertools import combinations

hq = []
# 파이썬은 minheap임

heapq.heappush(hq, 3)
heapq.heappush(hq, 2)
heapq.heappush(hq, 1)

print(heapq.heappop(hq))

hq = [3,5,4,1,2]
heapq.heapify(hq)
print(heapq.heappop(hq))
print(heapq.heappop(hq))
print(heapq.heappop(hq))
print(heapq.heappop(hq))
print(heapq.heappop(hq))

size = 10
arr = [i * 2 for i in range(size)]

arr2 = [[i] * size for i in range(size) ]
# print(arr2)
arr3 = list(map(list, zip(*arr2)))
# for i in range(size):
#     print(arr3[i])
print(arr)
print(arr[0::2])
print(arr[::-1])

arr.pop(2)
arr.remove(18)
print(arr)
del arr[0::2]
print(arr)

print(list(combinations(arr, 3)))

