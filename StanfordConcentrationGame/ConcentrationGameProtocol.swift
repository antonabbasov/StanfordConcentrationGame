//
//  ConcentrationGameProtocol.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 20.04.2021.
//

import Foundation

/// Represent open functionality of the concentration game
protocol ConcentrationGame {
    
    // MARK: - Instance Methods
    
    func chooseCard(at index: Int)
    func createTheme(from themes: [Theme])
}
