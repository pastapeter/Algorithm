import sys

input = sys.stdin.readline
sys.setrecursionlimit(1000000)

# n개 도시
# 두 도시에 길이 있을수도, 없을 수도
# 여행 경로 가능한지 확인하기?
# 여러번 방문이 가능하다? -> MST는 아닌데
# 근데 그냥 같은 부모를 가지면 되는듯?
# 여행 경로가 가능한지, 최소 weight가 될 필요없음, 여러번 방문 가능함
# 그러면 그냥 동일 부모만 가지고 있는지 확인하면댐
# 그렇다면, 그냥 사실 MST도 괜찮은겅미
# 모든 MST 구한 다음에, m개 도시가 있는지만 확인하면댐

n = int(input())
m = int(input())
nums = [i for i in range(n + 1)]
graph = []


def get_parent(a):
    if nums[a] != a:
        nums[a] = get_parent(nums[a])
    return nums[a]


def union(a, b):
    parentA = get_parent(a)
    parentB = get_parent(b)

    if parentA < parentB:
        nums[parentB] = parentA
    else:
        nums[parentA] = parentB


for y in range(n):
    graph.append(list(map(int, input().split())))

for y in range(n):
    for x in range(n):
        if graph[y][x] == 1:
            union(y + 1, x + 1)

plan = list(map(int, input().split()))

cities = []
for i in plan:
    cities.append(nums[i])
# print(nums)

if len(set(cities)) == 1:
    print("YES")
else:
    print("NO")
