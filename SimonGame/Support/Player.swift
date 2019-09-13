//
//  Player.swift
//  SimonGame
//
//  Created by Giulio Gola on 12/09/2019.
//  Copyright © 2019 Giulio Gola. All rights reserved.
//

import UIKit
import AVFoundation

class Player: UIViewController, AVAudioPlayerDelegate {
    
    private var audioPlayer : AVAudioPlayer!
    
    func playSound(of button: String) {
        let soundURL = Bundle.main.url(forResource: "Sounds/\(button)", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    func playSoundOfGameOver() {
        let soundURL = Bundle.main.url(forResource: "Sounds/wrong", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print(error)
        }
        audioPlayer.play()
    }
    
    
}
