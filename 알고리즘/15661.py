import sys
from itertools import combinations, permutations

input = sys.stdin.readline

n = int(input())
players = [i for i in range(n)]
s = []
for i in range(n):
    s.append(list(map(int, input().split())))
answer = 1e9
visited = [0 for _ in range(n)]


def dfs(depth):
    if depth == n:
        find_best_score()
        return
    visited[depth] = 1
    dfs(depth + 1)
    visited[depth] = 0
    dfs(depth + 1)


# 완전탐색용인데,
def dfs2(start, link, depth):
    # depth를 통해서 종료조건을 잡는 것이 중요하다
    if depth == len(players):
        if len(start) > 0 and len(link) > 0:
            score(start, link)
        return

    player = players[depth]
    # start 팀에 이 플레이어를 넣거나
    dfs2(start + [player], link, depth + 1)
    # link 팀에 이 플레이어를 넣거나이디ㅏ.
    dfs2(start, link + [player], depth + 1)


# 처음에 나는 2개씩 찾아서 더해야하는 줄 알았음
# 짝을 맞추어서
# 그런게 그게 아님
# 그냥 그냥 모든 조합을 전부 더하는 거였다.
# 그렇게 되면 그냥 기존 코드에서 조합 만들어서 더해주면 되는 것이었다.
def find_best_score():
    global answer
    start_int = 0
    link_int = 0
    for i in range(n):
        for j in range(n):
            if visited[i] and visited[j]:
                start_int += s[i][j]
            elif not visited[i] and not visited[j]:
                link_int += s[i][j]

    diff = abs(start_int - link_int)
    answer = min(answer, diff)


def score(start, link):
    start_int = 0
    link_int = 0
    global answer
    for start_tuple in list(permutations(start, 2)):
        start_int += s[start_tuple[0]][start_tuple[1]]
    for link_tuple in list(permutations(link, 2)):
        link_int += s[link_tuple[0]][link_tuple[1]]

    diff = abs(start_int - link_int)
    answer = min(answer, diff)


# dfs(0)
dfs2([], [], 0)
print(answer)
