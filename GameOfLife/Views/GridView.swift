//
//  GridView.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

class GridView: UIView {
  
  //MARK:- Properties-
  
  var gameGrid = GameEngine(gridSize: 25)
  private var cellSize: Int = 15
  private var timer: Timer?
  var timeInterval = 0.25
  var timerRunning: Bool { timer == nil ? false : true }
  
  //MARK:- Initialization-
  
  public convenience init(gridSize: Int, cellSize: Int) {
    let frame = CGRect(x: 0, y: 0, width: cellSize * gridSize, height: cellSize * gridSize)
    self.init(frame:frame)
    
    self.gameGrid = GameEngine(gridSize: gridSize)
    self.cellSize = cellSize
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  //MARK: - Public interface-
  
  public func cancelTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  public func cellTapped(at index: Int) {
    gameGrid.cellTapped(at: index)
    setNeedsDisplay()
  }
  
  public func clearGrid() {
    gameGrid.clearGrid()
    setNeedsDisplay()
  }
  
  @objc private func performGameTurn() {
    self.gameGrid.performGameTurn()
    self.setNeedsDisplay()
  }
  
  public func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(performGameTurn), userInfo: nil, repeats: true)
  }
  
  public func step() {
    gameGrid.performGameTurn()
    setNeedsDisplay()
  }
  
  public func useExamplePattern(pattern: Patterns) {
    gameGrid.clearGrid()
    gameGrid.userExamplePattern(pattern: pattern)
    setNeedsDisplay()
  }
}
