import sys

sys.setrecursionlimit(10**6)
input = sys.stdin.readline

# 1 245 367
# 1 -> 2 없으면 부모 45 -> 4 없으면 부모  -> 5 없으면 부모
# 중요한 것은 이진트리임
n = int(input())
tree = [[] for _ in range(n + 1)]
parent = [0] * (n + 1)
for i in range(n):
    a, b, c = map(int, input().split())
    tree[a] += [b, c]
    if b != -1:
        parent[b] = a
    if c != -1:
        parent[c] = a

answer = 0
visited = [0] * (n + 1)
visited[0] = 1
inorder_tree = []


def inorder(start):
    if tree[start][0] != -1:
        inorder(tree[start][0])
    inorder_tree.append(start)
    if tree[start][1] != -1:
        inorder(tree[start][1])


# 사실 문제는 간단하다.
# 디테일에서 조금 틀렸다.
# 1. 시간초과가 났던이유: 해당 노드의 부모를 찾을때, n를 한번 순회했다.
# 2. 해결방법은 parent 배열을 만들었다. 어차피 1노드의 부모는 1개이다.
# 3. 탈출조건에 문제가 있었다.
# 문제의 탈출조건은 중위 순회할때의 마지막노드이다.
# 그렇기 떄문에 우선적으로 중위 순회를 하고 마지막 노드를 찾아서 그 노드를 끝으로 모든 순회가
# 완료되었을떄, 탈출을 시켜야한다.
# 그래서 if start == inorder_tree[-1]
# 두번째 조건은 모든 순회가 완료되어야한다.
# 순회 판단은 visited 배열이 갑이다.
# visited 배열이 모두 다 돌았을떄 판한할 수 있다.
# 주의할점은 len(set(visited)) 을 활용하여 전부 돌았는지 확인할떄, 만약에 [0] * (n+1)
# 이것을 하였다면 visited[0] = 1 처리를 해주는 것이 좋다.


def inorder_custom(start):
    global answer
    visited[start] = 1
    if start == inorder_tree[-1] and len(set(visited)) == 1:
        return
    answer += 1
    flag = False
    if tree[start][0] == -1 and tree[start][1] == -1:
        inorder_custom(parent[start])

    else:
        if tree[start][0] != -1 and visited[tree[start][0]] == 0:
            inorder_custom(tree[start][0])
            flag = True
        if tree[start][1] != -1 and visited[tree[start][1]] == 0:
            inorder_custom(tree[start][1])
            flag = True
        if flag == False:
            inorder_custom(parent[start])


inorder(1)
inorder_custom(1)
print(answer)
