import sys

input = sys.stdin.readline

n, m, k = map(int, input().split())
board = [[0] * m for _ in range(n)]
stickers = []
for i in range(k):
    r, c = map(int, input().split())
    sticker = []
    for y in range(r):
        sticker.append(list(map(int, input().split())))
    stickers.append(sticker)


def check(x, y):
    return x >= 0 and x < m and y >= 0 and y < n


def find_location(sticker):
    start_point = []

    for y in range(n):
        for x in range(m):
            flag = True
            for sy in range(len(sticker)):
                for sx in range(len(sticker[sy])):
                    nx = x + sx
                    ny = y + sy

                    if not check(nx, ny):
                        flag = False
                        break
                    if board[ny][nx] == 1 and sticker[sy][sx] == 1:
                        flag = False
                        break

                if flag == False:
                    break
            if flag == True:
                start_point.append((x, y))
    return start_point


def apply_sticker(start, sticker):
    for y in range(len(sticker)):
        for x in range(len(sticker[y])):
            if not board[y + start[1]][x + start[0]] == 1:  # 색칠조건 확실히하기
                board[y + start[1]][x + start[0]] = sticker[y][x]


def rotate(sticker):
    return list(map(list, zip(*sticker[::-1])))


for sticker in stickers:
    start_locations = find_location(sticker=sticker)
    if len(start_locations) > 0:
        apply_sticker(start_locations[0], sticker)
    else:
        rotate_index = 0
        while rotate_index < 3:
            sticker = rotate(sticker)
            start_locations = find_location(sticker)
            if len(start_locations) > 0:
                apply_sticker(start_locations[0], sticker)
                break  # 처음 틀렸던 이유 while 문에서 조건탈출할떄 break 잊지말기
            rotate_index += 1

answer = 0
for y in range(n):
    for x in range(m):
        if board[y][x] == 1:
            answer += 1
print(answer)
