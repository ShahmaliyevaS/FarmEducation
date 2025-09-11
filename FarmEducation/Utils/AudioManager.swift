//
//  AudioManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 14.08.25.
//

import AVFoundation
import SwiftUI

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    var player: AVAudioPlayer?

    @Published var volume: Float = 0.5 {
        didSet {
            player?.volume = volume
        }
    }

    func play(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = volume
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Error: \(error)")
        }
    }
}
