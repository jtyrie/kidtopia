//
//  ViewController.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let cardDeck = CardDeck()
    private var lastSelectedCard: Card?

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ViewController: UICollectionViewDelegate {

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? BuddyCollectionViewCell else {
            return
        }
        cell.flipCardUp()
        
        guard let card = cardDeck.cardAtIndex(indexPath.row) else {
            return
        }
        
        if lastSelectedCard?.isEqualToCard(card) == true {
            // Splat
        } else {
            // Flip back
        }
    }

}


extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return cardDeck.count()
    }
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(BuddyCollectionViewCell.defaultReuseIdentifier,
                                                                         forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        <#code#>
    }
}
