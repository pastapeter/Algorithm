def solution():
    num = int(input())
    arr = [0 for x in range(num+1)]
    if num == 1:
        return 1
    else :
        arr[1] = 1
        arr[2] = 3
        if num >= 3 :
            for i in range(3, num+1):
                arr[i] = arr[i-1] + 2*arr[i-2]
    return arr[num] % 10007

print(solution())
