//
//  Card.swift
//  Kidtopia
//
//  Created by Meadley, Samuel (Developer) on 31/05/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

import Foundation

struct Card {
    
    let buddy: Buddy
    let action: Action
    
    enum Buddy {
        case bouncy
        case cheeky
        case cool
        case cute
        case friendly
        case geek
        
        func filename(action: Action) -> String {
            
            switch action {
            case .inactive:
                return self.description
            case .active:
                return "sky_buddy_\(self.description)_active"
            }
        }
        
        var description: String {
            switch self {
            case .bouncy:
                return "bouncy"
            case .cheeky:
                return "cheeky"
            case .cool:
                return "cool"
            case .cute:
                return "cute"
            case .friendly:
                return "friendly"
            case .geek:
                return "geek"
            }
        }
    }
    
    enum Action {
        case active
        case inactive
    }
    
    init(buddy: Buddy, action: Action) {
        
        self.buddy = buddy
        self.action = action
    }
    
    func isEqualToCard(card: Card) -> Bool {
        
        let isBuddyEqual = card.buddy == self.buddy
        let isActionEqual = card.action == self.action
        
        return isBuddyEqual && isActionEqual
    }
}
