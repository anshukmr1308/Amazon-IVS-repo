//
//  AmazonIVSPlayerViewManager.swift
//  AmazonIVSProject
//
//  Created by macmini on 01/01/25.
//

import Foundation
import AmazonIVSPlayer
import React

@objc(AmazonIVSManager)
class AmazonIVSManager: RCTViewManager {
    private var player: IVSPlayer?

    override func view() -> UIView! {
        let playerView = IVSPlayerView()
        self.player = IVSPlayer()
        playerView.player = self.player
        return playerView
    }

    @objc func loadStream(_ url: String) {
        guard let streamURL = URL(string: url) else { return }
        DispatchQueue.main.async {
            self.player?.load(streamURL)
            self.player?.play()
        }
    }
}

