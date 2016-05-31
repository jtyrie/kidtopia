//
//  BuddyCollectionViewCell.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit
import AVFoundation

class BuddyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var frontImageView: UIImageView!
    
    static let defaultReuseIdentifier = String(BuddyCollectionViewCell)
    
    var player: AVAudioPlayer?
    
    override func awakeFromNib() {
        frontImageView?.hidden = true
    }
    
    enum SoundType {
        
        case up
        case down
        case splash
        
        var url: NSURL {
            switch self {
            case up:
                return NSBundle.mainBundle().URLForResource("channel_picker_up", withExtension: "aiff")!
            case down:
                return NSBundle.mainBundle().URLForResource("channel_picker_down", withExtension: "aiff")!
            case splash:
                return NSBundle.mainBundle().URLForResource("select_show_episode", withExtension: "caf")!
            }
        }
    }
    
    func playSound(soundURL: NSURL) {
        
        do {
            player = try AVAudioPlayer(contentsOfURL: soundURL)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }

    }
    
    func flipCardUp(completion: ((Bool) -> Void)?) {
        if(frontImageView.hidden){
            playSound(SoundType.up.url)
            UIView.transitionFromView(backImageView, toView: frontImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: completion)
            frontImageView?.hidden = false
        }
    }
    
    func flipCardDown() {
        if(!frontImageView.hidden){
            playSound(SoundType.down.url)
            UIView.transitionFromView(frontImageView, toView: backImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            frontImageView?.hidden = true
        }
    }
    
    func splashCell() {
        let frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        let splatView = UIImageView(frame: frame)
        
        playSound(SoundType.splash.url)
        splatView.image = UIImage(named: "splat")

        contentView.insertSubview(splatView, atIndex: 0)
    }
}
