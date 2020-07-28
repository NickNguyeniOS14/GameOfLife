//
//  Cell.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import Foundation

public enum State {
  case dead
  case alive
}

public class Cell: NSObject {
  public let x: Int
  public let y: Int
  public var state: State
  
  public init(x: Int, y: Int, state: State = .dead) {
    self.x = x
    self.y = y
    self.state = state
  }
}
