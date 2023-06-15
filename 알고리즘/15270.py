import sys

input = sys.stdin.readline

n, m = map(int, input().split())
graph = []

for i in range(m):
    u, v = map(int, input().split())
    graph.append((u, v))


def solution():
    visited = [False] * (n + 1)
    answer = dfs(visited, 0)
    answer += 1 if n > answer else 0  # 만약에 n보다 answer가 작으면 가운데 로봇춤추는 애 넣어주고
    # 그렇지않으면 안넣어준다.
    print(answer)


def dfs(visited, cur):
    if cur == m:  # 이건 끝까지 M 을 돌아봤을때이다.
        return 0
    result = 0
    for i in range(cur, m):  # m을 다돌아보는데, 기존꺼것은 안본다.
        a, b = graph[i]
        if not visited[a] and not visited[b]:  # 둘다 false면 일단 이친구들은 방문하지 않은거
            visited[a], visited[b] = True, True  # 올리고
            result = max(result, dfs(visited, i + 1) + 2)  # 계산하고
            visited[a], visited[b] = False, False  # 내리는거 반복
    return result


# 단순한 dfs코드였고, 나도 짰는데
# 시간초과가 났던 이유
# 그냥 되는애들 2개 뽑아서 나중에 알아서 서게 하면되는데
# 세우고 양옆비교하고 세우고 양옆비교하면서 필요없는 N^2이 들어감

solution()
