# 누적합
# 누적합 2차원배열일 경우
# 기울기로 계산하는 느낌임
# 감소하는 혹은 증가하는 기울기를 알아서
# 모든 skill의 반복문을 다 확인해서
# 출발점의 기울기를 확인해서 더하는 느낌?
# 누적합은 연속된 덧셈이나 연속된 뺄셈일때 가능함 ( 이 개념을 알았다면? 사실 괜찮은 문제였을수도? )


def solution(board, skill):
    answer = 0
    m, n = len(board), len(board[0])
    # 첫점과 끝점을 위해서 n+1, m+1로 acc 의 배열확인
    acc = [([0] * (n + 1)) for _ in range(m + 1)]

    for s in skill:
        types = 0
        if s[0] == 1:
            types = -1
        elif s[0] == 2:
            types = 1
        startY, startX, endY, endX = s[1], s[2], s[3], s[4]
        degree = s[5]

        # 시작 지점에 +로 주어졌다면
        # 시작 지점과 가로, 세로로 연결된 곳은 - 로
        acc[startY][startX] += degree * types
        acc[startY][endX + 1] -= degree * types
        acc[endY + 1][startX] -= degree * types
        acc[endY + 1][endX + 1] += degree * types

    # x축을 먼저 누적합 계산
    for j in range(m):
        for i in range(1, n):
            acc[j][i] += acc[j][i - 1]

    # y축 누적합 계산
    for i in range(n):
        for j in range(1, m):
            acc[j][i] += acc[j - 1][i]

    for j in range(m):
        for i in range(n):
            board[j][i] += acc[j][i]
            if board[j][i] > 0:
                answer += 1

    return answer
