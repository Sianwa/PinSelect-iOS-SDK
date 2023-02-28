//
//  ViewController.swift
//  PinOnMobile-ios
//
//  Created by x-oauth-basic on 02/01/2023.
//  Copyright (c) 2023 x-oauth-basic. All rights reserved.
//

import UIKit
import Eureka
import PinOnMobile_lib

class ViewController: FormViewController{
    //card variables
    var accountNumber:String = "4167040082556173";
    var serialNumber:String = "4444111";
    var expiryDate: String = "2506";
    var clientID: String = "IKIA971FB5996EADBD16534494CB87B90D1DB3EAD105";
    var clientSecret: String = "ONcmxGU4B+A+qaHp+/Nw19yO9w117PY36/SxsH1A1Wc=";
    var institutionID: Int = 54;
    var callbackURL: String = "www.google.com";
    var keyID: String = "deee79ba-f912-11eb-9a03-0242ac130003";
    var isDebit: Bool = false;
    
    var publicKEY: String =                    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo+eP/jVrcZ5G3A6glDSnY2kpdz67G+3z0Oc0XeI+7kHfdmwyjdC2nalTVyEW4iGLzMUvWX1iK5W1Ozrq8E8NRTy/PNTWCd71+mgvFzt6Fgab8lTRMv8+oniM6X4i9mbOkB0nKaByGmY/DDDiYoCBehvB32KaJIyr39LNke5iB98+3TWhv/cZsJ8LabhdHXgWXsnWZonke0hSkH+lpnph+zFHi1z1bLqghC2zPAUCzBbaYoDVM6DGWJ9tJVHYjMDHjNJC617PEEtOBwIWv5G19Aw51DvtD3cIwGzuA5f5xe4LWc2tZ0RVfUekIvJzwe0MvTjRHqZWCX/08FmayGlNfwIDAQAB";
    var privateKEY: String =                     "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCj54/+NWtxnkbcDqCUNKdjaSl3Prsb7fPQ5zRd4j7uQd92bDKN0LadqVNXIRbiIYvMxS9ZfWIrlbU7OurwTw1FPL881NYJ3vX6aC8XO3oWBpvyVNEy/z6ieIzpfiL2Zs6QHScpoHIaZj8MMOJigIF6G8HfYpokjKvf0s2R7mIH3z7dNaG/9xmwnwtpuF0deBZeydZmieR7SFKQf6WmemH7MUeLXPVsuqCELbM8BQLMFtpigNUzoMZYn20lUdiMwMeM0kLrXs8QS04HAha/kbX0DDnUO+0PdwjAbO4Dl/nF7gtZza1nRFV9R6Qi8nPB7Qy9ONEeplYJf/TwWZrIaU1/AgMBAAECggEAD5eXRKUbUAcxEX0YvJCXvebCqZPfo+QKljxwaF/+AZdlpTPcyU3qGWyCv56nuSJc1MGLZBV/8cp/n59Wuz6h8gy52pUauXyq5MPleu3PCupdCnwUHKhYcodKTGoR9GPKUb5cO+MGB8njRIsf9iPobU/XrSMJq+Fv9k5s/O1zCPGGZb4Mu7TkqIQSaShQO1mvLXvQ3Bp9CsxdD5SDJs8G2vxZLOlEbChPr7QW4khkN05AVHT8xxc4QUL1IVVf+VrVy68wUs129R4V9BTXojAEu1R9mbkleTWwH50UH/Sd3zQeiQ2MoK7b/kGb5mYqnlDoZnsGtng51Zqff5RPnRDntQKBgQDNV612LWSN5U+z4eS4Q8wDWNftsPnFYTab9r1RfRDtvZuzv7Pc+TpLmWWk/kMMBbaco2luFdTHxg7Xo9fk2rEdLaigE6qz71ulL3/qCaLLdw2sAT3UFKdeQ5d4hRNV1hFLIaX1UXJHT1RsLHIoJzVEHi9rgy+9T+RqUev0jYXqswKBgQDMVuNJlAZjFclhdUcyTTP84k21jKvvVcwpCtHhtZG1XTbMzJt4RaVqvanpo844kYKauPCMdXwIaFgwpV08sa3PGcoQemDx8LUPtyO+f95+msFK57f59qMEoGKUJT1ieKO/SdQr3rySo+Vf1WcP5rOl6HVR6xWtnKkmNuDR4kFoBQKBgE4Yg3tHpk+lH9v9FLzT5Bp9xpm6zjO4VkmY3MXKOA8DJt2FEkX/b6Fi9Np8bUl8PshyCd35ZZSZCfoPcUOzvNqpC9HdyPVoGkXHu/FpusWBQOzjB/3J4SGjuU735bOml6soX/LeCAWA8U221a/ZwZNnm4dbPGPWp7ub7o5y6LSrAoGAYBHJsmIhzpwDngphesjJVG+hUWXdwBx6bCFmI9QVuUsl5Iud3KIB73lUVUBqSDZBTTT+A0uJEPrd26EjgNGYgfICClU/FwCwX78e0wWTObrQfcMLwD2wzxAIyNXpUk6dzeWMF0QVLGxZ/wB6AAPbGnl8DxOTkZhB/nF2qbbSQXECgYEAxKXTRNBY7D95lBEh/ESgxTW7RrXT9swcpgZnT0+ASD2WISfYA9VrRrmyHSm9BZDM0tQpHvylnekXtvla+I6lAXU9WV8A/6WpZsYkA2CUaqC5ILvMwuDJKtZxNWiXK0yCmzKTECCiR4no5n69IONVi2VolxqHgNKpfdX48QhzQbw=";

   
    override func viewDidLoad() {
        super.viewDidLoad()
        //CUSTOMER DETAILS SECTION
        form
        +++ Section("Client Details")
            <<< TextRow(){
                row in
                row.title = "Account Number"
                row.placeholder = "accNo"
                row.value = accountNumber
                
            }.onChange({(row) in
                self.accountNumber = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Serial Number"
                row.placeholder = "serNo"
                row.value = serialNumber
                
            }.onChange({(row) in
                    self.serialNumber = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Expiry Date"
                row.placeholder = "expiryDate"
                row.value = expiryDate
                
            }.onChange({(row) in
                    self.expiryDate = row.value != nil ? row.value! : ""
                })
        
            <<< SwitchRow("SwitchRow") {
                row in
                row.title = "Is Debit Card"
                row.value = isDebit
                
            }.onChange { row in
                row.title = (row.value ?? false) ? "Is Debit Card" : "Is Debit Card"
                row.updateCell()
                self.isDebit = row.value!
            }
        
        
        
        +++ Section("Institution Details")
            <<< TextRow(){
                row in
                row.title = "Client ID"
                row.placeholder = "clientID"
                row.value = clientID
                
            }.onChange({(row) in
                self.clientID = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Client Secret"
                row.placeholder = "clientSec"
                row.value = clientSecret
                
            }.onChange({(row) in
                    self.clientSecret = row.value != nil ? row.value! : ""
                })
        
            <<< IntRow(){
                row in
                row.title = "Institution ID"
                row.placeholder = "instID"
                row.value = institutionID
                
            }.onChange({(row) in
                self.institutionID = row.value != nil ? row.value! : 0
                })
        
            <<< TextRow(){
                row in
                row.title = "Callback URL"
                row.placeholder = "callbackURL"
                row.value = callbackURL
                
            }.onChange({(row) in
                    self.callbackURL = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Key ID"
                row.placeholder = "keyID"
                row.value = keyID
                
            }.onChange({(row) in
                    self.keyID = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Public Key"
                row.placeholder = "publicKEY"
                row.value = publicKEY
                
            }.onChange({(row) in
                    self.publicKEY = row.value != nil ? row.value! : ""
                })
        
            <<< TextRow(){
                row in
                row.title = "Private Key"
                row.placeholder = "privateKEY"
                row.value = privateKEY
                
            }.onChange({(row) in
                    self.privateKEY = row.value != nil ? row.value! : ""
                })
        
    
            
        +++ Section()
            <<< ButtonRow("Change PIN"){(row: ButtonRow) -> Void in
                row.title = row.tag
                }.onCellSelection{cell,row in
                    
                    let accData: AccountModel = AccountModel(cardSerNo: self.serialNumber, isDebit: self.isDebit)
                    let instData: InstitutionModel = InstitutionModel(clientId: self.clientID, clientSecret: self.clientSecret, institutionId: self.institutionID, rsaPublicKey: self.publicKEY, rsaPrivateKey: self.privateKEY, keyId: self.keyID, callbackURL: self.callbackURL)
                    
                    
                    Task{
                        
                       let respObj =  try await PinOnMobile.instance.initialize(accountData: accData, institutionData: instData)
                        debugPrint(respObj.callbackUrl)
                        
                        
                        try PinOnMobile.instance.changePin(initializationResponseObject: respObj, previousUIViewController: self){(completion) in
                           self.showResponse(message: completion)
                       }
                }
        }
        
    }
    
    func showResponse(message: String){
        //while showing the response if theres a token it will add the token to the array

        let alert = UIAlertController(title: "Backend Report", message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController:PinOnMobileDelegate{
    func launchUIPayload(_ message: String) {
        self.navigationController?.popToRootViewController(animated: true)
        showResponse(message: message)
    }
}


