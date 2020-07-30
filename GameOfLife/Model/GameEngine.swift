//
//  GameGrid.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

class GameEngine: NSObject {
  
  let gridSize: Int
  var cells: [Cell] = []
  weak var delegate: GameStatsDelegate?
  var generation: Int = 0
  var population: Int { return cells.filter { $0.state == .alive }.count }
  
  public init(gridSize: Int) {
    self.gridSize = gridSize
    
    
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
        
      case .glider:
        cellAt(x: 3, y: 2).state = .alive
        cellAt(x: 4, y: 3).state = .alive
        cellAt(x: 4, y: 4).state = .alive
        cellAt(x: 3, y: 4).state = .alive
        cellAt(x: 2, y: 4).state = .alive
      case .behive:
        cellAt(x: 3, y: 2).state = .alive
        cellAt(x: 4, y: 2).state = .alive
        
        cellAt(x: 2, y: 3).state = .alive
        cellAt(x: 5, y: 3).state = .alive
        
        cellAt(x: 3, y: 4).state = .alive
        cellAt(x: 4, y: 4).state = .alive
      case .blinker:
        cellAt(x: 11, y: 12).state = .alive
        cellAt(x: 12, y: 12).state = .alive
        cellAt(x: 13, y: 12).state = .alive
      case .lightWeightSpaceship:
        cellAt(x: 12, y: 12).state = .alive
        cellAt(x: 13, y: 12).state = .alive
        cellAt(x: 14, y: 12).state = .alive
        cellAt(x: 15, y: 12).state = .alive
        
        cellAt(x: 12, y: 11).state = .alive
        cellAt(x: 16, y: 11).state = .alive
        
        cellAt(x: 12, y: 10).state = .alive
        
        cellAt(x: 13, y: 9).state = .alive
        cellAt(x: 16, y: 9).state = .alive
     
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
  
  func cellCoordinates(at index: Int) -> (x: Int, y: Int) {
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
  
  //MARK:-
  func performGameTurn() {
    var index = 0
    var cellsToKill: [Cell] = []
    var cellsToBirth: [Cell] = []
    
  
    for cell in cells {
      var liveNeighbours = 0
      let coordinates = cellCoordinates(at: index)
      
      // West
      if coordinates.x != 0 {
        if cellAt(x: coordinates.x - 1, y: coordinates.y).state == .alive {
          liveNeighbours += 1
        }
      }
      // North West
      if coordinates.x != 0 && coordinates.y != 0 {
        if cellAt(x: coordinates.x - 1, y: coordinates.y - 1).state == .alive {
          liveNeighbours += 1
        }
      }
      
      // North
      if coordinates.y != 0 {
        if cellAt(x: coordinates.x, y: coordinates.y - 1).state == .alive {
          liveNeighbours += 1
        }
      }
      // North East
      if coordinates.x < (gridSize - 1) && coordinates.y != 0 {
        if cellAt(x: coordinates.x + 1, y: coordinates.y - 1).state == .alive {
          liveNeighbours += 1
        }
      }
      
      // East
      if coordinates.x < (gridSize - 1) {
        if cellAt(x: coordinates.x + 1, y: coordinates.y).state == .alive {
          liveNeighbours += 1
        }
      }
      
      // South East
      if coordinates.x < (gridSize - 1) && coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x + 1, y: coordinates.y + 1).state == .alive {
          liveNeighbours += 1
        }
      }
      
      // South
      if coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x, y: coordinates.y + 1).state == .alive {
          liveNeighbours += 1
        }
      }
      
      // South West
      if coordinates.x != 0 && coordinates.y < (gridSize - 1) {
        if cellAt(x: coordinates.x - 1, y: coordinates.y + 1).state == .alive {
          liveNeighbours += 1
        }
      }
      
  
      switch cell.state {
        case .alive where liveNeighbours < 2 || liveNeighbours > 3:
          // If the cell is alive and has 2 or 3 neighbors, then it remains alive. Else it dies.
         
          cellsToKill.append(cell)
        case .dead where liveNeighbours == 3:
          // If the cell is dead and has exactly 3 neighbors, then it comes to life. Else if remains dead.
         
          cellsToBirth.append(cell)
        default:
          break
      }
      
      index += 1
     
    }
    cellsToKill.forEach { $0.state = .dead } // Kill the cell
    cellsToBirth.forEach { $0.state = .alive } // Birth the cell
    generation += 1
    notifyDelegate()
  }
  
  private func notifyDelegate() {
    delegate?.didUpdateGeneration()
    delegate?.didUpdatePopulation()
    delegate?.didUpdateGrid()
  }
}
