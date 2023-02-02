//
//  InstitutionModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//
import Foundation

struct InstitutionModel : Codable{
    let clientId: String
    let clientSecret: String
    let institutionId : Int
    let rsaPublicKey : String
    let rsaPrivateKey : String
    let keyId : String
}
