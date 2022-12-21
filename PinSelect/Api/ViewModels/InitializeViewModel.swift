//
//  InitializeViewModel.swift
//  PinSelect
//
//  Created by Kelsey Makale on 01/12/2022.
//

import Foundation
import JOSESwift
import Security

final class InitializeViewModel : ObservableObject {
    
    @Published var hasData: Bool = false
    
    func getSample(){
        let baseUrl = "https://jsonplaceholder.typicode.com/users"
        
        //API request
        if let url = URL(string: baseUrl){
            
            DispatchQueue.main.async {
                
                URLSession
                    .shared
                    .dataTask(with: url){
                        data, response, error in
                        
                        if let error = error{
                            print(error.localizedDescription)
                        }else{
                            let httpResponse = response as? HTTPURLResponse
                            print("RESPONSE CODE :: \(String(describing: httpResponse?.statusCode))")
                        }
                        
                    }.resume()
            }
            
        }
    }
    
    func initializeService(){
        
        //todo: 1.Get MLE key --> 2. Create payload ---> 3. Encrypt payload and send it to backend
        
        let baseUrl = "https://jsonplaceholder.typicode.com/users"
        
        let rsaPubKeyString = "TUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFvK2VQL2pWcmNaNUczQTZnbERTblkya3BkejY3RyszejBPYzBYZUkrN2tIZmRtd3lqZEMybmFsVFZ5RVc0aUdMek1VdldYMWlLNVcxT3pycThFOE5SVHkvUE5UV0NkNzErbWd2Rnp0NkZnYWI4bFRSTXY4K29uaU02WDRpOW1iT2tCMG5LYUJ5R21ZL0RERGlZb0NCZWh2QjMyS2FKSXlyMzlMTmtlNWlCOTgrM1RXaHYvY1pzSjhMYWJoZEhYZ1dYc25XWm9ua2UwaFNrSCtscG5waCt6RkhpMXoxYkxxZ2hDMnpQQVVDekJiYVlvRFZNNkRHV0o5dEpWSFlqTURIak5KQzYxN1BFRXRPQndJV3Y1RzE5QXc1MUR2dEQzY0l3R3p1QTVmNXhlNExXYzJ0WjBSVmZVZWtJdkp6d2UwTXZUalJIcVpXQ1gvMDhGbWF5R2xOZndJREFRQUI=";

        
        let keyBase64 = "MIIEpAIBAAKCAQEA5B7lqLrwVCFNUiCmwMr5Q48iuArOolxb7DAuclGnoZVX0SaJ8mrvCOtd6qY/VeBw227txWEPH7840qX/yGxxqTngdNCuDATqYrrbxFOGV30GZmg6NpZYKShTlsftkhiCsoXW0A7m5MCZUkH2/sNBC8oRHCNDXRlsU5bq/yPaAMt6xlBsUgLt/++INcuw+rx1Rm7LJv0FeukQmlekUOL/DMJXcLXCa05StTbvHPiAHOLej07pThCZoX3XHFpOTQ6379EsjvSZHtNhr67qrtRb8or2rX7wt5NWzXHbhUDlyzEcIBB/7G8ygqWhyZTEIMFiRMWSa3KGYZE3nZe5weC7SQIDAQABAoIBAQCjjxehA+++kmYK5YhKIP3Zl64QAQeo18m8rcsPgkZLj3V4a0Zq/orGfWNIE8zDePnSC1YFuBKM86D9P7IGdOKFsA6kEt9HlNqs0UczG6Pt5KGLGV3rt54cXGKacFyA7HwBHf8oDBc2mnUTymIaxcpEdqwP3aS2Ar1trX5uUrlC6UcZyspBZVYvMlU+uAKL1ZtFxjsv0EzuQQW1HX7b2WPUAoxp/yBC/EBRM9K8WbG9i7NB4FTFHAdTMt/EZLGUESizFgrai6lp3s96Apz5GvncRUI+UVP/7zbUaFYdRMW5lrcR8+PL9NACkL2rnQuLoyLKWZWPPlD3WEE9EzY4bH6FAoGBAPu8hL8goEbWMFDZuox04Ouy6EpXR8BDTq8ut6hmad6wpFgZD15Xu7pYEbbsPntdYODKDDAIJCBsiBgf2emL50BpiQkzMPhxyMsN5Pzry9Ys+AzPkJcQ7g+/Wbto9lCC+JmgxtGQ7JIibo1QH7BTsuK9+k72HnZne6oIfaYKbBZfAoGBAOf7/D2Q7NiNcEgxpZRn06+mnkHMb8PfCKfJf/BFf5WKXSkDBZ3XhWSPnZyQnE3gW3lzJjzUwHS+YDk8A0Xl2piAHa/d5O/8eoijB8wa6UGVDBIXqUnfM3Udfry78rM71FOpbzV3H48G7u4CUJMGwOpEqF0TfgtQr4uf8OurdH9XAoGAbdNhVsE1K7Jmgd97s6uKNUpobYaGlyrGOUd4eM+1gKIwEP9d5RsBm9qwX83RtKCYk3mSt6HVoQ+4kE3VFD8lNMTWNF1REBMUNwJo1K9KzrXvwicMPdv1AInK7ChuzdFWBDBQjT1c+KRs9tnt+U+Ky8F2Ytydjaq4GQZ7SuVhIqECgYBMsS+IovrJ9KhkFZWp5FFFRo4XLqDcXkWcQq87HZ66L03xGwCmV/PPdPMkKWKjFELpebnwbl1Zuv5QrZhfaUfFFsW5uF/RPuS7ezo+rb7jYYTmDlB3DYUTeLbHalMoEeV16xPK1yDlxeMDaFx+3sK0MBKBAsqurvP58txQ7RPMbQKBgQCzRcURopG0DF4VF4+xQJS8FpTcnQsQnO/2MJR35npA2iUb+ffs+0lgEdeWs4W46kvaF1iVEPbr6She+aKROzE9Bs25ZCgGLv97oUxDQo0IPvURX7ucN+xOUU1hw9oQDVdGKl1JZh93fn+bjtMTe+26asGLmM0r9YQX1P8qaw3KOg=="
        
        
        let rsaPrivateKeyString = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCj54/+NWtxnkbcDqCUNKdjaSl3Prsb7fPQ5zRd4j7uQd92bDKN0LadqVNXIRbiIYvMxS9ZfWIrlbU7OurwTw1FPL881NYJ3vX6aC8XO3oWBpvyVNEy/z6ieIzpfiL2Zs6QHScpoHIaZj8MMOJigIF6G8HfYpokjKvf0s2R7mIH3z7dNaG/9xmwnwtpuF0deBZeydZmieR7SFKQf6WmemH7MUeLXPVsuqCELbM8BQLMFtpigNUzoMZYn20lUdiMwMeM0kLrXs8QS04HAha/kbX0DDnUO+0PdwjAbO4Dl/nF7gtZza1nRFV9R6Qi8nPB7Qy9ONEeplYJf/TwWZrIaU1/AgMBAAECggEAD5eXRKUbUAcxEX0YvJCXvebCqZPfo+QKljxwaF/+AZdlpTPcyU3qGWyCv56nuSJc1MGLZBV/8cp/n59Wuz6h8gy52pUauXyq5MPleu3PCupdCnwUHKhYcodKTGoR9GPKUb5cO+MGB8njRIsf9iPobU/XrSMJq+Fv9k5s/O1zCPGGZb4Mu7TkqIQSaShQO1mvLXvQ3Bp9CsxdD5SDJs8G2vxZLOlEbChPr7QW4khkN05AVHT8xxc4QUL1IVVf+VrVy68wUs129R4V9BTXojAEu1R9mbkleTWwH50UH/Sd3zQeiQ2MoK7b/kGb5mYqnlDoZnsGtng51Zqff5RPnRDntQKBgQDNV612LWSN5U+z4eS4Q8wDWNftsPnFYTab9r1RfRDtvZuzv7Pc+TpLmWWk/kMMBbaco2luFdTHxg7Xo9fk2rEdLaigE6qz71ulL3/qCaLLdw2sAT3UFKdeQ5d4hRNV1hFLIaX1UXJHT1RsLHIoJzVEHi9rgy+9T+RqUev0jYXqswKBgQDMVuNJlAZjFclhdUcyTTP84k21jKvvVcwpCtHhtZG1XTbMzJt4RaVqvanpo844kYKauPCMdXwIaFgwpV08sa3PGcoQemDx8LUPtyO+f95+msFK57f59qMEoGKUJT1ieKO/SdQr3rySo+Vf1WcP5rOl6HVR6xWtnKkmNuDR4kFoBQKBgE4Yg3tHpk+lH9v9FLzT5Bp9xpm6zjO4VkmY3MXKOA8DJt2FEkX/b6Fi9Np8bUl8PshyCd35ZZSZCfoPcUOzvNqpC9HdyPVoGkXHu/FpusWBQOzjB/3J4SGjuU735bOml6soX/LeCAWA8U221a/ZwZNnm4dbPGPWp7ub7o5y6LSrAoGAYBHJsmIhzpwDngphesjJVG+hUWXdwBx6bCFmI9QVuUsl5Iud3KIB73lUVUBqSDZBTTT+A0uJEPrd26EjgNGYgfICClU/FwCwX78e0wWTObrQfcMLwD2wzxAIyNXpUk6dzeWMF0QVLGxZ/wB6AAPbGnl8DxOTkZhB/nF2qbbSQXECgYEAxKXTRNBY7D95lBEh/ESgxTW7RrXT9swcpgZnT0+ASD2WISfYA9VrRrmyHSm9BZDM0tQpHvylnekXtvla+I6lAXU9WV8A/6WpZsYkA2CUaqC5ILvMwuDJKtZxNWiXK0yCmzKTECCiR4no5n69IONVi2VolxqHgNKpfdX48QhzQbw=";
        
        
        let keyData = Data(base64Encoded: keyBase64)!
        let key = SecKeyCreateWithData(keyData as NSData, [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPrivate,
        ] as NSDictionary, nil)!
        print(key)
        
        
        var institutionDetails : InstitutionModel = InstitutionModel(
            clientId: "IKIA971FB5996EADBD16534494CB87B90D1DB3EAD105",
            clientSecret: "ONcmxGU4B+A+qaHp+/Nw19yO9w117PY36/SxsH1A1Wc=",
            institutionId: 54,
            rsaPublicKey: rsaPubKeyString,
            rsaPrivateKey: rsaPrivateKeyString,
            keyId: "deee79ba-f912-11eb-9a03-0242ac130003")
        
        var accountDetails : AccountModel = AccountModel(
            accountNumber: "4167040082556173",
            cardSerNo: "556173",
            expriyDate: "2506")
        
        
        //generate payload needed to send user an OTP then encrypt it
        do{
            let payload = try generatePayload(accountData: accountDetails)
            encryptPayload(generatedPayload: payload, key: key, publicKey: rsaPubKeyString)
            
        }catch{
            print("Something went wrong while generating payload....")
        }
        
        //API request
        if let url = URL(string: baseUrl){
            
            DispatchQueue.main.async {
                
                URLSession
                    .shared
                    .dataTask(with: url){
                        data, response, error in
                        
                        if let error = error{
                            print(error.localizedDescription)
                        }else{
                            let httpResponse = response as? HTTPURLResponse
                            print("RESPONSE CODE :: \(String(describing: httpResponse?.statusCode))")
                        }
                        
                    }.resume()
            }
        }
    }
    
    
    func sendPostRequest(){
        guard let url = URL(string:"https://testids.interswitch.co.ke/identity/api/v1/web/initialize")
        else{ fatalError() }
        
        //prepare URL request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
      
        // Set HTTP Request Body
        let requestObject: RequestPayloadModel = RequestPayloadModel(institution: Institution(callBackUrl: "www.google.com"), account: Account(accountNumber: "", cardSerialNumber: 556173, expiryDate: "2506", cvv: ""))
        
        //serialize the object
        let encodedData = try? JSONEncoder().encode(requestObject)
        let jsonString = String(data: encodedData!,encoding: .utf8)
        print("\(String(describing: jsonString))")
        
        request.httpBody = encodedData!;

        //perform HTTP Request
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            
            //check for error
            if let error = error {
                print("Error occured while sending request :: \(error.localizedDescription)")
                return
            }
            
            //convert HTTP response data to a string
            if let data = data, let dataString = String(data: data, encoding: .utf8){
                let httpResponse = response as? HTTPURLResponse
                print("RESPONSE CODE :: \(String(describing: httpResponse?.statusCode))")
                print("RESPONSE DATA :: \(dataString)")
            }
        }
        task.resume();
        
    }
    
    func generatePayload(accountData: AccountModel)throws -> String {
        let encoder = JSONEncoder()
        let data = try encoder.encode(accountData)
        let jsonString = String(data: data, encoding: .utf8)!
        
        return jsonString;
    }
    
    func encryptPayload(generatedPayload : String, key: SecKey!, publicKey: String) -> Void{
        
        let encrypter = Encrypter(keyManagementAlgorithm: .RSAOAEP256, contentEncryptionAlgorithm: .A128CBCHS256, encryptionKey: key)!
        do{
            let jwe = try JWE(header: JWEHeader(keyManagementAlgorithm: .RSAOAEP256, contentEncryptionAlgorithm: .A128CBCHS256), payload: Payload(generatedPayload.data(using: .utf8)!), encrypter: encrypter)
            
            print(jwe.compactSerializedString)
            
        }catch{
            print("Something went wrong while encrypting....")
        }
    }
}
