//
//  RequestPayloadModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation


struct RequestPayloadModel: Encodable{
    let institution: Institution
    let account: Account
}

struct Institution: Encodable{
    let callbackUrl: String
    let id: Int
}

struct Account: Encodable{
    let cardSerialNumber: String
    let isDebit: Bool
}
