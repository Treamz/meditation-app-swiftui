//
//  PlayerView.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var audioManager: AudioManager
    var meditationVM: MeditationViewModel
    var isPreview : Bool = false
    @State private var value: Double = 0.0
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) var dismiss
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    var body: some View {
        ZStack {
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                HStack {
                    Button {
                        audioManager.stop()
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                Text(meditationVM.meditation.title)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                Spacer()
                if let player = audioManager.player  {
                    VStack(spacing: 5) {
                        
                        Slider(value: $value, in: 0...player.duration) {
                            editing in
                            isEditing = editing
                            if(!editing) {
                                player.currentTime = value
                            }
                        }
                            .accentColor(.white)
                        
                        // Playback Time
                        HStack {
                            Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                            Spacer()
                            Text(DateComponentsFormatter.positional.string(from: player.duration -  player.currentTime) ?? "0:00")
                        }
                        .font(.caption)
                        .foregroundColor(.white)
                        
                    }
                    HStack {
                        // Repeat Button
                        let color: Color = audioManager.isLooping ? .teal : .white
                        PlaybackControlButton(systemName: "repeat",color: color) {
                            audioManager.toggleLoop()
                            
                        }
                        Spacer()
                        PlaybackControlButton(systemName: "gobackward.10") {
                            player.currentTime -= 10
                            
                        }
                        Spacer()

                        PlaybackControlButton(systemName: audioManager.isPlaying ? "pause.circle.fill":"play.circle.fill" ,fontSize: 44) {
                            
                            audioManager.playPause()
                            
                        }
                        Spacer()

                        PlaybackControlButton(systemName: "forward") {
                            player.currentTime += 10
                            
                        }
                        Spacer()

                        
                        PlaybackControlButton(systemName: "stop.fill") {
                            audioManager.stop()
                            dismiss()

                            
                        }
                    }
                    
                }
             
             
                
            }
            .padding(.horizontal, 20)

        }.onAppear {
           audioManager.startPlayer(track: meditationVM.meditation.track,isPreview: isPreview)
        }
        .onReceive(timer, perform: { _ in
            guard let player = audioManager.player, !isEditing else {return}
            value = player.currentTime
        })
    }
    
   
}

#Preview {
    PlayerView(meditationVM: MeditationViewModel(meditation: Meditation.data),isPreview: true)
        .environmentObject(AudioManager())
}
