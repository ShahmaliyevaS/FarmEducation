//
//  HapticManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 15.08.25.
//

import UIKit

func playNotificationHaptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
}
