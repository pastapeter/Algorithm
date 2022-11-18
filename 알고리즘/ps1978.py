import sys
import math
input = sys.stdin.readline

num = int(input())
numlist = list(map(int, input().split()))
answer = 0

def ispriorNum(num):
    if num < 4:
        if num == 1:
            return  False
        return True
    for d in range(2, int(math.sqrt(num))+1):
        if num % d == 0:
            return False
    return True

for c in numlist:
    if ispriorNum(c):
        answer += 1

print(answer)