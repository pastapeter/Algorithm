def solution(prices): 
    answer = []    
    for index in range(len(prices)):
        count = 0
        for index2 in range(index+1, len(prices)):
            count += 1
            if prices[index] > prices[index2]:
                break
        answer.append(count)
        
    return answer