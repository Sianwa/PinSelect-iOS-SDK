//
//  ContentView.swift
//  PinSelect
//
//  Created by Kelsey Makale on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var serviceIsStarting = false;
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Initiate Service..")
                    .padding()
                
                NavigationLink(destination: BrowserView(), isActive: $serviceIsStarting) {EmptyView()}
                
                Button("START", action:startService)
                    .frame(height: 65).frame(maxWidth: .infinity)
            }
        }
    }
    
    func startService(){
        print("Initializing service......")
        self.serviceIsStarting = true
        
        //todo: make network request here
        initializeService()
    }
    
    func initializeService(){
        //create objects
        let rsaPubKeyString = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo+eP/jVrcZ5G3A6glDSnY2kpdz67G+3z0Oc0XeI+7kHfdmwyjdC2nalTVyEW4iGLzMUvWX1iK5W1Ozrq8E8NRTy/PNTWCd71+mgvFzt6Fgab8lTRMv8+oniM6X4i9mbOkB0nKaByGmY/DDDiYoCBehvB32KaJIyr39LNke5iB98+3TWhv/cZsJ8LabhdHXgWXsnWZonke0hSkH+lpnph+zFHi1z1bLqghC2zPAUCzBbaYoDVM6DGWJ9tJVHYjMDHjNJC617PEEtOBwIWv5G19Aw51DvtD3cIwGzuA5f5xe4LWc2tZ0RVfUekIvJzwe0MvTjRHqZWCX/08FmayGlNfwIDAQAB";
        
        let rsaPrivateKeyString = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCj54/+NWtxnkbcDqCUNKdjaSl3Prsb7fPQ5zRd4j7uQd92bDKN0LadqVNXIRbiIYvMxS9ZfWIrlbU7OurwTw1FPL881NYJ3vX6aC8XO3oWBpvyVNEy/z6ieIzpfiL2Zs6QHScpoHIaZj8MMOJigIF6G8HfYpokjKvf0s2R7mIH3z7dNaG/9xmwnwtpuF0deBZeydZmieR7SFKQf6WmemH7MUeLXPVsuqCELbM8BQLMFtpigNUzoMZYn20lUdiMwMeM0kLrXs8QS04HAha/kbX0DDnUO+0PdwjAbO4Dl/nF7gtZza1nRFV9R6Qi8nPB7Qy9ONEeplYJf/TwWZrIaU1/AgMBAAECggEAD5eXRKUbUAcxEX0YvJCXvebCqZPfo+QKljxwaF/+AZdlpTPcyU3qGWyCv56nuSJc1MGLZBV/8cp/n59Wuz6h8gy52pUauXyq5MPleu3PCupdCnwUHKhYcodKTGoR9GPKUb5cO+MGB8njRIsf9iPobU/XrSMJq+Fv9k5s/O1zCPGGZb4Mu7TkqIQSaShQO1mvLXvQ3Bp9CsxdD5SDJs8G2vxZLOlEbChPr7QW4khkN05AVHT8xxc4QUL1IVVf+VrVy68wUs129R4V9BTXojAEu1R9mbkleTWwH50UH/Sd3zQeiQ2MoK7b/kGb5mYqnlDoZnsGtng51Zqff5RPnRDntQKBgQDNV612LWSN5U+z4eS4Q8wDWNftsPnFYTab9r1RfRDtvZuzv7Pc+TpLmWWk/kMMBbaco2luFdTHxg7Xo9fk2rEdLaigE6qz71ulL3/qCaLLdw2sAT3UFKdeQ5d4hRNV1hFLIaX1UXJHT1RsLHIoJzVEHi9rgy+9T+RqUev0jYXqswKBgQDMVuNJlAZjFclhdUcyTTP84k21jKvvVcwpCtHhtZG1XTbMzJt4RaVqvanpo844kYKauPCMdXwIaFgwpV08sa3PGcoQemDx8LUPtyO+f95+msFK57f59qMEoGKUJT1ieKO/SdQr3rySo+Vf1WcP5rOl6HVR6xWtnKkmNuDR4kFoBQKBgE4Yg3tHpk+lH9v9FLzT5Bp9xpm6zjO4VkmY3MXKOA8DJt2FEkX/b6Fi9Np8bUl8PshyCd35ZZSZCfoPcUOzvNqpC9HdyPVoGkXHu/FpusWBQOzjB/3J4SGjuU735bOml6soX/LeCAWA8U221a/ZwZNnm4dbPGPWp7ub7o5y6LSrAoGAYBHJsmIhzpwDngphesjJVG+hUWXdwBx6bCFmI9QVuUsl5Iud3KIB73lUVUBqSDZBTTT+A0uJEPrd26EjgNGYgfICClU/FwCwX78e0wWTObrQfcMLwD2wzxAIyNXpUk6dzeWMF0QVLGxZ/wB6AAPbGnl8DxOTkZhB/nF2qbbSQXECgYEAxKXTRNBY7D95lBEh/ESgxTW7RrXT9swcpgZnT0+ASD2WISfYA9VrRrmyHSm9BZDM0tQpHvylnekXtvla+I6lAXU9WV8A/6WpZsYkA2CUaqC5ILvMwuDJKtZxNWiXK0yCmzKTECCiR4no5n69IONVi2VolxqHgNKpfdX48QhzQbw=";
        
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
        
        
        //todo: create instance of library class and send details to backend.
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
