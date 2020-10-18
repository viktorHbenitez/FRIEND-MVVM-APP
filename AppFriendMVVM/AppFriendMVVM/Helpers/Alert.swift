//
//  Alert.swift
//  Friends
//
//  Created by Jussi Suojanen on 09/01/17.
//  Copyright © 2017 Jimmy. All rights reserved.
//
import UIKit

struct AlertAction {
    let buttonTitle: String = "Aceptar"
    let handler: (() -> Void)?
}

struct RDESingleButtonAlert {
    let title: String = "App ELektra"
    let message: String? = "App mensaje Elektra"
    let action: AlertAction = AlertAction(handler: nil)
}
