import sys

sys.setrecursionlimit(10**8)
input = sys.stdin.readline

directory = {}
file_num = 0


def go(target, kinds):
    global file_num
    if target not in directory:
        return
    for title, isFile in directory[target]:
        if isFile == 0:
            if title not in kinds:
                kinds.add(title)
            file_num += 1
        else:
            go(title, kinds)


n, m = map(int, input().split())

for i in range(n + m):
    parent, child, id = input().rstrip().split()
    if parent not in directory:
        directory[parent] = []
        directory[parent].append([child, int(id)])
    else:
        directory[parent].append([child, int(id)])

q = int(input())

for i in range(q):
    query = input().rstrip().split("/")
    _set = set()
    file_num = 0
    go(query[-1], _set)

    print(len(_set), file_num)
