//
//  MusicManager.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/29.
//

import UIKit
import AVKit
import AVFoundation

class MusicManager: NSObject {
    
    func secondMusic() -> Void {
        var soundID: SystemSoundID = 0
        let soundFile = Bundle.main.path(forResource: "1s", ofType: "m4a")
        AudioServicesCreateSystemSoundID(URL(fileURLWithPath: soundFile!) as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    func endMusic() -> Void {
        var soundID: SystemSoundID = 0
        let soundFile = Bundle.main.path(forResource: "end", ofType: "m4a")
        AudioServicesCreateSystemSoundID(URL(fileURLWithPath: soundFile!) as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
    func nightMusic() -> Void {
        
    }
}
