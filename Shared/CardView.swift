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
                Pie(endAngle: .degrees(240))
                    .opacity(Constants.Pie.opacity)
                    .overlay(
                        Text(card.content)
                            .font(.system(size: Constants.FontSize.largest))
                        .minimumScaleFactor(Constants.FontSize.scaleFactor)
                        .multilineTextAlignment(.center)
                    )
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
        static let inset: CGFloat = 4
        
        struct FontSize {
            static let largest: CGFloat = 50
            static let smallest: CGFloat = 5
            static let scaleFactor = smallest / largest
        }
        
        struct Pie {
            static let opacity = 0.8
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    CardView(MemoryGame<String>.Card(isFaceUp: true, content: "💙", id: "B"))
}
