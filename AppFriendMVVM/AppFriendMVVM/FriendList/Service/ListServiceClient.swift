//
//  AppServerClient.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation
import Alamofire

protocol ListServiceClientProtocol {
  typealias GetFriendResult = Result<[Friend], GetFriendsFailureError>
  typealias GetFriendCompletion = (_ result: GetFriendResult) -> Void
  func getFriends(completion: @escaping  GetFriendCompletion)
  
}
class ListServiceClient: ListServiceClientProtocol {
  typealias GetFriendResult = Result<[Friend], GetFriendsFailureError>
  typealias GetFriendCompletion = (_ result: GetFriendResult) -> Void
  
  // @escaping it means it has a strong reference to every object it capture.
  func getFriends(completion: @escaping  GetFriendCompletion){
    AF.request("http://friendservice.herokuapp.com/listFriends")
      .validate()
      .responseJSON { response in
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
