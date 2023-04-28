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
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
                self.navigationController?.pushViewController(homeVC, animated: false)
             }
        }
    }
}

