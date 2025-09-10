//
//  AudioManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 14.08.25.
//

import AVFoundation
import AudioToolbox

var soundID: SystemSoundID = 0

func playSoundWav(name: String, ext: String = "wav") {
    if let url = Bundle.main.url(forResource: name, withExtension: ext) {
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    } else {
        print("Sound file not found")
    }
}
