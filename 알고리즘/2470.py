import sys

input = sys.stdin.readline

# 산성 1 ~ 1000..
# 알칼리 -1 ~ -1000..
# 두수의합
# 2개의 용액을 혼합해서 특성값이 0에 가까운?
# 금방 풀었는데, 왜 안되나했더니 출력형식을 이상하게 해버림

n = int(input())
nums = list(map(int, input().split()))
nums.sort()
answer = (1000000000, 1000000000)


def solution():
    global answer
    start = 0
    end = n - 1

    while start < end:
        # -99 -98 -1 4 96 98
        if abs(nums[start] + nums[end]) - 0 < abs(answer[0] + answer[1]) - 0:
            answer = (nums[start], nums[end])
        if nums[start] + nums[end] < 0:
            start += 1
        elif nums[start] + nums[end] > 0:
            end -= 1
        else:
            return (nums[start], nums[end])
    return answer


print(solution()[0], solution()[1])
