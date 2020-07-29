//
//  ViewController.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/24/20.
//

import UIKit

@available(iOS 14.0, *)
class GameViewController: UIViewController {
  
  //MARK:- Properties-
  
  private var buttons: [UIButton] = []
  
  private lazy var defaultButtonsColor = UIColor.link {
    didSet {
      didUpdateGrid()
    }
  }
  
  private(set) lazy var colorPickerViewController: UIColorPickerViewController = {
    let picker = UIColorPickerViewController()
    picker.title = "Cell Color Setting"
    picker.delegate = self
    return picker
  }()
  
  
  //MARK:- IBOutlets-
  
  @IBOutlet weak var generationLabel: UILabel!
  @IBOutlet weak var populationLabel: UILabel!
  @IBOutlet weak var gridView: GridView!
  @IBOutlet weak var playButton: UIBarButtonItem!
  
  //MARK:- Life Cycle-
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupButtons()
    gridView.gameGrid.delegate = self
    didUpdateGeneration()
    didUpdatePopulation()
    didUpdateGrid()
  }
  
  //MARK:- IBActions-
  
  
  @IBAction func colorSettingTapped(_ sender: UIBarButtonItem) {
    self.present(colorPickerViewController, animated: true, completion: nil)
  }
  
  
  @IBAction func animationSpeedChanged(_ sender: UISegmentedControl) {
    print(sender.selectedSegmentIndex)
  }
  
  
  
  @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
    print("Menu")
    let alertController = UIAlertController(title: "Example Patterns", message: "Select a Game of Life pattern", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Random Pattern", style: .default, handler: { (_) in
      self.gridView.useExamplePattern(pattern: .random)
    }))
    alertController.addAction(UIAlertAction(title: "Pulsar", style: .default, handler: { (_) in
      self.gridView.useExamplePattern(pattern: .pulsar)
    }))
    alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
  
  @IBAction func playButtonTapped(_ sender: UIBarButtonItem) {
    if gridView.timerRunning {
      pauseGame()
    } else {
      playButton.image = UIImage(systemName: "pause.circle")
      
      gridView.startTimer()
    }
  }
  private func pauseGame() {
    playButton.image = UIImage(systemName: "play.circle")
    gridView.cancelTimer()
  }
  private func setupButtons() {
    var index = 0
    var topOffset: CGFloat = 0
    var leadingOffset:CGFloat = 0
    
    for y in 0..<gridView.gameGrid.gridSize {
      for x in 0..<gridView.gameGrid.gridSize {
        print(index, x, y)
        index += 1
        let button = UIButton()
        button.tag = index
        
        
        button.backgroundColor = UIColor.clear
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
    gridView.step()
  }
  
  
  @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
    print("clear")
    gridView.cancelTimer()
    gridView.gameGrid.clearGrid()
  }
}



@available(iOS 14.0, *)
extension GameViewController: GameStatsDelegate {
  func didUpdateGeneration() {
    generationLabel.text = "\(gridView.gameGrid.generation)"
  }
  
  func didUpdatePopulation() {
    populationLabel.text = "\(gridView.gameGrid.population)"
  }
  
  func didUpdateGrid() {
    var index = 0
    gridView.gameGrid.cells.forEach {
      buttons[index].backgroundColor = $0.state == .alive ? defaultButtonsColor : UIColor.clear
      index += 1
    }
  }
}
@available(iOS 14.0, *)
extension GameViewController: UIColorPickerViewControllerDelegate {
  
  func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
    //
    print("Hello theere")
  }
  func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
    //
    print("Hello")
  }
}
