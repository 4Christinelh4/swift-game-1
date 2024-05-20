//
//  GameViewModel.swift
//  Memorize Game
//
//  Created by yuweiL on 16/5/24.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    
    private static let emojiTheme = ["🍒", "🥑", "🫐", "🌶", "🍠", "🍊", "🍇", "🍑", "🍉"]
    
    private static func createGameView() -> MemoryGame<String> {
        return MemoryGame(numOfPairsOfCards: 6, cardContentFactory:  {
            pIdx in
            
            if emojiTheme.indices.contains(pIdx) {
                return emojiTheme[pIdx]
            }
            return "👽"
        })
    }
    
//    var objectWillChange: ObservableObjectPublisher
    
    @Published private var model = createGameView()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
}
