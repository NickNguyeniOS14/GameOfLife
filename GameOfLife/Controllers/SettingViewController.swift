//
//  SettingViewController.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/28/20.
//

import UIKit

@available(iOS 14.0, *)
class SettingViewController: UIColorPickerViewController {
  
  
  @IBAction func doneTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
    
  }
  
  @IBAction func speedValueChanged(_ sender: UISegmentedControl) {
  }
  

  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }
}
