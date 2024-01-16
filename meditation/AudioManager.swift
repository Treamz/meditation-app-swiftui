//
//  AudioManager.swift
//  meditation
//
//  Created by Иван Чернокнижников on 16.01.2024.
//

import Foundation
import AVKit


final class AudioManager : ObservableObject{
    static let shared = AudioManager()
    
    @Published private(set) var isLooping: Bool = false
    @Published var player: AVAudioPlayer?
    
    @Published private(set) var isPlaying: Bool = false {
        didSet {
            print("isPlaying:",isPlaying)
        }
    }
    
    func startPlayer(track: String, isPreview: Bool = false) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            try player = AVAudioPlayer(contentsOf: url)
            if isPreview {
                player?.prepareToPlay()
            } else {
                player?.play()
                isPlaying = true

            }
        } catch {
            print("Fail to init player",error)
        }
    }
    
    func playPause() {
        guard let player = player else {
            return
        }
        if(player.isPlaying) {
            isPlaying = false
            player.pause()
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    func stop() {
        guard let player = player else {
            return
        }
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func toggleLoop() {
        guard let player = player else {
            return
        }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
        print("isLooping",isLooping)
    }
}
