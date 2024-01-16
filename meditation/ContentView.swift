//
//  ContentView.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MeditationView(meditationVM: MeditationViewModel(meditation: Meditation.data))
    }
}

#Preview {
    ContentView()
        .environmentObject(AudioManager())
}
