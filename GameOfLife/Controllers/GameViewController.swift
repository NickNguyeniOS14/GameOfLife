//
//  ViewController.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/24/20.
//

import UIKit

class GameViewController: UIViewController {
  
  //MARK:- Properties
  private var buttons: [UIButton] = []
  
  private lazy var buttonColor = UIColor.systemTeal {
    didSet {
      gridUpdated()
    }
  }
  
  //MARK:- IBOutlets
  
  @IBOutlet weak var generationLabel: UILabel!
  @IBOutlet weak var populationLabel: UILabel!
  @IBOutlet weak var gridView: GridView!
  @IBOutlet weak var playButton: UIBarButtonItem!
  
  //MARK:- Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButtons()
    gridView.gameGrid.delegate = self
    showGeneration()
    showPopulation()
    gridUpdated()
  }
  
  @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
    print("Menu")
  }
  
  
  @IBAction func playButtonTapped(_ sender: UIBarButtonItem) {
    if gridView.timerRunning {
      pauseGame()
    } else {
      playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal, barMetrics: .compact)
      gridView.startTimer()
    }
  }
  private func pauseGame() {
    playButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal, barMetrics: .compact)
    gridView.cancelTimer()
  }
  private func setupButtons() {
    var index = 0
    var topOffset = CGFloat(0)
    var leadingOffset = CGFloat(0)
    
    for y in 0..<gridView.gameGrid.gridSize {
      for x in 0..<gridView.gameGrid.gridSize {
        print(index, x, y)
        let button = UIButton()
        button.tag = index
        index += 1
        
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        gridView.addSubview(button)
        
        NSLayoutConstraint.activate([
          button.topAnchor.constraint(equalTo: gridView.topAnchor, constant: topOffset),
          button.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: leadingOffset),
          button.heightAnchor.constraint(equalToConstant: 15),
          button.widthAnchor.constraint(equalToConstant: 15)
        ])
        buttons.append(button)
        
        leadingOffset += 15
        if leadingOffset >= 375 {
          leadingOffset = 0
        }
      }
      topOffset += 15
    }
  }
  @objc private func buttonTapped(_ sender: UIButton) {
    print(sender.tag)
    gridView.cellTapped(at: sender.tag)
  }
  
  @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
    print("Next")
  }
  
  
  @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
    print("clear")
  }
}



extension GameViewController: GameStatsDelegate {
  func showGeneration() {
    generationLabel.text = "\(gridView.gameGrid.generation)"
  }
  
  func showPopulation() {
    populationLabel.text = "\(gridView.gameGrid.population)"
  }
  
  func gridUpdated() {
    var index = 0
    gridView.gameGrid.cells.forEach {
      buttons[index].backgroundColor = $0.state == .alive ? buttonColor : .clear
      index += 1
    }
  }
}
