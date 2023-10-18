from collections import defaultdict

dict = defaultdict(list)
for i in range(10):
    temp = set()
    temp.add(i)
    dict[frozenset(temp)] = i
print(dict)
