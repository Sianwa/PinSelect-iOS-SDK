//
//  ContentView.swift
//  PinSelect
//
//  Created by Kelsey Makale on 30/11/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var serviceIsStarting = false;
    @StateObject private var vm = InitializeViewModel()
    
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
        vm.getSample()
        
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
