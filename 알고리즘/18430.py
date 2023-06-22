import sys

input = sys.stdin.readline

n, m = map(int, input().split())
graph = []
visited = [[0] * m for _ in range(n)]
answer = 0
for i in range(n):
    graph.append(list(map(int, input().split())))


# 가운데 기준
def make_wood(x, y):
    return [
        [(x, y), (x + 1, y), (x, y + 1)],
        [(x, y), (x - 1, y), (x, y + 1)],
        [(x, y), (x, y - 1), (x - 1, y)],
        [(x, y), (x + 1, y), (x, y - 1)],
    ]


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


# 백트래킹에서 주의해야할점
# 1. 탈출조건을 잡지 못하면 이것부터 함 잘 생각해보자
# 2. 조건을 잘 나눠야한다.
# 아래에서는
# 1.부메랑을 넣을 것이다.
# 1.1 어떤 부메랑을 넣을 것이냐
# 1.2 넣고 백트
# 2. 부메랑을 넣지 않을 것이다.
# 2.1 어떤 기준으로 안넣고 백트래킹을 돌릴 것인가


def backtracking(start, strength):
    global answer
    if start[1] == n:
        answer = max(answer, strength)
        return

    if start[0] < m:
        backtracking((start[0] + 1, start[1]), strength)
    elif start[1] < n:
        backtracking((0, start[1] + 1), strength)

    for wood in make_wood(start[0], start[1]):
        mid = wood[0]
        left = wood[1]
        right = wood[2]
        if not check(mid[0], mid[1]):
            continue
        if not check(right[0], right[1]):
            continue
        if not check(left[0], left[1]):
            continue
        if (
            visited[mid[1]][mid[0]] == 0
            and visited[left[1]][left[0]] == 0
            and visited[right[1]][right[0]] == 0
        ):
            visited[mid[1]][mid[0]] = 1
            visited[left[1]][left[0]] = 1
            visited[right[1]][right[0]] = 1
            if start[0] < m:
                backtracking(
                    (start[0] + 1, start[1]),
                    strength
                    + graph[mid[1]][mid[0]] * 2
                    + graph[left[1]][left[0]]
                    + graph[right[1]][right[0]],
                )
            elif start[1] < n:
                backtracking(
                    (0, start[1] + 1),
                    strength
                    + graph[mid[1]][mid[0]] * 2
                    + graph[left[1]][left[0]]
                    + graph[right[1]][right[0]],
                )
            visited[mid[1]][mid[0]] = 0
            visited[left[1]][left[0]] = 0
            visited[right[1]][right[0]] = 0
    answer = max(answer, strength)


backtracking((0, 0), 0)
print(answer)
