//
//  Int+Extension.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 20.04.2021.
//

import UIKit

extension Int {
    
    // MARK: - Instance properties
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

