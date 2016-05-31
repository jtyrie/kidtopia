//
//  CardDeck.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

struct CardDeck {
    
    static let defaultCount = 6
    
    var cards = [ Card(buddy: Card.Buddy.bouncy, action: Card.Action.active),
                  Card(buddy: Card.Buddy.cheeky, action: Card.Action.active),
                  Card(buddy: Card.Buddy.cool, action: Card.Action.active),
                  Card(buddy: Card.Buddy.cute, action: Card.Action.active),
                  Card(buddy: Card.Buddy.friendly, action: Card.Action.active),
                  Card(buddy: Card.Buddy.geek, action: Card.Action.active),
                  
                  Card(buddy: Card.Buddy.bouncy, action: Card.Action.inactive),
                  Card(buddy: Card.Buddy.cheeky, action: Card.Action.inactive),
                  Card(buddy: Card.Buddy.cool, action: Card.Action.inactive),
                  Card(buddy: Card.Buddy.cute, action: Card.Action.inactive),
                  Card(buddy: Card.Buddy.friendly, action: Card.Action.inactive),
                  Card(buddy: Card.Buddy.geek, action: Card.Action.inactive)]
    
    
    func shuffle() {
        
        // TODO: 
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

