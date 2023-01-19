function solution(game) {
  var answer = 10000000007
  function DFS(i, n, games, arrays) {
    if (i === n) {
      let [tot, cnt] = [0, 0]
      for (const array of arrays) {
        if (array.length === 0) break
        for (let [d, r] of array) {
          tot += d * (1 - r / 100)
          cnt += 1
        }
      }
      if (cnt === n) {
        if (answer > tot) answer = tot
      }
    }
    else {
      for (let j = 0; j < n; j++) {
        let [p, d, r] = games[i]
        
        if (j === d) arrays[j].push([p, r])
        else arrays[j].push([p, 0])
        DFS(i + 1, n, games, arrays)
        arrays[j].pop()
      }
    }
  }
  let n = game.length
  let arrays = new Array()
  for (let i = 0; i < n; i++) {
    let arr = new Array()
    arrays.push(arr)
  }
  DFS(0, n, game, arrays)
  return answer;
}