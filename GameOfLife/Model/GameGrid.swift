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
    self.userExamplePattern(pattern: .random)
  }
  
  
  private func randomizeGrid() {
    cells.forEach {
      let randomState = Int.random(in: 0...5)
      $0.state = randomState == 0 ? .alive : .dead
    }
  }
  
  public func clearGrid() {
    cells.forEach { $0.state = .dead }
    generation = 0
    notifyDelegate()
  }
  
  
  public func userExamplePattern(pattern: Patterns = .glider) {
    clearGrid()
    
    switch pattern {
      case .random:
        randomizeGrid()
      case .pulsar:
        // Row 1
        cellAt(x: 6, y: 2).state = .alive
        cellAt(x: 6, y: 3).state = .alive
        cellAt(x: 6, y: 4).state = .alive
        cellAt(x: 7, y: 4).state = .alive
        
        cellAt(x: 12, y: 2).state = .alive
        cellAt(x: 12, y: 3).state = .alive
        cellAt(x: 12, y: 4).state = .alive
        cellAt(x: 11, y: 4).state = .alive
        
        // Row 2
        cellAt(x: 2, y: 6).state = .alive
        cellAt(x: 3, y: 6).state = .alive
        cellAt(x: 4, y: 6).state = .alive
        cellAt(x: 4, y: 7).state = .alive
        
        cellAt(x: 7, y: 6).state = .alive
        cellAt(x: 8, y: 6).state = .alive
        cellAt(x: 8, y: 7).state = .alive
        cellAt(x: 6, y: 7).state = .alive
        cellAt(x: 6, y: 8).state = .alive
        cellAt(x: 7, y: 8).state = .alive
        
        cellAt(x: 10, y: 6).state = .alive
        cellAt(x: 11, y: 6).state = .alive
        cellAt(x: 10, y: 7).state = .alive
        cellAt(x: 12, y: 7).state = .alive
        cellAt(x: 11, y: 8).state = .alive
        cellAt(x: 12, y: 8).state = .alive
        
        cellAt(x: 14, y: 6).state = .alive
        cellAt(x: 15, y: 6).state = .alive
        cellAt(x: 16, y: 6).state = .alive
        cellAt(x: 14, y: 7).state = .alive
        
        // Row 3
        cellAt(x: 2, y: 12).state = .alive
        cellAt(x: 3, y: 12).state = .alive
        cellAt(x: 4, y: 12).state = .alive
        cellAt(x: 4, y: 11).state = .alive
        
        cellAt(x: 6, y: 10).state = .alive
        cellAt(x: 7, y: 10).state = .alive
        cellAt(x: 6, y: 11).state = .alive
        cellAt(x: 8, y: 11).state = .alive
        cellAt(x: 7, y: 12).state = .alive
        cellAt(x: 8, y: 12).state = .alive
        
        cellAt(x: 11, y: 10).state = .alive
        cellAt(x: 12, y: 10).state = .alive
        cellAt(x: 12, y: 11).state = .alive
        cellAt(x: 10, y: 11).state = .alive
        cellAt(x: 10, y: 12).state = .alive
        cellAt(x: 11, y: 12).state = .alive
        
        cellAt(x: 14, y: 11).state = .alive
        cellAt(x: 14, y: 12).state = .alive
        cellAt(x: 15, y: 12).state = .alive
        cellAt(x: 16, y: 12).state = .alive
        
        // Row 4
        cellAt(x: 6, y: 14).state = .alive
        cellAt(x: 6, y: 15).state = .alive
        cellAt(x: 6, y: 16).state = .alive
        cellAt(x: 7, y: 14).state = .alive
        
        cellAt(x: 12, y: 14).state = .alive
        cellAt(x: 12, y: 15).state = .alive
        cellAt(x: 12, y: 16).state = .alive
        cellAt(x: 11, y: 14).state = .alive
      default:
        break
    }
    generation = 0
    notifyDelegate()
    
  }
  
  private func cellAt(x: Int, y: Int) -> Cell {
    var absolutePosition: Int
    // 3,2 on 25 x 25 grid
    absolutePosition = (y * gridSize) + x
    return cells[absolutePosition]
    
  }
  
  func cellCoordinates(index: Int) -> (x: Int, y: Int) {
    var y = 0
    var x = 0
    
    y = index / gridSize
    x = index - (y * gridSize)
    return (x,y)
    
  }
  
  func cellTapped(at index: Int) {
    if cells[index].state == .alive {
      cells[index].state = .dead
    } else {
      cells[index].state = .alive
    }
    notifyDelegate()
  }
  
  func performGameTurn() {
    var index = 0
    var cellsToKill: [Cell] = []
    var cellsToBirth: [Cell] = []
    
    
    for cell in cells {
      var count = 0
      let coordinates = cellCoordinates(index: index)
      
      // West
      if coordinates.x != 0 {
        if cellAt(x: coordinates.x - 1, y: coordinates.y).state == .alive {
          count += 1
        }
      }
      // North West
      if coordinates.x != 0 && coordinates.y != 0 {
        if cellAt(x: coordinates.x - 1, y: coordinates.y - 1).state == .alive {
          count += 1
        }
      }
      
      // North
      if coordinates.y != 0 {
        if cellAt(x: coordinates.x, y: coordinates.y - 1).state == .alive {
          count += 1
        }
      }
      // North East
      if coordinates.x < (gridSize - 1) && coordinates.y != 0 {
        if cellAt(x: coordinates.x + 1, y: coordinates.y - 1).state == .alive {
          count += 1
        }
      }
      
      // East
      if coordinates.x < (gridSize - 1) {
        if cellAt(x: coordinates.x + 1, y: coordinates.y).state == .alive {
          count += 1
        }
      }
      
      // South East
      if coordinates.x < (gridSize - 1) && coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x + 1, y: coordinates.y + 1).state == .alive {
          count += 1
        }
      }
      
      // South
      if coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x, y: coordinates.y + 1).state == .alive {
          count += 1
        }
      }
      
      // South West
      if coordinates.x != 0 && coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x - 1, y: coordinates.y + 1).state == .alive {
          count += 1
        }
      }
      
      if cell.state == .alive {
        if count < 2 || count > 3 {
          cellsToKill.append(cell)
        }
      } else { // cell.state == .dead
        if count == 3 {
          cellsToBirth.append(cell)
        }
      }
      index += 1
      
    }
    cellsToKill.forEach { $0.state = .dead }
    cellsToBirth.forEach { $0.state = .alive }
    generation += 1
    notifyDelegate()
  }
  
  private func notifyDelegate() {
    delegate?.didUpdateGeneration()
    delegate?.didUpdatePopulation()
    delegate?.didUpdateGrid()
  }
}
