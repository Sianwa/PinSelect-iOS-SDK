//
//  ContentView.swift
//  PinSelect
//
//  Created by Kelsey Makale on 30/11/2022.
//

import SwiftUI
import PinOnMobile_lib

struct ContentView: View {
    @State private var serviceIsStarting = false;
    @State private var showWebView = false;
    @State private var url: String?
    @State private var uuid: String?
    
    @State private var accountNumber = "4167040008053057"
    @State private var cardSerNo = "053057"
    @State private var expiryDate = "2508"
    @State private var cardCVV = ""
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                   
                    if #available(iOS 14.0, *) {
                        Form{
                            Section(header: Text("Card details")){
                                TextField("Account Number", text: $accountNumber).keyboardType(.phonePad)
                                TextField("Serial Number", text: $cardSerNo).keyboardType(.phonePad)
                                TextField("Expiry Date", text: $expiryDate).keyboardType(.phonePad)
                            }
                        }
                        .navigationTitle("Account Details")
                    } else {
                        // Fallback on earlier versions
                        Text("Account Details")
                            .font(.title)
                        
                        Form{
                            Section(header: Text("Card details")){
                                TextField("Account Number", text: $accountNumber).keyboardType(.phonePad)
                                TextField("Serial Number", text: $cardSerNo).keyboardType(.phonePad)
                                TextField("Expiry Date", text: $expiryDate).keyboardType(.phonePad)
                            }
                        }
                    }
                   
                   
                    
                    Button(action:startService, label: {
                        Text("Change PIN")
                            .frame(width: 250, height: 50,alignment: .center).background(Color.blue).foregroundColor(.white).cornerRadius(8)
                    }).padding()
                }
                

            }
        }
    }
    
    func startService(){
        print("Initializing service......")
        self.serviceIsStarting = true
        
        do{
        
            Task{
                
                let accounts: AccountModel = AccountModel(accountNumber: accountNumber,
                                                          cardSerNo: cardSerNo,
                                                          expriyDate: expiryDate)
                
                let response = try await PinOnMobile.instance.initialize(accountData: accounts)
                debugPrint(response.callbackUrl)
                
            }
       
        }catch{
            print(error)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
