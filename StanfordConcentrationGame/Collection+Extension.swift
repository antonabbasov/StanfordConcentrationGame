//
//  Collection+Extension.swift
//  StanfordConcentrationGame
//
//  Created by Anton on 20.04.2021.
//

import Foundation

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first: nil
    }
}
