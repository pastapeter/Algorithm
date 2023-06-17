import sys

input = sys.stdin.readline
sys.setrecursionlimit(1000000)

# n+1개의 집합이 있다
# 두 원소가 같은 집합에 포함되어있는지 확인
# 부모가 같으면 된다.
# 유니온 파인드


n, m = map(int, input().split())
nums = [i for i in range(n + 1)]


# 0 1 1 1 4 5
def get_parent(a):
    parent = nums[a]
    if parent != a:
        nums[a] = get_parent(parent)
    return nums[a]


def union(a, b):
    parentA = get_parent(a)
    parentB = get_parent(b)
    if parentA < parentB:
        nums[parentB] = parentA
    else:
        nums[parentA] = parentB


for i in range(m):
    command, a, b = map(int, input().split())
    if command == 0:
        union(a, b)
    else:
        if get_parent(a) == get_parent(b):
            print("YES")
        else:
            print("NO")
