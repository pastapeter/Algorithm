# 구매자 n
# 할인율은 10% 20% 30% 40%

discounts = [10, 20, 30, 40]
answer = [-1, -1]

# 어쨋든 중요한 것은
# 읽었을때, 어떤 알고리즘이 필요한것인지?
# 완탐이면 걍 dfs로 가자


def solution(users, emoticons):
    n, m = len(users), len(emoticons)
    # 각각의 이모티콘 할인 퍼센트
    price_list = [0] * m

    def dfs(depth):
        global answer
        if depth == m:
            sold = 0
            cost = 0
            for i in range(n):
                temp = 0
                for j in range(m):
                    # 이모티콘 퍼센트가 유저의 정한 퍼센트보다 크면
                    if price_list[j] >= users[i][0]:
                        # 사야지
                        temp += emoticons[j] * (100 - price_list[j]) // 100
                # 다 사고 보니깐
                if temp >= users[i][1]:
                    sold += 1
                else:
                    cost += temp
            if sold > answer[0] or sold == answer[0] and cost > answer[1]:
                answer = [sold, cost]
            return
        for percent in discounts:
            # 이렇게 각각 price_list 정해준다.
            price_list[depth] = percent
            # price_list가 바뀌고
            dfs(depth + 1)
            # 해당 조건으로 다 돌고 다시 포문돌아서 완탐시행

    dfs(0)

    return answer
