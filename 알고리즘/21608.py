import sys

input = sys.stdin.readline

# n*n 격자
# 1,1부터
# 비어있는 칸 중에서 좋아하는 학생이 인접한 칸에 가장 많은 칸으로 자리를 정한다.
# 위에 칸이 여러개면, 인접한 칸 중에 비어있는 칸이 가장 많은 자리?
# 행번호가 가장 작은 칸, 그리고 열번호가 가장 작은 칸
# 마지막 만족도 총합

dx = [-1, 1, 0, 0]
dy = [0, 0, -1, 1]
n = int(input())
board = [[0] * n for _ in range(n)]


def check(x, y):
    return x >= 0 and x < n and y >= 0 and y < n


def condition1(person):
    mates = person[1]
    positions = []
    for y in range(n):
        for x in range(n):
            if board[y][x] == 0:
                adjacentFriend = 0
                for i in range(4):
                    nx = x + dx[i]
                    ny = y + dy[i]

                    if check(nx, ny):
                        if board[ny][nx] in mates:
                            adjacentFriend += 1
                positions.append((x, y, adjacentFriend))

    positions.sort(key=lambda x: x[2], reverse=True)
    answer = []
    if len(positions) > 0:
        max_friend = positions[0][2]
        for position in positions:
            if position[2] == max_friend:
                answer.append(position)
    return answer


def condition2(cells):
    # (x, y, num)
    candidates = []
    max_cnt = 0
    for cell in cells:
        x = cell[0]
        y = cell[1]
        cnt = 0
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]

            if check(nx, ny) and board[ny][nx] == 0:
                cnt += 1
        if max_cnt < cnt:
            max_cnt = cnt
        candidates.append((x, y, cell[2], cnt))

    answer = []
    for candidate in candidates:
        if candidate[3] == max_cnt:
            answer.append((candidate[0], candidate[1], candidate[2]))
    return answer


def condition3(cells):
    global board
    min_y_cell = min(cells, key=lambda x: x[1])
    min_y_cells = []
    for cell in cells:
        if cell[1] == min_y_cell[1]:
            min_y_cells.append(cell)

    if len(min_y_cells) > 1:
        return min(min_y_cells, key=lambda x: x[0])
    else:
        return min_y_cell


people = []
dic = {}
for i in range(n * n):
    person, a, b, c, d = map(int, input().split())
    dic[person] = [a, b, c, d]
    people.append((person, [a, b, c, d]))

for i, person in enumerate(people):
    cells = condition1(person)
    if len(cells) > 1:
        cells_2 = condition2(cells)
        if len(cells_2) > 1:
            cell = condition3(cells_2)
            board[cell[1]][cell[0]] = person[0]
        else:
            board[cells_2[0][1]][cells_2[0][0]] = person[0]
    else:
        board[cells[0][1]][cells[0][0]] = person[0]


answer = 0
for y in range(n):
    for x in range(n):
        cnt = 0
        for i in range(4):
            nx = x + dx[i]
            ny = y + dy[i]

            if check(nx, ny):
                if board[ny][nx] in dic[board[y][x]]:
                    cnt += 1
        if cnt != 0:
            answer += pow(10, cnt - 1)
print(answer)
