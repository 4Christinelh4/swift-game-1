//
//  ContentView.swift
//  Shared
//

import SwiftUI

struct GameView: View {
    @ObservedObject var emojiGameViewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        VStack {
            cards.animation(.default, value: emojiGameViewModel.cards
            )
            
            Button("Shuffle") {
                emojiGameViewModel.shuffle()
            }
        }.padding()
    }
    
    var cards: some View {
        GeometryReader {
            geometry in
            let gridItemSize = gridItemWidthThatFits(count: emojiGameViewModel.cards.count, size: geometry.size, atAspectRatio: 3/4)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(emojiGameViewModel.cards) {
                    card_ in
                    CardView(card_).aspectRatio(3/4, contentMode: .fit)
                        .padding(6)
                        .onTapGesture {
                            emojiGameViewModel.choose(card_)
                        }
                }
            }.foregroundColor(.orange)
        }
    }
    
    func gridItemWidthThatFits(count: Int, size: CGSize
                               , atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return width.rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        
        return 80
    }
}

struct CardView: View{
    var card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
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
        GameView(emojiGameViewModel: EmojiMemoryGameViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

