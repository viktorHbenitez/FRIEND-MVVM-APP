//
//  AppServerClient.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation
import Alamofire

class AppServerClient {
  
  // MARK: - GetFriends
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
  
  typealias GetFriendResult = Result<[Friend], GetFriendsFailureError>
  typealias GetFriendCompletion = (_ result: GetFriendResult) -> Void
  
  // @escaping it means it has a strong reference to every object it capture.
  func getFriends(completion: @escaping  GetFriendCompletion){
    AF.request("http://friendservice.herokuapp.com/listFriends").validate().responseJSON { response in
      switch response.result{
      case .success:
        do{
          guard let data = response.data else {
            completion(.failure(.noData))
            return
          }
          let friends = try JSONDecoder().decode([Friend].self, from: data)
          completion(.success(payload: friends))
        } catch{
          completion(.failure(.failed))
          
        }
      case .failure:
        if let statusCode = response.response?.statusCode,
            let reason = GetFriendsFailureError(rawValue: statusCode) {
              completion(.failure(reason))
        }
        completion(.failure(.failed))
      }
      
    }
  }
}
