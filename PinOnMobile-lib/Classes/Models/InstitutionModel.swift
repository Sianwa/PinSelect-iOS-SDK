//
//  InstitutionModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//
import Foundation

public struct InstitutionModel : Codable{
    public init(clientId: String, clientSecret: String, institutionId: Int, rsaPublicKey: String, rsaPrivateKey: String, keyId: String, callbackURL: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.institutionId = institutionId
        self.rsaPublicKey = rsaPublicKey
        self.rsaPrivateKey = rsaPrivateKey
        self.keyId = keyId
        self.callbackURL = callbackURL
    }
    
    let clientId: String
    let clientSecret: String
    let institutionId : Int
    let rsaPublicKey : String
    let rsaPrivateKey : String
    let keyId : String
    let callbackURL : String
}
