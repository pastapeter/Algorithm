//
//  main.swift
//  정도현_0127
//
//  Created by Jung peter on 1/26/23.
//

import Foundation

func solution(_ cap:Int, _ n:Int, _ deliveries:[Int], _ pickups:[Int]) -> Int64 {
  
  var deliveries = Array(deliveries.reversed())
  var pickups = Array(pickups.reversed())
  var dist = 0
  
  var remainOfDelivery = 0
  var remainOfPickup = 0

  for i in 0..<n {
    
    remainOfDelivery += deliveries[i]
    remainOfPickup += pickups[i]
    
    while remainOfDelivery > 0 || remainOfPickup > 0 {
      remainOfDelivery -= cap
      remainOfPickup -= cap
      dist += (n-i) * 2
    }
  }
  
  return Int64(dist)
}




