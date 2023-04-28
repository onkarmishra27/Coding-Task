//
//  AurthorDataRequest.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 27/04/23.
//

import Foundation

struct AurthorDataRequest: NetworkRequest {
    
    var queryItems: [String : String] 
    
    
    private let apiKey: String = ""
    
    var url: String {
        let baseURL: String = "https://picsum.photos/v2"
        let path: String = "/list"
        return baseURL + path
    }
    
    var headers: [String : String] {
        [:]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [AuthorRow] {
        do {
            let cellDataResponse = try JSONDecoder().decode(AurhorResponse.self, from: data)
            return cellDataResponse
        } catch {
            return []
        }
    }
}
