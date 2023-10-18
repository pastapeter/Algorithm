FIRST = "X"
LAST = "O"
CLEAR = "."
FALSE = 0
TRUE = 1


def check_bingo(board):
    first_bingo_cnt = 0
    last_bingo_cnt = 0
    for y in range(3):
        line = set(board[y])
        if len(line) == 1 and CLEAR not in line:
            if FIRST in line:
                first_bingo_cnt += 1
            else:
                last_bingo_cnt += 1

    for y in range(3):
        line = set(list(zip(*board))[y])
        if len(line) == 1 and CLEAR not in line:
            if FIRST in line:
                first_bingo_cnt += 1
            else:
                last_bingo_cnt += 1
    cross = [[[0, 0], [1, 1], [2, 2]], [[2, 0], [1, 1], [0, 2]]]

    for a, b, c in cross:
        line = set([board[a[1]][a[0]], board[b[1]][b[0]], board[c[1]][c[0]]])
        if len(line) == 1 and CLEAR not in line:
            if FIRST in line:
                first_bingo_cnt += 1
            else:
                last_bingo_cnt += 1

    return (first_bingo_cnt, last_bingo_cnt)


def check(board):
    first_cnt = 0
    last_cnt = 0
    for y in range(3):
        for x in range(3):
            if board[y][x] == FIRST:
                first_cnt += 1
            elif board[y][x] == LAST:
                last_cnt += 1

    first_bingo, last_bingo = check_bingo(board)

    # X 차례에 O 넣은것
    if first_cnt - last_cnt > 1:
        return FALSE
    # O 차례인데 X가 한것
    if first_cnt <= last_cnt:
        return FALSE
    # 빙고가 2개
    if first_bingo == last_bingo and first_bingo != 0:
        return FALSE

    # O빙고가 터졌는데, X를 넣은것
    if first_bingo > 0 and first_cnt != last_cnt + 1:
        return FALSE
    # X빙고가 터졌는데, O을 넣은것
    if last_bingo > 0 and first_cnt != last_cnt:
        return FALSE

    return TRUE


def solution(board):
    return check(board)


answer = []
while True:
    t = input()
    if t == "end":
        break
    else:
        t_list = list(map(str, t))
        board = [t_list[:3], t_list[3:6], t_list[6:]]
        if solution(board) == 1:
            answer.append("valid")
        else:
            answer.append("invalid")
if len(answer) > 0:
    for a in answer:
        print(a)
