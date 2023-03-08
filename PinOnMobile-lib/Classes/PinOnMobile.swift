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
    let baseUrl = "https://testids.interswitch.co.ke/"
    public var mqttHostURL: String = "testmerchant.interswitch-ke.com"
    
    
    public enum NetworkError: Error{
        case requestFailed
        case responseUnsuccessful
        case invalidData
    }
    
    
    public func initialize(accountData: AccountModel, institutionData: InstitutionModel)async throws -> InitializationResponseModel{
        
        do {
            let heads = try generateHeaders(clientId: institutionData.clientId, clientSecret: institutionData.clientSecret, httpRequest: "\(self.baseUrl)identity/api/v1/web/initialize", path: "")
            
            debugPrint("SELECTION::\(accountData.isDebit)")
            
            let requestObject: RequestPayloadModel = RequestPayloadModel(
                
                institution: Institution(callbackUrl: institutionData.callbackURL, id: institutionData.institutionId),
                account: Account(
                    cardSerialNumber: accountData.cardSerNo,
                    isDebit: accountData.isDebit
                )
            )
            
    
       let result = AF.request("\(self.baseUrl)identity/api/v1/web/initialize", method: .post,
        parameters: requestObject, encoder: JSONParameterEncoder.default, headers: heads)
                .serializingDecodable(InitializationResponseModel.self)
            return try await result.value
             
        
        }catch{
            print("Error::\(String(describing: error.asAFError))")
            throw NetworkError.invalidData
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
        mqttClient.logLevel = .debug
        mqttClient.username = ""
        mqttClient.password = ""
        mqttClient.willMessage = CocoaMQTTMessage(topic: "/will", string: "dieout")
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
        
    }
    
    public func mqtt(_ mqtt:CocoaMQTT, didPublishAck id: UInt16) {
        
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        debugPrint("mqt RECEIVED MESSAGE::\(message)")
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        
    }
    
    public func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        
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
