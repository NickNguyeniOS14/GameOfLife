//
//  ViewController.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/24/20.
//

import UIKit

class GameViewController: UIViewController {
  
  //MARK:- IBOutlets
  
  @IBOutlet weak var generationLabel: UILabel!
  @IBOutlet weak var populationLabel: UILabel!
  @IBOutlet weak var gridView: GridView!
  
  
  
  //MARK:- Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
    print("Menu")
  }
  
  
  @IBAction func playButtonTapped(_ sender: UIBarButtonItem) {
    print("Play")
  }
  
  
  
  @IBAction func nextButtonTapped(_ sender: UIBarButtonItem) {
    print("Next")
  }
  
  
  @IBAction func clearButtonTapped(_ sender: UIBarButtonItem) {
    print("clear")
  }
}

