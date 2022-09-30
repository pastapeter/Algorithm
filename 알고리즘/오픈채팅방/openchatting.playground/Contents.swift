import Foundation

struct User {
    var uid: String
    var nick: String
}

enum Command: String {
  case enter = "님이 들어왔습니다."
  case leave = "님이 나갔습니다."
  case change = ""
}

func solution(_ record:[String]) -> [String] {
  var result: [(command: String, user: User)] = []
  var realResult: [String] = []
  var nick: [String: String] = [:]

  for record in record {
    let commandAndUser = record.components(separatedBy: " ")
    let command = commandAndUser[0]
    
    switch command {
    case "Enter":
      result.append((command: command, user: User(uid: commandAndUser[1], nick: commandAndUser[2])))
      nick.updateValue(commandAndUser[2], forKey: commandAndUser[1])
    case "Change":
      result.append((command: command, user: User(uid: commandAndUser[1], nick: commandAndUser[2])))
      nick[commandAndUser[1]] = commandAndUser[2]
    case "Leave":
      result.append((command: command, user: User(uid: commandAndUser[1], nick: nick[commandAndUser[1]]!)))
    default:
      break
    }

  }
  
  for (index, _) in result.enumerated() {
    result[index].user.nick = nick[result[index].user.uid]!
  }
  
  for result in result {
    switch result.command {
    case "Enter":
      realResult.append("\(result.user.nick)\(Command.enter.rawValue)")
    case "Leave":
      realResult.append("\(result.user.nick)\(Command.leave.rawValue)")
    case "Change":
      break
    default:
      break
    }
  }

    return realResult
}

print(solution(["Enter uid1234 Muzi", "Enter uid4567 Prodo","Leave uid1234","Enter uid1234 Prodo","Change uid4567 Ryan"]))
