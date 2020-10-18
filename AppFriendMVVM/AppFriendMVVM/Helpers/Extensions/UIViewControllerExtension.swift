//
//  UIViewControllerExtension.swift
//  Friends
//
//  Created by Jussi Suojanen on 22/06/2017.
//  Copyright © 2017 Jimmy. All rights reserved.
//

import UIKit
import PKHUD
protocol SingleButtonDialogPresenter {
    func presentSingleButtonDialog(alert: RDESingleButtonAlert)
}

extension SingleButtonDialogPresenter where Self: UIViewController {
    func presentSingleButtonDialog(alert: RDESingleButtonAlert) {
        let alertController = UIAlertController(title: alert.title,
                                                message: alert.message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: alert.action.buttonTitle,
                                                style: .default,
                                                handler: { _ in alert.action.handler?() }))
        self.present(alertController, animated: true, completion: nil)
    }
  
  
  func presentHUD(_ visible: Bool){
    PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
    visible ? PKHUD.sharedHUD.show(onView: self.view) : PKHUD.sharedHUD.hide()
  }
  
  
}
