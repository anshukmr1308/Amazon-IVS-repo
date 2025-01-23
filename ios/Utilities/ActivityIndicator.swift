//
//  ActivityIndicator.swift
//  AmazonIVSProject
//
//  Created by macmini on 08/01/25.
//

import Foundation
import SwiftUI

struct ActivityIndicator: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Text("")
                    .frame(width: UIScreen.main.bounds.width,
                           height: UIScreen.main.bounds.height,
                           alignment: .center)
                    .background(Color.black.opacity(0.5))

                ProgressView() {
                    Text("Please wait")
                        .modifier(Description())
                }
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.white)
            }
        }
    }
}
