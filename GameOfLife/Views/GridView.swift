//
//  GridView.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

class GridView: UIView {
  //MARK:- Properties
  var gameGrid = GameGrid(gridSize: 25)
  private var cellSize: Int = 15
  
  private var timer: Timer?
  var timeInterval = 0.25
  var timerRunning: Bool {
    timer == nil ? false : true
  }
  
  public convenience init(gridSize: Int, cellSize: Int) {
    let frame = CGRect(x: 0, y: 0, width: cellSize * gridSize, height: cellSize * gridSize)
    self.init(frame:frame)
    
    self.gameGrid = GameGrid(gridSize: gridSize)
    self.cellSize = cellSize
  }
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  //MARK: - Public interface
  public func cancelTimer() {
    timer?.invalidate()
    timer = nil
  }
  
  public func cellTapped(at index: Int) {
    
  }
  
}
