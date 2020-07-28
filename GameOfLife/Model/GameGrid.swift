//
//  GameGrid.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

class GameGrid: NSObject {
  
  let gridSize: Int
  var cells: [Cell] = []
  weak var delegate: GameStatsDelegate?
  
  var generation: Int = 0
  var population: Int { return cells.filter { $0.state == .alive }.count }
  
  public init(gridSize: Int) {
    self.gridSize = gridSize
    
    // Create grid ttt
    for y in 0..<self.gridSize {
      for x in 0..<self.gridSize {
        let cell = Cell(x: x, y: y)
        cells.append(cell)
      }
    }
    super.init()
    
  }
}
