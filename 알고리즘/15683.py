import sys
import copy

input = sys.stdin.readline

cctvs = ["1", "2", "3", "4", "5"]
direction_dic = {
    "1": [[(1, 0)], [(0, 1)], [(-1, 0)], [(0, -1)]],
    "2": [[(1, 0), (-1, 0)], [(0, 1), (0, -1)]],
    "3": [[(1, 0), (0, -1)], [(0, -1), (-1, 0)], [(-1, 0), (0, 1)], [(0, 1), (1, 0)]],
    "4": [
        [(1, 0), (0, -1), (-1, 0)],
        [(0, -1), (-1, 0), (0, 1)],
        [(-1, 0), (0, 1), (1, 0)],
        [(0, 1), (1, 0), (0, -1)],
    ],
    "5": [[(1, 0), (0, -1), (-1, 0), (0, 1)]],
}
n, m = map(int, input().split())
office = []

for y in range(n):
    office.append(list(map(str, input().split())))

answer = 1e9


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


def dfs(starts, board, depth):
    global answer

    if len(starts) == depth:
        temp_answer = 0
        for y in range(n):
            for x in range(m):
                if board[y][x] == "0":
                    temp_answer += 1
        answer = min(answer, temp_answer)
        return
    start = starts[depth]
    directions = direction_dic[office[start[1]][start[0]]]
    for direction in directions:
        new_board = copy.deepcopy(board)
        for d in direction:
            nx = start[0]
            ny = start[1]
            while True:
                nx += d[0]
                ny += d[1]
                if check(nx, ny) and new_board[ny][nx] != "6":
                    if new_board[ny][nx] == "0":
                        new_board[ny][nx] = "#"
                else:
                    break
        dfs(starts, new_board, depth + 1)


starts = []
for y in range(n):
    for x in range(m):
        if office[y][x] in cctvs:
            starts.append((x, y))

dfs(starts, office, 0)

print(answer)
