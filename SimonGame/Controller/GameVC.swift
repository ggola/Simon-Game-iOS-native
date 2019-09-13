//
//  ViewController.swift
//  SimonGame
//
//  Created by Giulio Gola on 12/09/2019.
//  Copyright © 2019 Giulio Gola. All rights reserved.
//

import UIKit
import AVFoundation

class GameVC: UIViewController, AVAudioPlayerDelegate {
    
    private var audioPlayer : AVAudioPlayer!
    
    private let player = Player()
    private let animation = Animation()
    
    private let buttonSounds = ["green", "red", "yellow", "cian"]
    private let green = UIColor(red: 0 / 255, green: 177 / 255, blue: 3 / 255, alpha: 1.0)
    private let red = UIColor(red: 197 / 255, green: 2 / 255, blue: 13 / 255, alpha: 1.0)
    private let yellow = UIColor(red: 207 / 255, green: 189 / 255, blue: 0 / 255, alpha: 1.0)
    private let cian = UIColor(red: 0 / 255, green: 195 / 255, blue: 255 / 255, alpha: 1.0)
    private var tap = UIGestureRecognizer()
    
    var level: Int = 1
    var buttonSequence: [Int] = [Int]()
    var counter = 1
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var greenButton: UIButton!   // tag = 1
    @IBOutlet weak var redButton: UIButton!     // tag = 2
    @IBOutlet weak var yellowButton: UIButton!  // tag = 3
    @IBOutlet weak var cianButton: UIButton!    // tag = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableButtons(state: false)
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector(startGame))
        tap = tapScreen
        self.view.addGestureRecognizer(tapScreen)
    }
    
    @objc func startGame() {
        resetGame()
        self.view.removeGestureRecognizer(tap)
        enableButtons(state: true)
        setTitleLabel(with: "LEVEL \(level)", size: 25, color: UIColor.white)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.pickButton()
        }
    }
    
    private func resetGame() {
        level = 1
        buttonSequence = []
        counter = 1
    }
    
    private func pickButton() {
        let n = Int.random(in: 1..<5)   // Picks one of the buttons' tag: 1, 2, 3 or 4
        player.playSound(of: buttonSounds[n - 1])
        animateButton(tag: n)
        buttonSequence.append(n)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        player.playSound(of: buttonSounds[sender.tag - 1])
        animateButton(tag: sender.tag)
        check(pressedTag: sender.tag)
    }
    
    private func check(pressedTag: Int) {
        enableButtons(state: false)
        let correctTag = buttonSequence[counter - 1]
        if (pressedTag != correctTag) {
            gameOver()
        } else {
            if (counter == buttonSequence.count) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.setTitleLabel(with: "YOU HERO!", size: 30, color: UIColor.green)
                    self.nextLevel()
                    self.enableButtons(state: true)
                }
            } else {
                counter += 1
                self.enableButtons(state: true)
            }
        }
    }
    
    private func nextLevel() {
        level += 1
        counter = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.setTitleLabel(with: "LEVEL \(self.level)", size: 25, color: UIColor.white)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.pickButton()
            })
        }
    }
    
    private func enableButtons(state: Bool) {
        greenButton.isEnabled = state
        redButton.isEnabled = state
        yellowButton.isEnabled = state
        cianButton.isEnabled = state
    }
    
    private func animateButton(tag: Int) {
        switch tag {
        case 1:
            animation.animate(button: greenButton, color: green)
        case 2:
            animation.animate(button: redButton, color: red)
        case 3:
            animation.animate(button: yellowButton, color: yellow)
        case 4:
            animation.animate(button: cianButton, color: cian)
        default:
            print("No button to animate")
        }
    }
    
    private func gameOver() {
        player.playSoundOfGameOver()
        enableButtons(state: false)
        self.view.addGestureRecognizer(tap)
        titleLabel.attributedText = gameOverLabel()
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.red
            UIView.animate(withDuration: 0.4) {
                self.view.backgroundColor = UIColor(red: 3 / 255, green: 17 / 255, blue: 131 / 255, alpha: 1.0)
            }
        }
    }
    
    private func setTitleLabel(with text: String, size: CGFloat, color: UIColor) {
        self.titleLabel.text = text
        self.titleLabel.font = UIFont(name: "PressStart2P-Regular", size: size)
        self.titleLabel.textColor = color
        self.titleLabel.textAlignment = NSTextAlignment.center
    }
    
    private func gameOverLabel() -> NSAttributedString {
        let text = NSMutableAttributedString.init(string: "GAME OVER \nTAP TO RE-START")
        text.setAttributes([NSAttributedString.Key.font: UIFont(name: "PressStart2P-Regular", size: 35)!, NSAttributedString.Key.foregroundColor: UIColor.red], range: NSMakeRange(0, 9))
        text.setAttributes([NSAttributedString.Key.font: UIFont(name: "PressStart2P-Regular", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white], range: NSMakeRange(11, 15))
        return text
    }
    
}

