//
//  HomeViewController.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 25/04/23.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [String] = ["Item 1", "Item 2", "Item 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tableView ?? "not present")
        
        tableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil ), forCellReuseIdentifier: Constants.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? TableViewCell else{
            fatalError(Constants.dequeueErrorMessage)
        }
        
        cell.configure(with: "Hello", with: "Description cbasbcbioucsc w qw ", imageName: "LaunchScreenImage")
        
        return cell
    }

}

extension HomeViewController {
    enum Constants {
        static let cellIdentifier = "TableViewCell"
        static let dequeueErrorMessage = "Unable to dequeue cell"
    }
}
