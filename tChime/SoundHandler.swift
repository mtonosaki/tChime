//
//  SoundHandler.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/04/08.
//

import Foundation
import AVFoundation

final class SoundHandler {
    public static let shared = SoundHandler()
    private let fileUrl: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "tChime", ofType: "caf")!)
    private init() { }

    public func play() {
        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(self.fileUrl as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
        AudioServicesRemoveSystemSoundCompletion(soundID)
    }
}
