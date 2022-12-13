//
//  InitializeRequestModel.swift
//  PinSelect
//
//  Created by Kelsey Makale on 02/12/2022.
//

import Foundation

struct InitializeRequestModel : Codable{
    let serno : String
    let pan : String
    let expiryDate : String
}

struct EncryptedRequestModel :Codable{
    let encData: String
}
