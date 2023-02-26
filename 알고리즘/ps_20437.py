import sys
from collections import defaultdict


t = int(sys.stdin.readline().rstrip())
for _ in range(t):
    w = sys.stdin.readline().rstrip()
    k = int(sys.stdin.readline().rstrip())

    temp_alpha = defaultdict(list)
    for i in range(len(w)):
        temp_alpha[w[i]].append(i)

    min_val = float('INF')
    max_val = -float('inf')
    alpha = defaultdict(list)
    for i in temp_alpha:
        if len(temp_alpha[i]) >= k:
            alpha[i] = temp_alpha[i][:]

    if len(alpha) == 0:
        print(-1)
        continue

    print(alpha)

    for alpha_index in alpha.values():
        for start in range(len(alpha_index)-k+1):
            temp = abs(alpha_index[start+k-1]-alpha_index[start])+1
            min_val = min(min_val, temp)
            max_val = max(max_val, temp)
    print(min_val, max_val)
