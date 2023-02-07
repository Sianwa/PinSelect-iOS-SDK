//
//  AccountModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation

public struct AccountModel: Codable{
    public init(accountNumber: String, cardSerNo: String, expriyDate: String?) {
        self.accountNumber = accountNumber
        self.cardSerNo = cardSerNo
        self.expriyDate = expriyDate
    }
    
    let accountNumber: String
    let cardSerNo: String
    let expriyDate: String?
}
