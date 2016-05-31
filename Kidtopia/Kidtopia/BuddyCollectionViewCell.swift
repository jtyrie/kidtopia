//
//  BuddyCollectionViewCell.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

class BuddyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  var backImageView: UIImageView!
    
    @IBOutlet  var frontImageView: UIImageView!
    
    static let defaultReuseIdentifier = String(BuddyCollectionViewCell)
    
    override func awakeFromNib() {
        frontImageView?.hidden = true
    }
    
    func flipCardUp(completion: ((Bool) -> Void)?) {
        if(frontImageView.hidden){
            UIView.transitionFromView(backImageView, toView: frontImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: completion)
            frontImageView?.hidden = false
        }
    }
    
    func flipCardDown() {
        if(!frontImageView.hidden){
            UIView.transitionFromView(frontImageView, toView: backImageView, duration: 1, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
            frontImageView?.hidden = true
        }
    }
    func splashCell() {
        let frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
        let splatView = UIImageView(frame: frame)
        
        splatView.image = UIImage(named: "splat")
        contentView.addSubview(splatView)
    }
}
