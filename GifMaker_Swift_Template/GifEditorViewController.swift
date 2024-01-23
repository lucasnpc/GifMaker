//
//  GifEditorViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class GifEditorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    var gif: Gif?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gifImageView.image = gif?.gifImage
        subscribeToKeyboardNotifications()
        
        self.title = "Add a Caption"
        self.applyTheme(.dark)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.title = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Preview gif
    
    @IBAction func presentPreview(_ sender: Any) {
        let previewVC = storyboard?.instantiateViewController(withIdentifier: "GifPreviewViewController") as! GifPreviewViewController
        self.gif?.caption = self.captionTextField.text

        let regift = Regift(sourceFileURL: self.gif!.videoURL!, destinationFileURL: nil, frameCount: kFrameCount, delayTime: kDelayTime, loopCount: kLoopCount)
        
        let captionFont = self.captionTextField.font
        let gifURL = regift.createGif(self.captionTextField.text, font: captionFont)

        let newGif = Gif(gifUrl: gifURL, videoURL: self.gif!.videoURL, caption: self.captionTextField.text)
        previewVC.gif = newGif
        
        navigationController?.pushViewController(previewVC, animated: true)
    }

}
