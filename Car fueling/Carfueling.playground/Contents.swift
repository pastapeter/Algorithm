var start = 0
let limit = 400
var arrive = 950
let refills = [200, 375, 550, 750]
var choices = [Int]()
var result = [Int]()

while(start+limit < arrive){
    for refill in refills{
        if(refill >=  start && refill <= limit+start){
            choices.append(refill)
        }
    }
    let choice = choices.max() ?? 0
    result.append(choice)
    start = choice
}
print(result)

