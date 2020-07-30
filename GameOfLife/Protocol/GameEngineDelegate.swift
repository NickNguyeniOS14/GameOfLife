//
//  GameStatsDelegate.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import Foundation

protocol GameEngineDelegate: AnyObject {
  func didUpdateGeneration()
  func didUpdatePopulation()
  func didUpdateGrid()
}

