import sys
from collections import deque

dx = [-1, -1, 0, 1, 1, 1, 0, -1]
dy = [0, -1, -1, -1, 0, 1, 1, 1]

n, m = map(int, input().split())
board = []
infos = []
for y in range(n):
    board.append(list(map(int, input().split())))

for i in range(m):
    infos.append(list(map(int, input().split())))


def solution():
    cloud = deque([[0, n - 1], [1, n - 1], [0, n - 2], [1, n - 2]])

    for info in infos:
        d, s = info

        for c in range(len(cloud)):
            x = cloud[c][0]
            y = cloud[c][1]

            for i in range(s):
                x = x + dx[d - 1]
                y = y + dy[d - 1]

                if x < 0:
                    x = n - 1
                if y < 0:
                    y = n - 1
                if x >= n:
                    x = 0
                if y >= n:
                    y = 0

            cloud[c][0] = x
            cloud[c][1] = y

        for y in range(len(cloud)):
            board[cloud[y][1]][cloud[y][0]] += 1

        # 1, 3, 5, 7 (대각)

        for c in range(len(cloud)):
            x = cloud[c][0]
            y = cloud[c][1]
            cnt = 0
            for i in range(4):  # 1 3 5 7
                nx = x + dx[i * 2 + 1]
                ny = y + dy[i * 2 + 1]

                if not (nx >= 0 and nx < n and ny >= 0 and ny < n):
                    continue
                if board[ny][nx] > 0:
                    cnt += 1

            board[y][x] += cnt

        next_cloud = []
        visited = [[0] * n for _ in range(n)]
        for c in cloud:
            visited[c[1]][c[0]] = 1
        for y in range(n):
            for x in range(n):
                if board[y][x] >= 2 and visited[y][x] != 1:
                    next_cloud.append([x, y])
                    board[y][x] -= 2

        cloud = next_cloud

    answer = 0
    for y in range(n):
        answer += sum(board[y])
    return answer


print(solution())
