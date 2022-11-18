import sys

input = sys.stdin.readline

N = int(input())
A = list(map(int, input().split()))
plus, minus, multi, div = map(int, input().split())
minVal = sys.maxsize
maxVal = -(sys.maxsize+1)

def dfs(plus, minus, multi, div, nums):
    global minVal
    global maxVal

    if len(nums) == 1:
        minVal = min(minVal, nums[-1])
        maxVal = max(maxVal, nums[-1])
    
    if plus > 0:
        result = nums[0] + nums[1]
        dfs(plus-1, minus, multi, div, [result]+nums[2:])
    if minus > 0:
        result = nums[0] - nums[1]
        dfs(plus, minus-1, multi, div, [result]+nums[2:])
    if multi > 0:
        result = nums[0] * nums[1]
        dfs(plus, minus, multi-1, div, [result]+nums[2:])
    if div > 0:
        if nums[0] < 0:
            result = -(-nums[0] // nums[1])
        else:
            result = nums[0] // nums[1]
        dfs(plus, minus, multi, div-1, [result]+nums[2:])


dfs(plus, minus, multi, div, A)
print(maxVal)
print(minVal)