//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//       this code for its for animating label
//        titleLabel.text = ""
//        var characterIndex = 0
//        let titleText = "⚡️FlashChat"
//        for letter in titleText{
//            Timer.scheduledTimer(withTimeInterval: 0.2*Double(characterIndex), repeats: false) { timer in
//                self.titleLabel.text?.append(letter)
//               }
//            characterIndex += 1
//        }
        
        
//        animation using CLtyping pod
        
        titleLabel.text = K.appName
        
       
    }
    

}
