//
//  BrowserView.swift
//  PinSelect
//
//  Created by Kelsey Makale on 30/11/2022.
//

import SwiftUI
import WebKit

struct BrowserView: View {
    private let urlString: String = "https://pom-test.interswitch-ke.com/722d6ab4-3979-4eb4-84e1-a1414657c375?callbackUrl=www.google.com"
    
    var body: some View {
        VStack{
            WebView(url: URL(string: urlString)!)
        }
    }
}

struct WebView: UIViewRepresentable{
    var url:URL
    
    func makeUIView(context: Context) ->WKWebView{
        return WKWebView(frame: CGRect(x: 0.0, y: 0.0, width: 0.1, height: 0.1))
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct BrowserView_Previews: PreviewProvider {
    static var previews: some View {
        BrowserView()
    }
}
