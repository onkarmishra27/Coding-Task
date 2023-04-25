//
//  ViewController.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 25/04/23.
//

import UIKit

class SplashViewController: UIViewController {

  
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Add a delay of 5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                // Push the HomeViewController onto the navigation stack
                let homeVC = HomeViewController()
                self.navigationController?.pushViewController(homeVC, animated: true)
            }
        }

}

