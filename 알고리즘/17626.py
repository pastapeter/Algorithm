from math import sqrt, isqrt
from itertools import combinations_with_replacement

# 문제는 dp로 금방 풀었는데
# Python3에서 시간초과가 나서 왜 자꾸 시간초과가 나나 했지만
# 결국 pypy3 로 푸니깐 돌아갔다.


n = int(input())
dp = [i for i in range(n + 1)]

if sqrt(n) == isqrt(n):
    print(1)
else:
    for i in range(2, n + 1):
        min_value = 1e9
        j = 1
        while j * j <= i:
            min_value = min(min_value, dp[i - (j**2)])
            j += 1
        dp[i] = min_value + 1

    print(dp[n])

# 근데 완전탐색으로 푸는 방식이 다른 풀이 보다 빨랐는데
# 풀이방법
# N 은 제곱수의 합이다. \
# 부분적으로 또 그것은 제곱수의 합일 것이다.
# 그렇기 때문에, n보다 작은 모든 제곱수를 만들고
# 2개로 중복조합을 구한다.
# 1, 2개만 있으면 3,4,5,6개를 찾아내는 것
# 그래서 그냥 제곱수면 1
# 제곱수의 합이면 2
# 제곱수중에서 n에서 제곱수를 뺀서 만든것이 제곱수 2개 더해서 만드는것
# 근데 제곱수의 합에서 4개를 넘는 것이없는데
# 5 -> 1,1,1,1,1 -> 2, 1로 바꿀수 있다는 것이다.
# 어쨋든 제곱수2개의 합의 합으로 바꿀수 있기 때문
# 이것은 좀 근데 생각하기 까다로운것같아서 dp가 바로 생각난대로 한다.


# n = int(input())
# square_num_li = [i*i for i in range(1, int(sqrt(n))+1)]
# square_num_li_2 = [sum(k) for k in combinations_with_replacement(square_num_li, 2)]

# def answer(n):
#     if n in square_num_li: # 제곱수면
#         return 1
#     elif n in square_num_li_2: # 제곱수 두개를 더해서 만들 수 있는 수면
#         return 2
#     else:
#         for square in square_num_li: # 제곱 수 중
#             if n - square in square_num_li_2: # n에서 제곱수를 뺀 수가 제곱수 두개를 더해서 만들수 있는 수면
#                 return 3
#     return 4

# print(answer(n))
for i in range(2, math.isqrt(n) + 1):
    for j in range(i * i, n + 1):
        if j > n:
            break
        tempJ = j
        temp = 0
        if tempJ >= i * i:
            temp += 1
            tempJ -= i * i
        if tempJ > 0:
            dp[j] = min(dp[j], temp + dp[tempJ])
        else:
            dp[j] = min(dp[j], temp)
