//
//  AudioManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 14.08.25.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSoundWav(name: String) {
    if let url = Bundle.main.url(forResource: name, withExtension: "wav") {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Could not found and playthe sound file", error.localizedDescription)
        }
    }
}
