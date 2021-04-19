//
//  Card.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 08.04.2021.
//

import Foundation

/// Represent single card for concentration game
struct Card {
    
    // MARK: - Non private variables
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    // MARK: - Private variables
    
    private static var identifierFactory = 0
    
    /// Gets unique identifier for each card
    /// - Returns: Unique identifier
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    // MARK: - Initialization
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

// MARK: - Extensions

extension Card: Hashable {
    
    // MARK: - Instance Methods
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
