//
//  WelcomeViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let welcomeGif = UIImage.gif(name: "tinaFeyHiFive")
        gifImageView.image = welcomeGif
        
        UserDefaults.standard.set(true, forKey: "WelcomeViewSeen")
    }    
}
