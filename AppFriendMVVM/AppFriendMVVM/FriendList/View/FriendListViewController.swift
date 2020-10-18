//
//  FriendListViewController.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import UIKit
import PKHUD
class FriendListViewController: UITableViewController {
  
  var friendViewModel: FriendListViewModel = FriendListViewModel()
  
  lazy var rightButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add,
                                 target: self,
                                 action: #selector(addNewFriend))
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.rightBarButtonItem = rightButton
    
    bindViewModel()
    friendViewModel.getFriendFromClientService()
  }
  
  @objc
  func addNewFriend(){
    presentSingleButtonDialog(alert: RDESingleButtonAlert())
  }
  
  func bindViewModel(){
    friendViewModel.friendDataCell.bindAndFire { [weak self] _ in
      switch self?.friendViewModel.friendDataCell.value.first {
      case .normal:
        self?.tableView.reloadData()
      case .error:
        break
      default:
        break
      }
    }
    
    friendViewModel.onShowErrorServiceAlert = {[weak self] alert in
      self?.presentSingleButtonDialog(alert: alert)
    }
    
    friendViewModel.showProgressLoadingHud.bind { [weak self] visible in
      if let `self` = self {
        self.presentHUD(visible)
      }
    }
  }
}

extension FriendListViewController {
  public override func tableView(_ tableView: UITableView,
                                 numberOfRowsInSection section: Int) -> Int {
    return friendViewModel.friendDataCell.value.count
  }
  
  public override func tableView(_ tableView: UITableView,
                                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch friendViewModel.friendDataCell.value[indexPath.row] {
    case .normal(let viewModel):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell") as? FriendTableViewCell else {
        return UITableViewCell()
      }
      
      cell.viewModel = viewModel
      return cell
    case .error(let message):
      let cell = UITableViewCell()
      cell.isUserInteractionEnabled = false
      cell.textLabel?.text = message
      return cell
    case .empty:
      let cell = UITableViewCell()
      cell.isUserInteractionEnabled = false
      cell.textLabel?.text = "No data available"
      return cell
    }
  }
  
  public override func tableView(_ tableView: UITableView,
                                 canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView,
                          heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}
extension FriendListViewController: SingleButtonDialogPresenter{}
