//
//  ContentView.swift
//  Shared
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGameViewModel: EmojiMemoryGameViewModel
    
    var aspectRatio: CGFloat = 3/4
    var body: some View {
        VStack {
            cards.animation(.default, value: emojiGameViewModel.cards
            )
            
            Button("Shuffle") {
                emojiGameViewModel.shuffle()
            }
        }.padding()
    }
    
    private var cards: some View {
        AspectVGrid(aspectRatio_: aspectRatio, allitems: emojiGameViewModel.cards) {
            card_ in
            
            CardView(card_)
                .aspectRatio(aspectRatio, contentMode: .fit)
                .padding(6)
                .onTapGesture {
                    emojiGameViewModel.choose(card_)
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(emojiGameViewModel: EmojiMemoryGameViewModel())
    }
}

