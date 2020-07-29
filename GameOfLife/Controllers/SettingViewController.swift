//
//  SettingViewController.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

class SettingViewController: UIViewController {
  
  
  @IBAction func doneTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  
  
  @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
    
  }
  
  
  @IBAction func speedValueChanged(_ sender: UISegmentedControl) {
  }
  
  
  @IBAction func buttonValueChanged(_ sender: UISegmentedControl) {
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
}
