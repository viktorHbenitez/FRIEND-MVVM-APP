//
//  Friend.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation

struct Friend: Codable {
  let firstname: String
  let lastname: String
  let phonenumber: String
  let idFriend: Int
  
  private enum CodingKeys: String, CodingKey{
    case firstname
    case lastname
    case phonenumber
    case idFriend = "id"
  }
}
