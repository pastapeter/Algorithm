import sys

sys.setrecursionlimit(10**8)
input = sys.stdin.readline

directory = {}
file_num = 0

# 파일 디렉토리는 재귀, 트리형식이기 때문에
# 그에 맞춰서 짜는 것이 좋다.
# 네이버 부스트캠프형의 문제이다.
# 재귀방식으로 내려가면서, 하나의 폴더를 확인한다
# 파일일 경우, Tracking 해주고
# 폴더일 경우, 내려간다.
# 내려가면서 파일 Tracking하는 set을 넘겨주기 때문에
# 하나의 폴더의 하위폴더의 모든 파일을 찾을 수 있다.


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

# 여기서 폴더 1 안에 파일과 폴더를 모두 저장하지만
# 형식을 같이 저장하고 있기 때문에
# 재귀로 파고들때 이 형식만 잘 파악해주면 된다.
# 어렵지 않은문제임

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
