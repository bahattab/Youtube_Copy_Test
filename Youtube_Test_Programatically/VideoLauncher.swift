//
//  VideoLauncher.swift
//  Youtube_Test_Programatically
//
//  Created by Fernando Cardenas on 13/08/16.
//  Copyright © 2016 Fernando. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blackColor()
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        
        if let url = NSURL(string: urlString) {
            let player = AVPlayer(URL: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncer: NSObject {
    
    func showVideoPlayer() {
        print("Showing video player animation")
        
        if let keyWindow = UIApplication.sharedApplication().keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.whiteColor()

            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height, width: 10, height: 10)
            
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                    view.frame = keyWindow.frame
                }, completion: { (completedAnimation) in
                    //Hide Status Bar
                    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Fade)
            })
        }
    }
}
