import sys
from collections import defaultdict

input = sys.stdin.readline

# 어느 땅에서, 번호의 군사 병사가 절반 초과시 그 번호가 지배함
n = int(input())
lands = []
answer = []
for i in range(n):
    temp = list(map(int, input().split()))
    temp_dict = defaultdict(int)
    flag = False
    for i in temp[1:]:
        temp_dict[i] += 1
        if temp_dict[i] > temp[0] // 2:
            flag = True
            answer.append(f"{i}")
            break
    if not flag:
        answer.append("SYJKGW")

for ans in answer:
    print(ans)
