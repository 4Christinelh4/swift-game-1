//
//  Memorize_GameApp.swift
//  Shared
//
//  Created by yuweiL on 16/5/24.
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
