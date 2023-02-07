//
//  InitializationResponseModel.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation

public struct InitializationResponseModel: Codable{
    public init(responseCode: String, responseMessage: String, callbackUrl: String, id: Int, instid: Int, uuid: String) {
        self.responseCode = responseCode
        self.responseMessage = responseMessage
        self.callbackUrl = callbackUrl
        self.id = id
        self.instid = instid
        self.uuid = uuid
    }
    
    
    public let responseCode : String
    public let responseMessage: String
    public let callbackUrl : String
    public let id : Int
    public let instid : Int
    public let uuid : String
}
