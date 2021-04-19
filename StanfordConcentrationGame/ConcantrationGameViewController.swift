//
//  ViewController.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 06.04.2021.
//

import UIKit

class ConcantrationGameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var startNewGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    // MARK: - Non private variables
    
    var emoji = [Int:String]()
    lazy var currentTheme = game.currentTheme
    
    var numberOfPairsOfCards: Int {
          return (cardButtons.count + 1) / 2
    }
    
    // MARK: - Private variables
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // MARK: - Private actions
    
    /// Action responsible for logic when any card is touched
    /// - Parameter sender: Pressed cards
    @IBAction private func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateCards()
        }
    }
        
    /// Action responsible for logic of restarting game
    /// - Parameter sender: Restart game butto
    @IBAction private func restartGame(_ sender: UIButton) {
        game.flipCount = 0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        game.delegate = self
        
        currentTheme = game.currentTheme
        emoji.removeAll()
        applyTheme()
        
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = currentTheme.buttonColor
            cardButtons[index].setTitle("", for: UIControl.State.normal)
        }
    }
    
    // MARK: - Instance Methods
    
    /// Function responsible for logic of showing cards for the user while he is playing the game
    private func updateCards() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiChoice(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : currentTheme.buttonColor
            }
        }
    }
    
    /// Function responsible for choosing emoji for a card
    /// - Parameter card: The card that an emoji is choosen for
    /// - Returns: Question mark there is not enough emoji choices
    private func emojiChoice(for card: Card) -> String {
        if emoji[card.identifier] == nil, currentTheme.emojiChoices.count > 0 {
            emoji[card.identifier] = currentTheme.emojiChoices.remove(at: currentTheme.emojiChoices.count.arc4random)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    // MARK: - Updating view methods
    
    /// Applying theme for the view
    private func applyTheme() {
        view.backgroundColor = game.currentTheme.gameBackground
        startNewGameButton.backgroundColor = game.currentTheme.buttonColor
        flipCountLabel.textColor = currentTheme.buttonColor
        
        for index in cardButtons.indices {
            cardButtons[index].backgroundColor = currentTheme.buttonColor
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        game.delegate = self
        applyTheme()
    }
}

// MARK: - ConcentrationDelegate

extension ConcantrationGameViewController: ConcentrationDelegate {
    
    // MARK: - Instance Methods
    
    func concentrationDidChange() {
        flipCountLabel.text = "Flips: " + String(game.flipCount)
    }
}

