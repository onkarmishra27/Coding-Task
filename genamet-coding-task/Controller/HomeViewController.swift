//
//  HomeViewController.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 25/04/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadMoreIndicator: UIActivityIndicatorView!
    
    private var viewModel: AuthorViewModel?
    
    private lazy var spinner = UIActivityIndicatorView(style: .gray)
    private lazy var refreshControl = UIRefreshControl()
    
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        loadAuthors()
    }
    
    private func setupSubViews() {
        
        loadMoreIndicator.isHidden = true

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        tableView.register(UINib(nibName: Constants.cellIdentifier, bundle: nil ), forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(loadMoreAuthors), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        viewModel = AuthorViewModel(networkService: DefaultNetworkService())
    }
    
    private func loadAuthors(){
        
        guard let aViewModel = viewModel else { return }
        
        aViewModel.fetchAuthors("\(currentPage)")
        
        aViewModel.onSuccess = { [weak self] data in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.loadMoreIndicator.stopAnimating()
                self?.loadMoreIndicator.isHidden = true
                self?.tableView.reloadData()
            }
            
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rows.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? AuthorCell else{
            fatalError(Constants.dequeueErrorMessage)
        }
        
        if let viewModel = viewModel {
            let row = viewModel.rows[indexPath.row]
            let isRowSelected = viewModel.isRowSelected(row)
            cell.viewModel = AuthorCellModel(row: row, isSelected: isRowSelected)
            cell.didTapOnCheckMark = { [weak self] (selectedRow,isSelected) in
                if viewModel.isRowSelected(selectedRow) {
                    self?.showAlert(withTitle: Constants.alertTitle, withMessage: Constants.alertMessage)
                } else {
                    viewModel.setRowSelected(selectedRow)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        
        if viewModel.rows.count > 1, indexPath.row == viewModel.rows.count - 1 {
            DispatchQueue.main.async {
                self.loadMoreIndicator.isHidden = false
                self.loadMoreIndicator.startAnimating()
            }
            loadMoreAuthors()
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    @objc func loadMoreAuthors() {
        currentPage += 1
        loadAuthors()
        
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
}

extension HomeViewController {
    enum Constants {
        static let cellIdentifier = "AuthorCell"
        static let dequeueErrorMessage = "Unable to dequeue cell"
        static let alertTitle = "Alert"
        static let alertMessage = "This author is already selected"
    }
}

extension  UIViewController {
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
