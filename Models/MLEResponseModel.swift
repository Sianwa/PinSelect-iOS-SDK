//
//  MLEResponseModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation


// MARK: - MleKeyResponse
struct MleKeyResponse: Codable {
    let responseCode, responseMessage: String
    let id, instid: Int
    let item: Item
    
}
// MARK: - Item
struct Item: Codable {
    let key: String
    let id, instid: Int
}
