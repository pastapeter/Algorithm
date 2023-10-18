import sys

input = sys.stdin.readline

# 잘못된 수를 부를때 0 -> 가장 최근의 재민이가 쓴 수를 지운다

k = int(input())
nums = []
for _ in range(k):
    nums.append(int(input()))

stack = []
for num in nums:
    if num != 0:
        stack.append(num)
    else:
        if len(stack) > 0:
            stack.pop()

print(sum(stack))
