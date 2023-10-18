import sys

input = sys.stdin.readline

# 복선 노선이 있음
# 상하행 열차 접근
# 열차가 없으면 차단기가 올라감
# 열차가 있으면 차단기가 내려감
# 열차가 접근하면 40초 뒤에는 빠져나감
# 11:10:15 ~ 11:10:55
# 시간을 초로 바꾸는게 좋을듯
# 같은 방향의 열차 간격은 60초 이상임

C, H = map(int, input().split())
c_list = []
h_list = []
for _ in range(C):
    # 1분: 60초, 1시간 3600초
    h, m, s = map(int, input().split(":"))
    temp = h * 3600 + m * 60 + s
    c_list.append([temp + 1, temp + 40])

for _ in range(H):
    h, m, s = map(int, input().split(":"))
    temp = h * 3600 + m * 60 + s
    h_list.append([temp + 1, temp + 40])

line = [1 for _ in range(86400)]

for a, b in c_list:
    for i in range(a, b + 1):
        line[i] = 0

for a, b in h_list:
    for i in range(a, b + 1):
        line[i] = 0

print(sum(line))
