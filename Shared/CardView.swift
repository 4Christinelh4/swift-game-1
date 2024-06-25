//
//  CardView.swift
//  Memorize Game
//
//  Created by yuweiL on 25/6/2024.
//

import SwiftUI

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: Constants.lineWidth)
                Text(card.content)
                    .font(.largeTitle)
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
                    .multilineTextAlignment(.center)
                    .padding(Constants.inset)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base
            .fill()
            .opacity(card.isFaceUp ? 0 : 1)
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 3
        static let inset: CGFloat = 5
        
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
    }
}

#Preview {
    CardView(MemoryGame<String>.Card(isFaceUp: true, content: "🩵", id: "A"))
}
