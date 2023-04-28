//
//  AuthorViewModel.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 27/04/23.
//

import Foundation

protocol AuthorDataProvider: AnyObject {
    var rows: [AuthorRow] { set get }
    var onSuccess: (([AuthorRow]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }
    func fetchAuthors(_ pageNo: String, _ limit: String)
    
    var selectedRows: [AuthorRow] { get }
    func setRowSelected(_ row: AuthorRow)
    func isRowSelected(_ row: AuthorRow) -> Bool
}

class AuthorViewModel: AuthorDataProvider {
    
    var selectedRows: [AuthorRow] = []
    var onSuccess: (([AuthorRow]) -> Void)?
    var onError: ((Error) -> Void)?
    var rows: [AuthorRow] = []
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchAuthors(_ pageNo: String = Constants.defaultPageNo, _ limit: String = Constants.limit) {
        let request = AurthorDataRequest(queryItems: [Constants.pageKey:pageNo, Constants.limitKey : limit])
        networkService.request(request) { [weak self] result in
            switch result {
            case .success(let rows):
                self?.rows.append(contentsOf: rows)
                self?.onSuccess?(self?.rows ?? [])
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}


extension AuthorViewModel {
    
    func setRowSelected(_ row: AuthorRow) {
        selectedRows.append(row)
    }
    
    func isRowSelected(_ sourceRow: AuthorRow) -> Bool {
        selectedRows.contains { row in
            return sourceRow.id == row.id
        }
    }
    
}

private extension AuthorViewModel {
    
    enum Constants {
        static let limitKey = "limit"
        static let pageKey = "page"
        
        static let limit = "10"
        static let defaultPageNo = "1"
    }
}
