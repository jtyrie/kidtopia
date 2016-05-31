//
//  ViewController.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var cardDeck = CardDeck()
    private var indexPathForLastSelectedItem: NSIndexPath?
    
    override func viewDidLoad() {
        
        cardDeck.shuffle()
    }
    
}


extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? BuddyCollectionViewCell else {
            return
        }
        
        guard let card = cardDeck.cardAtIndex(indexPath.row) else {
            return
        }
    
        if indexPathForLastSelectedItem != nil {
            
            guard let indexPathForLastSelectedItem = indexPathForLastSelectedItem else {
                return
            }
            
            let lastSelectedCard = cardDeck.cardAtIndex(indexPathForLastSelectedItem.item)
            
            if lastSelectedCard?.isEqualToCard(card) == true {
                
                // Splat
                cell.flipCardUp(nil);
                self.indexPathForLastSelectedItem = nil
                
            } else {
                cell.flipCardUp({ finished in
                    cell.flipCardDown()
                    
                    let lastSelectedCell = collectionView.cellForItemAtIndexPath(indexPathForLastSelectedItem) as? BuddyCollectionViewCell
                    lastSelectedCell?.flipCardDown()
                    
                    self.indexPathForLastSelectedItem = nil
                })
            }
            
        } else {
            
            cell.flipCardUp(nil);
            indexPathForLastSelectedItem = indexPath
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
        
        if let cell = cell as? BuddyCollectionViewCell {
            
            if let card = cardDeck.cardAtIndex(indexPath.row) {
                
                // TODO: Fix this so card.action doesn't need to be passed back to card.buddy.filename.
                cell.frontImageView.image = UIImage(named: card.buddy.filename(card.action))
            }
        }
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath)
        
        return view
    }
}
