//
//  MQTTManager.swift
//  PinSelect
//
//  Created by Kelsey Makale on 15/12/2022.
//

import Foundation
import CocoaMQTT
import Combine


final class MQTTManager: ObservableObject {
    private var mqttClient: CocoaMQTT?
    private var identifier: String!
    private var host: String!
    private var topic: String!
    
    private init(){}
    
    //MARK: Shared instance
    private static let _shared = MQTTManager()
    
    //MARK: Accessors
    class func shared() -> MQTTManager {
        return _shared
    }
    
    func initializeMQTT(host: String, identifier: String){
     //if any previois instances exist then clean it
        if(mqttClient != nil){
            mqttClient = nil
        }
        
        self.identifier = identifier
        self.host = host
        let clientID = "CocoaMQTT-\(identifier)-" + String(ProcessInfo().processIdentifier)

        mqttClient = CocoaMQTT(clientID: clientID, host: host, port: 1883)
        mqttClient?.willMessage = CocoaMQTTMessage(topic: "/will", string: "\(identifier) has left")
        mqttClient?.keepAlive = 60
        mqttClient?.delegate = self
        mqttClient?.autoReconnect = true
        
    }
    
    func connect(){
        if let success  = mqttClient?.connect(), success{
            print("connected....")
        }else{
            print("failed to connect...")
        }
    }
    
    func subscribe(topic: String){
        self.topic = topic
        mqttClient?.subscribe(topic, qos: .qos1)
    }
    
    func disconnect(){
        mqttClient?.disconnect()
    }
    
    func unSubscribe(topic: String){
        mqttClient?.unsubscribe(topic)
    }
    
    func currentHost() -> String? {
        return host
    }
}

extension MQTTManager: CocoaMQTTDelegate{
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        TRACE("MQTT CLIENT CONNECTION ACKNOWLEGED :::\(ack)")
        self.subscribe(topic: "topic/iswke")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        TRACE()
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        TRACE("MQTT CLIENT PUBLISH ACKNOWLEGED :::\(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16) {
        TRACE("MQTT CLIENT RECEIVED ::: \(message.string.description), id:\(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopics success: NSDictionary, failed: [String]) {
        TRACE("MQTT CLIENT SUBSCRIBED TO TOPIC ::: \(String(describing: self.topic))")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopics topics: [String]) {
        TRACE("MQTT CLIENT UNSUBSCRIBED FROM :::\(topics)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        TRACE("MQTT CLIENT SENT PING")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        TRACE("MQTT CLIENT RECEIVED PONG")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        TRACE("MQTT CLIENT DISCONNECTED :::\(err.description)")
    }
    
    
}

extension MQTTManager {
    func TRACE(_ message: String = "", fun: String = #function) {
        let names = fun.components(separatedBy: ":")
        var prettyName: String
        if names.count == 1 {
            prettyName = names[0]
        } else {
            prettyName = names[1]
        }

        if fun == "mqttDidDisconnect(_:withError:)" {
            prettyName = "didDisconect"
        }

        print("[TRACE] [\(prettyName)]: \(message)")
    }
}

extension Optional {
    // Unwrap optional value for printing log only
    var description: String {
        if let wraped = self {
            return "\(wraped)"
        }
        return ""
    }
}



