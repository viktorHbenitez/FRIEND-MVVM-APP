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
