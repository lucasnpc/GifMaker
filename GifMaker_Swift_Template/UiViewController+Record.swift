//
//  UiViewControllerRecord.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

let kFrameCount: Int = 16;
let kDelayTime: Float = 0.2;
let kLoopCount: Int = 0;
let kFrameRate: Float = 15;

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func launchVideoCamera(sender: AnyObject){
        // create imagepicker
        let recordViewController = UIImagePickerController()
        recordViewController.sourceType = UIImagePickerController.SourceType.camera
        recordViewController.mediaTypes = [UTType.movie.identifier]
        recordViewController.allowsEditing = true
        recordViewController.delegate = self
        
        present(recordViewController, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType == UTType.movie.identifier {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            dismiss(animated: true)
            convertViewToGIF(videoUrl: videoURL)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func convertViewToGIF(videoUrl: URL){
        let regift = Regift(sourceFileURL: videoUrl, frameCount: kFrameCount, delayTime: kDelayTime, loopCount: kLoopCount)
        let gifUrl = regift.createGif()
        let gif = Gif(gifUrl: gifUrl, videoURL: videoUrl, caption: nil)
        displayGIF(gif: gif)
    }
    
    func displayGIF(gif: Gif){
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif
        navigationController?.pushViewController(gifEditorVC, animated: true)
    }
    
}
