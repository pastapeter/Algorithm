import sys
from collections import defaultdict

input = sys.stdin.readline

n = int(input())
board = []
for _ in range(n):
    board.append(list(map(int, input().split())))

# 1. 종이가 모두 같은 수로 되어있다면 이 종이를 그대로 사용
# 2. 1이 아닌경우 종이를 같은 9개로 자르고 각 잘린 종이에서 반복
answerdict = defaultdict(int)


def dfs(n, start, end):
    global answerdict
    x1, y1 = start
    x2, y2 = end

    if n == 1:
        answerdict[board[y1][x1]] += 1
        return

    k = board[y1][x1]
    flag = True
    for y in range(y1, y2):
        for x in range(x1, x2):
            if board[y][x] != k:
                flag = False
                break
        if flag == False:
            break

    if flag == False:
        dfs(n // 3, (x1, y1), (x1 + n // 3, y1 + n // 3))
        dfs(n // 3, (x1 + n // 3, y1), (x1 + 2 * n // 3, y1 + n // 3))
        dfs(n // 3, (x1 + 2 * n // 3, y1), (x1 + 3 * n // 3, y1 + n // 3))

        dfs(n // 3, (x1, y1 + n // 3), (x1 + n // 3, y1 + 2 * n // 3))
        dfs(n // 3, (x1 + n // 3, y1 + n // 3), (x1 + 2 * n // 3, y1 + 2 * n // 3))
        dfs(n // 3, (x1 + 2 * n // 3, y1 + n // 3), (x1 + 3 * n // 3, y1 + 2 * n // 3))

        dfs(n // 3, (x1, y1 + 2 * n // 3), (x1 + n // 3, y1 + 3 * n // 3))
        dfs(n // 3, (x1 + n // 3, y1 + 2 * n // 3), (x1 + 2 * n // 3, y1 + 3 * n // 3))
        dfs(
            n // 3,
            (x1 + 2 * n // 3, y1 + 2 * n // 3),
            (x1 + 3 * n // 3, y1 + 3 * n // 3),
        )

    else:
        answerdict[k] += 1
        return


dfs(n, [0, 0], [n, n])
print(answerdict[-1])
print(answerdict[0])
print(answerdict[1])
