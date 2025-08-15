//
//  AudioManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 14.08.25.
//
 
import AVFoundation

class AudioManager {
    static var audioPlayer: AVAudioPlayer?
    
    static func playSound(name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "wav") {
               do {
                   audioPlayer = try AVAudioPlayer(contentsOf: url)
                   audioPlayer?.play()
               } catch {
                   print("Səs faylı açıla bilmədi:", error.localizedDescription)
               }
           } else {
               print("Fayl tapılmadı.")
           }
        }
}
