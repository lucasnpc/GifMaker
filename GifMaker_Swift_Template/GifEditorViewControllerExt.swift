//
//  GifEditorViewControllerExt.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 23/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

// Methods to adjust the keyboard
extension GifEditorViewController {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if view.frame.origin.y >= 0 {
            view.frame.origin.y -= getKeyboardHeight(notification: notification)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if (self.view.frame.origin.y < 0) {
            view.frame.origin.y += getKeyboardHeight(notification: notification)
        }
    }

    func getKeyboardHeight(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
