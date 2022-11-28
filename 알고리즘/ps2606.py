import sys

input = sys.stdin.readline

N = int(input())
E = int(input())
graph = [[] for _ in range(N+1)]
visited = []
answer = 0


for _ in range(E):
    a, b = map(int, input().split())
    graph[a].append(b)
    graph[b].append(a)



def bfs(start):
    global answer
    global graph
    queue = [start]
    visited.append(start)
    
    while queue:
        now = queue.pop(0)

        for i in graph[now]:
            if i not in visited:
                queue.append(i)
                answer += 1
                visited.append(i)


    

def solution():
    bfs(1)


solution()
print(answer)
