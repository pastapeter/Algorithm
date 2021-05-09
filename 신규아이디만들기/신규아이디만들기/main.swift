import Foundation

func solution(_ new_id:String) -> String {

    var id  = new_id.map{$0}
    var char = 0
    while(char < id.count){
        if(id[char].isUppercase){
            id[char] = Character(id[char].lowercased())
        }
        if(!id[char].isLetter && !id[char].isNumber){
            if(id[char] == "-" || id[char] == "_" || id[char] == "."){
                char += 1
                continue
            }
            id.remove(at: char)
            continue
        }
        char += 1
    }
    
    char = 0
    var count = 0
    while(char < id.count){
        if(id[char] == "."){
            count += 1
        } else{
            count = 0
        }
        if(count > 1){
            id.remove(at: char-1)
            char = 0
            count = 0
            continue
        }
        char += 1
    }
    
    if(id[0] == "."){id.remove(at: 0)}
    if(id.last == "."){id.removeLast()}
    
    if(id.count == 0){
        id.append("a")
    }
    
    var result = [Character]()
    
    if(id.count > 15){
        for i in 0..<15 {
            result.append(id[i])
        }
    } else {
        result = id
    }
    if(result.last == "."){result.removeLast()}
    while(result.count < 3){
        result.append(result.last!)
    }
    return String(result)
}
