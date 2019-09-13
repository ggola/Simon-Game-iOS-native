//
//  Animate.swift
//  SimonGame
//
//  Created by Giulio Gola on 12/09/2019.
//  Copyright © 2019 Giulio Gola. All rights reserved.
//

import UIKit

class Animation: UIViewController {
    
    func animate(button: UIButton, color: UIColor) {
        button.layer.shadowColor = UIColor.white.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 7.0
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
        UIView.animate(withDuration: 0.25) {
            button.layer.backgroundColor = UIColor.white.cgColor
            button.layer.shadowRadius = 15.0
            UIView.animate(withDuration: 0.3) {
                button.layer.backgroundColor = color.cgColor
                button.layer.shadowRadius = 0.0
            }
        }
    }
    
}
