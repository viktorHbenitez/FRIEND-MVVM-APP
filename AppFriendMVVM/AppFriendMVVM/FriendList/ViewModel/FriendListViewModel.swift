//
//  FriendListViewModel.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation

protocol GenericModelViewProtocol {
  var onShowErrorServiceAlert: ((_ alert: RDESingleButtonAlert) -> Void)? {get set }
  var showProgressLoadingHud: Bindable<Bool> {get set}
  var serviceClientWS: ListServiceClientProtocol{get set}
}
class FriendListViewModel : GenericModelViewProtocol {
  
  /*
   TASK  VIEWMODEL
   1. Get data From API service
   2. update the Views (tableView)
   3. parse viewModelCell (show data in tableViewCells)
   4. Show loading progress
   */
  enum FriendTableViewCellType {
      case normal(cellViewModel: FriendCellViewModelProtocol)
      case error(message: String)
      case empty
  }
  
  // Bindable is the type which handles the data binding between the ViewModel and the View
  //send the data information to be shown
  // Bindables
  var friendDataCell: Bindable = Bindable([FriendTableViewCellType]())
  var onShowErrorServiceAlert: ((_ alert: RDESingleButtonAlert) -> Void)?
  var showProgressLoadingHud: Bindable = Bindable(false)
  
  var serviceClientWS: ListServiceClientProtocol
  // We have to use Dependecy Injection to get Service API client
  init(appServerClient: ListServiceClientProtocol = ListServiceClient()) {
    serviceClientWS = appServerClient
  }
  
  func getFriendFromClientService(){
    showProgressLoadingHud.value = true
    serviceClientWS.getFriends { result in
      self.showProgressLoadingHud.value = false
      switch  result{
      case .success(let friends):
      // Check is friend != 0
      // return the data from service viewModelCell
        // how retun the data from the service
        guard !friends.isEmpty else {
          self.friendDataCell.value = [.empty]
          return
        }
        self.friendDataCell.value = friends.compactMap {FriendTableViewCellType.normal(cellViewModel: $0)}
      
      case .failure(let error):
        self.friendDataCell.value = [.error(message: error?.description ?? "Loading failed, check network connection" )]
      }
      
    }
  }
  
}
