//
//  ViewController.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 15/10/20.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

  var appServiceClient : AppServerClient = AppServerClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    executedServiceClient()
  }
  
  
  func executedServiceClient(){
    appServiceClient.getFriends { result in
      switch result{
      case .success(let friend):
        
        print(friend)
        break
      case .failure(let error):
        print(error?.description)
      }
    }
  }


}


