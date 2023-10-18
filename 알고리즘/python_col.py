graph = [[0, 0, 0, 0], [1, 1, 1, 1], [2, 2, 2, 2], [3, 3, 3, 3]]

for i in range(len(list(zip(*graph)))):
    print(list(zip(*graph))[i])
