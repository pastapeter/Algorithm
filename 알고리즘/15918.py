# 1이상 n이하 자연수 2개씩
# 두 개의 1사이에는 정확히 1개의 수가 있음
# 3 1 2 1 3 2
# x번째 수 y번째 수가 같다.
n, x, y = map(int, input().split())
arr = [0] * (2 * n + 1)
used = [False] * (n + 1)

# 이렇게 할 수 있는 이유는 x번째수와 y번째수가 같고, 두개 안에 특정 숫자가 있으려면
# y-x-1이 3인 경우, 1,5는 3이라는 것임
used[y - x - 1] = True
arr[x] = y - x - 1
arr[y] = y - x - 1

answers = 0
answer = 0
# x,y 가 같다


def dfs2(depth, answer, visited):
    global answers
    if depth == 2 * n:
        if answer[y - 1] == answer[x - 1]:
            answers += 1
        return

    for i in range(n):
        if visited[i + 1] == 0:
            answer[depth] = i + 1
            visited[i + 1] = 1
            dfs2(depth + 1, answer, visited)
            answer[depth] = 0
            visited[i + 1] = 0
        elif visited[i + 1] == 1:
            if depth - (i + 1) - 1 >= 0 and answer[depth - (i + 1) - 1] == i + 1:
                answer[depth] = i + 1
                visited[i + 1] = 2
                dfs2(depth + 1, answer, visited)
                answer[depth] = 0
                visited[i + 1] = 1


# 답지의 풀이법
# arr[


def dfs(depth):
    global answer
    if depth == 2 * n + 1:
        answer += 1
        return
    if arr[depth] != 0:
        dfs(depth + 1)
    else:
        for i in range(1, len(used)):
            if not used[i] and depth + i + 1 < 2 * n + 1 and arr[depth + i + 1] == 0:
                used[i] = True
                arr[depth] = i
                arr[depth + i + 1] = i
                dfs(depth + 1)
                used[i] = False
                arr[depth] = 0
                arr[depth + i + 1] = 0


dfs(1)
print(answer)
