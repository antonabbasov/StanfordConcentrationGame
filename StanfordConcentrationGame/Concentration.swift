//
//  Concentration.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 08.04.2021.
//

import UIKit

protocol ConcentrationDelegate {
    
    // MARK: - Instance Methods
    
    func concentrationDidChange()
}

class Concentration {
    
    // MARK: - Non private variables
    
    var delegate: ConcentrationDelegate? = nil
    
    var currentTheme = Theme(emojiChoices: [""], buttonColor: UIColor.orange, gameBackground: UIColor.black) {
        didSet{
            delegate?.concentrationDidChange()
        }
    }
    
    var flipCount = 0 {
        didSet{
            delegate?.concentrationDidChange()
        }
    }
    
    // MARK: - Private variables
    
    private(set) var cards = [Card]()
    private(set) var themes = [Theme]()
    
    private let animalsTheme = Theme(emojiChoices: ["🐱", "🐙", "🐵", "🦄", "🐬", "🦁", "🐗", "🐷", "🦊"], buttonColor: UIColor.green, gameBackground: UIColor.brown)
    private let facesTheme = Theme(emojiChoices: ["😃", "😎", "🥺", "🥳", "🤯", "🥶", "😈", "🤑", "🤠"], buttonColor: UIColor.orange, gameBackground: UIColor.black)
    private let sportTheme = Theme(emojiChoices: ["⚽️", "🏈", "🥊", "🏋🏿‍♀️", "🏄🏿‍♂️", "🚴🏼", "🏓", "🎮", "🚣🏿‍♂️"], buttonColor: UIColor.red, gameBackground: UIColor.purple)
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // MARK: - Class inits
    
    /// Initializes a game with certain amount of cards, shuffles them and adds themes to this cards
    /// - Parameter numberOfPairsOfCards: Amount of pairs of cards
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for index in 0...numberOfPairsOfCards {
            let card =  Card()
            cards += [card, card]
            
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        
        cards.shuffle()
        themes.append(animalsTheme)
        themes.append(sportTheme)
        themes.append(facesTheme)
        createTheme(from: themes)
    }
}

// MARK: - ConcentrationGame

extension Concentration: ConcentrationGame {
    
    // MARK: - Instance Methods
    
    /// Selects random theme from the presented
    /// - Parameter themes: Presented themes
    func createTheme(from themes: [Theme]) {
        if let randomTheme = themes.randomElement() {
            currentTheme = randomTheme
        }
    }
    
    /// Logic of comparing cards for a match
    /// - Parameter index: Last touched card index
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
