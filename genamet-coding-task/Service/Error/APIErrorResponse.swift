//
//  APIErrorResponse.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 27/04/23.
//

import Foundation

enum APIErrorResponse: String {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
    
    public var description: String {
        switch self {
        case .apiError: return "Seems problem with the api"
        case .invalidEndpoint: return "Seems problem with the endpoint"
        case .invalidResponse: return "Seems problem with the response"
        case .noData: return "Seems problem with the data format"
        case .serializationError: return "Seems problem with the serialization"
        }
    }
}
