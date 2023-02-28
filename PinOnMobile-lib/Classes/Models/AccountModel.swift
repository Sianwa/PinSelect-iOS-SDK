//
//  AccountModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation

public struct AccountModel: Codable{
    public init(cardSerNo: String, isDebit: Bool) {
        self.cardSerNo = cardSerNo
        self.isDebit = isDebit
    }
    
    let cardSerNo: String
    let isDebit: Bool
}
