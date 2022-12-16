//
//  RequestPayloadModel.swift
//  PinSelect
//
//  Created by Kelsey Makale on 15/12/2022.
//

import Foundation

struct RequestPayloadModel: Codable{
    let institution: Institution
    let account: Account
}

struct Institution: Codable{
    let callBackUrl: String
}

struct Account: Codable{
    let accountNumber: String
    let cardSerialNumber: Int
    let expiryDate: String
    let cvv: String
}
