//
//  LoadingView.swift
//  PinSelect
//
//  Created by Kelsey Makale on 30/11/2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
