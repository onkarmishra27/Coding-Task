//
//  AuthorModels.swift
//  genamet-coding-task
//
//  Created by Active Mac Lap 01 on 26/04/23.
//

import Foundation

// MARK: - AuthorRow
struct AuthorRow: Codable {
    let id, author: String?
    let width, height: Int?
    let url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}

typealias AurhorResponse = [AuthorRow]

struct AuthorCellModel {
    let row: AuthorRow
    let isSelected: Bool
}
