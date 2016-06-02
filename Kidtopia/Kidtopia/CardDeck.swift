//
//  CardDeck.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

struct CardDeck {
    
    static let defaultCount = 8
    
    private let buddies = [ Card.Buddy.bouncy,
                            Card.Buddy.cheeky,
                            Card.Buddy.cool,
                            Card.Buddy.cute,
                            Card.Buddy.friendly,
                            Card.Buddy.geek ]
    
    private let actions = [ Card.Action.active,
//                            Card.Action.inactive
    ]
    
    private var cards: [Card] = []
    
    mutating func shuffle() {
        
        cards = buddies.flatMap { buddy in
            self.actions.map { action in
                Card(buddy: buddy, action: action)
            }
        }
        
        cards.shuffleInPlace()
        
        let slice = cards[0 ..< CardDeck.defaultCount / 2]
        
        var newCards = Array(slice) + Array(slice)
        newCards.shuffleInPlace()
        
        cards = newCards
    }
    
    func count() -> Int {
        
        return cards.count
    }
    
    func cardAtIndex(index: Int) -> Card? {
        
        if cards.count < index {
            return nil
        }
        
        return cards[index]
    }
    
}

// Lazily stolen verbatim from http://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift - it's a hack day!
extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
