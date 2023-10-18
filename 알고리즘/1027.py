# 고층빌딩
# A.height <= [가운데.height] 면 B가 안보임

import sys

input = sys.stdin.readline
n = int(input())
heights = list(map(int, input().split()))


def slope(x1, y1, x2, y2):
    return (y2 - y1) / (x2 - x1)


# 지금 고른 기준으로

if n == 1:
    print(0)
else:
    answer = 0
    for i, height in enumerate(heights):
        total = 0
        left_max = float("inf")
        right_max = -float("inf")
        for j in range(i - 1, -1, -1):
            print(i + 1, height, j + 1, heights[j])
            gradient = slope(i + 1, height, j + 1, heights[j])
            if gradient < left_max:
                left_max = gradient
                total += 1
        for j in range(i + 1, n):
            gradient = slope(i + 1, height, j + 1, heights[j])
            if gradient > right_max:
                right_max = gradient
                total += 1

        answer = max(total, answer)
    print(answer)
