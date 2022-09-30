num  = int(input())
matrix = [[' ' for i in range(num)] for j in range(num)]

def printStar(N, x, y):
    if N == 1:
        matrix[y][x] = '*'
        return
    
    val = N//3

    for i in range(3):
        for j in range(3):
            if i == 1 and j == 1:
                continue
            else:
                printStar(val, x+j*val, y+i*val)

printStar(num, 0, 0)

for i in range(num):
    for j in range(num):
        print(matrix[i][j], end=' ')
    print()

