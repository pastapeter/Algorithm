//
//  MessageLabelDelegate.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation

protocol MessageLabelDelegate: AnyObject {
  
  func didSelectDate(_ date: Date)
  
  func didSelectURL(_ url: URL)
  
  func didSelectTransitInformation(_ transitInformation: [String: String])
  
  func didSelectMention(_ mention: String)
  
  func didSelectHashtag(_ hashtag: String)
  
}

extension MessageLabelDelegate {

    func didSelectDate(_ date: Date) {}

    func didSelectURL(_ url: URL) {}
    
    func didSelectTransitInformation(_ transitInformation: [String: String]) {}

    func didSelectMention(_ mention: String) {}

    func didSelectHashtag(_ hashtag: String) {}


}
