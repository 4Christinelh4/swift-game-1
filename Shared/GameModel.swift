//
//  GameModel.swift
//  Memorize Game
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private (set) var cards: Array<Card>
    
    init (numOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIdx in 0..<numOfPairsOfCards {
            let content = cardContentFactory(pairIdx)
            cards.append(Card(content: content, id: "\(pairIdx)a"))
            cards.append(Card(content: content, id: "\(pairIdx)b"))
        }
    }
    
    var revealedCard: Int? {
        get {
            return cards.indices.filter{i in cards[i].isFaceUp }.only
        }
        set {
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenCardIdx = cards.firstIndex(where: {idx in
            idx.id == card.id }) {
            if !cards[chosenCardIdx].matched && !cards[chosenCardIdx].isFaceUp {
                if let potentialMatchedIdx = revealedCard {
                    if cards[chosenCardIdx].content == cards[potentialMatchedIdx].content {
                        cards[chosenCardIdx].matched = true
                        cards[potentialMatchedIdx].matched = true
                    }
                } else {
                    revealedCard = chosenCardIdx
                }
                
                cards[chosenCardIdx].isFaceUp = true
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable {
        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
            return lhs.isFaceUp == rhs.isFaceUp
            && lhs.matched == rhs.matched && lhs.content == rhs.content
        }
        
        var isFaceUp =  false
        var matched = false
        let content: CardContent
        
        var id: String
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
