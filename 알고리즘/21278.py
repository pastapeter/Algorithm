# 2개 매장
# 양방향 그래프
# 접근성의 합 최소화
# 건물 조합이 여러개면, 건물번호 중 작은게 더 작을 수록
# 작은 번호가 같다면 큰 번호가 더 작을 수록
from itertools import combinations
from functools import cmp_to_key
import heapq

n, m = map(int, input().split())
graph = [[] for i in range(n + 1)]


# 다익스트라
def path_planning(starts):
    d = [1e9] * (n + 1)
    for start in starts:
        q = []
        heapq.heappush(q, (0, start))
        d[start] = 0
        while q:
            dist, now = heapq.heappop(q)
            if d[now] < dist:
                continue

            for i in graph[now]:
                cost = dist + 1
                if cost < d[i]:
                    d[i] = cost
                    heapq.heappush(q, (cost, i))
    return d


def check_start(dist):
    answer = []
    for i in range(len(dist)):
        if dist[i] == 0:
            answer.append(i + 1)
    return answer


def compare(a, b):
    lhs = check_start(a)
    rhs = check_start(b)

    if lhs[0] == rhs[0]:
        return lhs[1] < rhs[1]
    return lhs[0] < rhs[0]


def solution():
    for i in range(m):
        a, b = map(int, input().split())
        graph[a].append(b)
        graph[b].append(a)
    locations = [i + 1 for i in range(n)]
    combis = combinations(locations, 2)
    dists = []
    dist_sums = []

    for combi in combis:
        dist = path_planning(list(combi))
        for i in range(1, n + 1):
            dist[i] = dist[i] * 2
        dists.append(dist[1:])

    for dist in dists:
        dist_sums.append(sum(dist))

    min_sum = min(dist_sums)
    answers = []
    for i, val in enumerate(dist_sums):
        if val == min_sum:
            answers.append(dists[i])

    if len(answers) == 1:
        print(*check_start(answers[0]), sum(answers[0]))
    else:
        answers.sort(key=cmp_to_key(compare))
        print(*check_start(answers[0]), sum(answers[0]))


solution()
