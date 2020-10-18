//
//  AppServerClient+Extension.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation
// Raname native Result<> to get allowed nil value
enum Result<T, U: Error> {
  case success(payload: T)
  case failure(U?)
}
enum EmptyResult<U: Error> {
  case success
  case failure(U?)
}

enum GetFriendsFailureError: Int, Error, CustomStringConvertible {
  case noData = -1
  case unAuthorized = -2
  case notFound = -3
  case unabletoDecode = -4
  case failed = -5
  
  var description: String{
    switch self {
    case .noData:
      return "Response returned with no data to decode."
    case .unAuthorized:
      return "You need to be authenticated first."
    case .notFound:
      return "Networking request not found."
    case .unabletoDecode:
      return "We could not decode the respone."
    case .failed:
      return "Network request failed."
    }
  }
  
}
