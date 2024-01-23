//
//  UIViewController+Theme.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 23/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

enum Theme {
    case light, dark, darkTranslucent
}

extension UIViewController {

    func applyTheme(_ theme: Theme) {
        switch theme {
        case .light:
            self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor(red: 255.0/255.0, green: 51.0/255.0, blue: 102.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)]

            self.view.backgroundColor = UIColor.white
            
        case .dark:
            self.view.backgroundColor = UIColor(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)

            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = UIColor(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            self.navigationController?.navigationBar.backgroundColor = UIColor(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 1.0)
            self.edgesForExtendedLayout = []

            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]

        case .darkTranslucent:
            self.view.backgroundColor = UIColor(red: 46.0/255.0, green: 61.0/255.0, blue: 73.0/255.0, alpha: 0.9)
        }
    }
    
}
