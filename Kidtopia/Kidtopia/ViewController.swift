//
//  ViewController.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView?

    private var cardDeck = CardDeck()
    private var indexPathForLastSelectedItem: NSIndexPath?
    
    override func viewDidLoad() {
        
        cardDeck.shuffle()
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func restart(sender: UIButton) {
        
        guard let indexPathsForVisibleItems = collectionView?.indexPathsForVisibleItems() else {
            return
        }
        
        for indexPath in indexPathsForVisibleItems {
            
            guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) as? BuddyCollectionViewCell else {
                continue
            }
            
            cell.removeSplashCell()
            cell.flipCardDown()
        }
        
        self.cardDeck.shuffle()
        self.indexPathForLastSelectedItem = nil
        collectionView?.reloadData()
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
            let lastSelectedCell = collectionView.cellForItemAtIndexPath(indexPathForLastSelectedItem) as? BuddyCollectionViewCell
            if lastSelectedCard?.isEqualToCard(card) == true {
                cell.flipCardUp({ finished in
                    cell.splashCell()
                    lastSelectedCell?.splashCell()
                });
                self.indexPathForLastSelectedItem = nil
                
                // Splat
                
                
            } else {
                cell.flipCardUp({ finished in
                    cell.flipCardDown()
                    
                    //let lastSelectedCell = collectionView.cellForItemAtIndexPath(indexPathForLastSelectedItem) as? BuddyCollectionViewCell
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
    
    func collectionView(collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                                                          atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var view: UICollectionReusableView
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: "header",
                                                                         forIndexPath: indexPath)
        case UICollectionElementKindSectionFooter:
            view = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter,
                                                                         withReuseIdentifier: "bottom",
                                                                         forIndexPath: indexPath)
            
        default:
            view = UICollectionReusableView()
        }
        
        return view
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: 290, height: 290)
    }
}
