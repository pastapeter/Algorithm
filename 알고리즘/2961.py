import sys

input = sys.stdin.readline

answer = 1e9


def dfs(taste, ingredients, depth):
    global answer
    if depth == len(taste):
        if len(ingredients) > 0:
            ns = 1
            nb = 0
            for ingredient in ingredients:
                ns *= ingredient[0]
                nb += ingredient[1]
            answer = min(answer, abs(nb - ns))
        return

    dfs(taste, ingredients + [taste[depth]], depth + 1)
    dfs(taste, ingredients, depth + 1)


def solution():
    n = int(input())
    tastes = []
    for i in range(n):
        s, b = map(int, input().split())
        tastes.append((s, b))
    if n == 1:
        print(abs(s - b))
    else:
        dfs(tastes, [], 0)
        print(answer)


solution()
