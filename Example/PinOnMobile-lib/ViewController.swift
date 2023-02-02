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
    var serialNumber:String = "556173";
    var expiryDate: String = "2506";
   
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
        
            
        +++ Section()
            <<< ButtonRow("Launch IPG"){(row: ButtonRow) -> Void in
                row.title = row.tag
                }.onCellSelection{cell,row in
                    
                    let accData: AccountModel = AccountModel(accountNumber: self.accountNumber, cardSerNo: self.serialNumber, expriyDate: self.expiryDate)
                    
                    
                    Task{
                       let respObj =  try await PinOnMobile.instance.initialize(accountData: accData)
                        debugPrint(respObj.callbackUrl)
                        
                        
                        try await PinOnMobile.instance.changePin(initializationResponseObject: respObj, previousUIViewController: self){(completion) in
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


