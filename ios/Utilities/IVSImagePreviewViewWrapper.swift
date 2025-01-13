//
//  IVSImagePreviewViewWrapper.swift
//  AmazonIVSProject
//
//  Created by macmini on 09/01/25.
//

import Foundation
import SwiftUI
import AmazonIVSBroadcast

struct IVSImagePreviewViewWrapper: UIViewRepresentable {
    let previewView: IVSImagePreviewView?

    func makeUIView(context: Context) -> IVSImagePreviewView {
        guard let view = previewView else {
            fatalError("No actual IVSImagePreviewView passed to wrapper")
        }
        return view
    }

    func updateUIView(_ uiView: IVSImagePreviewView, context: Context) {}
}
