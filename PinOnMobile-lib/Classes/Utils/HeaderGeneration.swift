//
//  HeaderGeneration.swift
//  PinOnMobile-lib
//
//  Created by Kelsey Makale on 02/02/2023.
//

import Foundation
import PercentEncoder
import CryptoSwift
import Alamofire

public func generateHeaders(clientId:String,clientSecret:String,httpRequest: String,path:String)throws->HTTPHeaders{
    do {
        
        //remove dashes
        let nonceRegex = try NSRegularExpression(pattern: "-", options: NSRegularExpression.Options.caseInsensitive)
        
        let rawNonce = UUID().uuidString
        let nonce = nonceRegex.stringByReplacingMatches(in: rawNonce, options: [], range: NSMakeRange(0, rawNonce.count), withTemplate: "")
        let signatureMethod:String = "SHA1";
        
        //get timestamp
        let timestamp = String(Int(NSDate().timeIntervalSince1970))
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "testids.interswitch.co.ke"
        urlComponents.port = 18082
        urlComponents.path = path
        guard let url = urlComponents.url else {
            throw fatalError("Unable to create url from the given components")
        }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        let encodedUrl = PercentEncoding.encodeURIComponent.evaluate(string:url.absoluteString)
        request.httpMethod = httpRequest
        // Make sure that we include headers specifying that our request's HTTP body
        // will be JSON encoded
        let signatureItems:Array<String> = [request.httpMethod!,encodedUrl, timestamp, nonce, clientId, clientSecret]
        let hashedJoinedItems = [UInt8](signatureItems.joined(separator: "&").utf8)
        let sha1ofbytesof = hashedJoinedItems.sha1()
        
        let signature = sha1ofbytesof.toBase64()
        let encodedClientId = (clientId.data(using: String.Encoding.utf8)! as NSData).base64EncodedData()
        let stringAuth: String = "InterswitchAuth " + String(bytes: encodedClientId, encoding: .utf8)!
        let reqHeaders: HTTPHeaders = ["InstID":"54", "Nonce":nonce, "Timestamp":timestamp,"SignatureMethod": signatureMethod,"Signature": signature! , "Authorization" :stringAuth ]
        
        return reqHeaders
        
    } catch {
        throw error
    }
}

