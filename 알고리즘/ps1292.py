import sys

input = sys.stdin.readline

numlist = []
A, B = map(int, input().split())
answer = 0

for i in range(1, 1001):
    numlist += [i]*i

for i in numlist[A-1:B]:
    answer += i

print(answer)