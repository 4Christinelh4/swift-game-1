//
//  ContentView.swift
//  Shared
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGameViewModel: EmojiMemoryGameViewModel
    var aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .foregroundColor(emojiGameViewModel.color)
                .animation(.default, value: emojiGameViewModel.cards)
            
            Button("Shuffle") {
                emojiGameViewModel.shuffle()
            }
        }.padding()
    }
    
    private var cards: some View {
        AspectVGrid(aspectRatio_: aspectRatio, emojiGameViewModel.cards) {
            card_ in
            
            CardView(card_)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    emojiGameViewModel.choose(card_)
                }
        }.foregroundColor(Color.orange)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiGameViewModel: EmojiMemoryGameViewModel())
    }
}

