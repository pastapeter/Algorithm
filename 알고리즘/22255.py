import sys
import heapq

input = sys.stdin.readline

dx = [-1, 1, 0, 0]
dy = [0, 0, 1, -1]
DIR = [[0, 1, 2, 3], [2, 3], [0, 1]]

n, m = map(int, input().split())
sy, sx, ey, ex = map(int, input().split())
sy -= 1
sx -= 1
ey -= 1
ex -= 1
board = []
for _ in range(n):
    board.append(list(map(int, input().split())))

# 다익스트라인지는 알고 있었다.
# 3차원인것까지도 알고 있었는데,
# 좀 달랐던 것은 난 방향 기반으로 4개를 정의했다면
# 방향기반과 차이가 있다면
# 방향기반은 뭐랄까 방향을 타고 이 x,y로 왔다면? 을 생각하는 것이고
# 3방향은 cnt 가 3일때, a -> b로 온경우를 의미한다.
# 3차원까지는 생각나는데, 좀 어려운것같긴하네
# 이것도 사실 좀 이제 유형화된것같기도하다


def dijkstra():
    dist = [[[1e9 for _ in range(3)] for _ in range(m)] for _ in range(n)]
    dist[sy][sx][1] = 0
    pq = []
    heapq.heappush(pq, [0, 1, sy, sx])

    while pq:
        cur_cost, cur_cnt, cy, cx = heapq.heappop(pq)
        if dist[cy][cx][cur_cnt] < cur_cost:
            continue

        for i in DIR[cur_cnt % 3]:
            nx = cx + dx[i]
            ny = cy + dy[i]

            if nx < 0 or nx >= m or ny < 0 or ny >= n or board[ny][nx] == -1:
                continue
            next_cost = board[ny][nx]
            next_cnt = (cur_cnt + 1) % 3

            if dist[ny][nx][next_cnt] > next_cost + cur_cost:
                dist[ny][nx][next_cnt] = next_cost + cur_cost
                heapq.heappush(pq, [next_cost + cur_cost, next_cnt, ny, nx])
    answer = min(dist[ey][ex])
    if answer == 1e9:
        return -1
    else:
        return answer


answer = dijkstra()
print(answer)
