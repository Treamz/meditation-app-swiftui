//
//  meditationApp.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import SwiftUI

@main
struct meditationApp: App {
    @StateObject var audioManager = AudioManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
