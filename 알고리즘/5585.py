import sys

input = sys.stdin.readline

# 500, 100, 50, 10, 5, 1
# 거슬름돈 개수가 가장 적게 잔돈을 준다

n = int(input())
change = 1000 - n
ans = 0
while change != 0:
    for coin in [500, 100, 50, 10, 5, 1]:
        if change >= coin:
            change -= coin
            ans += 1
            break

print(ans)
