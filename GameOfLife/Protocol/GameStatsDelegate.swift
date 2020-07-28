//
//  GameStatsDelegate.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import Foundation

protocol GameStatsDelegate: AnyObject {
  func showGeneration()
  func showPopulation()
  func gridUpdated()
}

public enum Patterns {
  case random
  
  // Still Lifes
  case behive
  
  // Oscillators
  case blinker
  case toad
  case beacon
  case pulsar
  case pentadecathlon
  
  // Spaceships
  case glider
}
