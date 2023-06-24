# 구매자 n
# 할인율은 10% 20% 30% 40%

discounts = [10, 20, 30, 40]
answer = [-1, -1]


def solution(users, emoticons):
    n, m = len(users), len(emoticons)
    price_list = [0] * m

    def dfs(depth):
        global answer
        if depth == m:
            sold = 0
            cost = 0
            for i in range(n):
                temp = 0
                for j in range(m):
                    if price_list[j] >= users[i][0]:
                        temp += emoticons[j] * (100 - price_list[j]) // 100
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
            dfs(depth + 1)

    dfs(0)

    return answer
