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


protocol FriendCellViewModelProtocol {
  var friendItem: Friend { get }
  var fullName: String { get }
  var phonenumberText: String { get }
}

extension Friend: FriendCellViewModelProtocol{
  var friendItem: Friend {
      return self
  }
  var fullName: String {
      return firstname + " " + lastname
  }
  var phonenumberText: String {
      return phonenumber
  }
}
