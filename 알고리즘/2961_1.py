# import sys

# input = sys.stdin.readline

# n = int(input())
# ingredients = []

# for _ in range(n):
#     ingredients.append(list(map(int, input().split())))

# # 신맛은 재료의 곱
# # 쓴맛은 합임
# answer = 1e9

# def dfs(depth, ingred):
#     global answer
#     if depth == n:
#         if len(ingred) > 0:
#             s = 1
#             b = 0
#             for i in ingred:
#                 s *= i[0]
#                 b += i[1]
#             answer = min(answer, abs(s - b))
#         return

#     dfs(depth + 1, ingred + [ingredients[depth]])
#     dfs(depth + 1, ingred)


# dfs(0, [])
# print(answer)

import sys

input = sys.stdin.readline

n = int(input())
ingredients = []

for _ in range(n):
    ingredients.append(list(map(int, input().split())))

# 신맛은 재료의 곱
# 쓴맛은 합임
answer = sys.maxsize


def dfs(depth, sour, bitter):
    global answer
    if depth == n:
        if sour > 1 and bitter > 0:
            answer = min(answer, abs(sour - bitter))
        return

    dfs(depth + 1, sour, bitter)
    dfs(depth + 1, sour * ingredients[depth][0], bitter + ingredients[depth][1])


dfs(0, 1, 0)

print(answer)
