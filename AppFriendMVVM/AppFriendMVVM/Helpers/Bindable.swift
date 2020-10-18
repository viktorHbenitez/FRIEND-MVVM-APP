//
//  Bindable.swift
//  AppFriendMVVM
//
//  Created by Victor Hugo Benitez Bosques on 16/10/20.
//

import Foundation

// MARK: - Bindable is just a simple way to start observing a value for changes. It is implemented using an observer pattern.
class Bindable<T> {
  
  // Closure to send the data to the view
  // function that takes a Generic type as a parameter which means that it can be anything.
  typealias Listener = ((T) -> Void)
  var listener: Listener?
  
  // Store property will invoke closure
  // Every time the value is changed listener is informed.
  var value: T {
    didSet {
      listener?(value)
    }
  }
  
  init(_ genericValue: T) {
    self.value = genericValue
  }
  
  // bind or send the information
  func bind(_ listener: Listener?) {
    self.listener = listener
  }
  
  // bind and fire
  func bindAndFire(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
/*
 The difference between bind & bindAndFire, is that bindAndFire also returns the starting value of the Bindable while bind only returns the value the first time it changes.
 */
