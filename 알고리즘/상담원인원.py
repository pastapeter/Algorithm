from collections import deque
from itertools import combinations

mentors = []


def get_mentor(k, n, depth, mentor):
    global mentors
    if k == depth:
        if n == 0:
            mentors.append(mentor[:])
        return

    for i in range(1, n + 1):
        mentor.append(i)
        get_mentor(k, n - i, depth + 1, mentor)
        mentor.pop()


def solution(k, n, reqs):
    global mentors
    get_mentor(k, n, 0, [])
    print(mentors)
    answer = 0

    return answer


solution(
    3,
    5,
    [
        [10, 60, 1],
        [15, 100, 3],
        [20, 30, 1],
        [30, 50, 3],
        [50, 40, 1],
        [60, 30, 2],
        [65, 30, 1],
        [70, 100, 2],
    ],
)
