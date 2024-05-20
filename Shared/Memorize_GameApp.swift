//
//  Memorize_GameApp.swift
//  Shared
//

import SwiftUI

@main
struct Memorize_GameApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var game = EmojiMemoryGameViewModel()

    var body: some Scene {
        WindowGroup {
            GameView(emojiGameViewModel: game)
        }
    }
}
