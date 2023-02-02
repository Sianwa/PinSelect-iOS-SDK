//
//  File.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation
import Security
import Alamofire
import UIKit
import CocoaMQTT

public class PinOnMobile: UIViewController {
    
    public static let instance = PinOnMobile()
    public var PinOnMobileDelegate: PinOnMobileDelegate?
    
    var mqttClient: CocoaMQTT!
    var uuidString: String!
    var topic: String!
    let baseUrl = "https://4841-41-90-69-53.eu.ngrok.io/"
    public var mqttHostURL: String = "testmerchant.interswitch-ke.com"
    
    
    public func initialize(accountData: AccountModel)async throws -> InitializationResponseModel{
        
        do {
            
            let clientID = "IKIA971FB5996EADBD16534494CB87B90D1DB3EAD105"
            let clientSecret = "ONcmxGU4B+A+qaHp+/Nw19yO9w117PY36/SxsH1A1Wc="
            let heads = try generateHeaders(clientId: clientID, clientSecret: clientSecret, httpRequest: "\(self.baseUrl)identity/api/v1/web/initialize", path: "")
            
            let requestObject: RequestPayloadModel = RequestPayloadModel(
                
                institution: Institution(callbackUrl: "www.google.com", id: 54),
                account: Account(
                    accountNumber: accountData.accountNumber,
                    cardSerialNumber: accountData.cardSerNo,
                    expiryDate: accountData.expriyDate!,
                    cvv: "")
            )
            
    
       let result = AF.request("\(self.baseUrl)identity/api/v1/web/initialize", method: .post,
        parameters: requestObject, encoder: JSONParameterEncoder.default, headers: heads)
                .serializingDecodable(InitializationResponseModel.self)
            return try await result.value
             
        
        }catch{
            print(error)
            throw error
        }
    }
    
    public func changePin(initializationResponseObject: InitializationResponseModel,  previousUIViewController:UIViewController,completion:@escaping(String)->()) throws{
        
        self.uuidString = initializationResponseObject.uuid
        self.setUpMQTT()
        let threeDS = BrowserView(webCardinalURL: (URL(string:initializationResponseObject.callbackUrl)!))
        DispatchQueue.main.async {
            previousUIViewController.navigationController?.pushViewController(threeDS, animated: true)
        }
        self.mqttClient.didReceiveMessage = { mqtt, message, id in
            mqtt.disconnect()
            previousUIViewController.navigationController?.popViewController(animated: true)
            completion(message.string!)
        }
        
    }
    
    
    func setUpMQTT(){
        let clientID = "iOS-" + String(ProcessInfo().processIdentifier)
        mqttClient = CocoaMQTT(clientID: clientID, host: self.mqttHostURL, port: 1883)
        mqttClient.username = ""
        mqttClient.password = ""
        mqttClient.willMessage = CocoaMQTTWill(topic: "/will", message: "dieout")
        mqttClient.keepAlive = 60
        mqttClient.connect()
        mqttClient.delegate = self
    }
}


extension PinOnMobile:CocoaMQTTDelegate{
    public func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        debugPrint("mqtt Connected")
        self.mqttClient.subscribe("identity/" + self.uuidString)
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        debugPrint(message.string!)
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topics: [String]) {
        debugPrint(topics)
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        
    }
    
    public func mqttDidPing(_ mqtt: CocoaMQTT) {
        
    }
    
    public func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        
    }
    
    public func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        debugPrint("mqtt disconnected")
    }
}

public protocol PinOnMobileDelegate {
    func launchUIPayload(_ message: String)
}
