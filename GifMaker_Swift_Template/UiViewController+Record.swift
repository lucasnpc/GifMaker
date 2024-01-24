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
import AVFoundation

let kFrameCount: Int = 16;
let kDelayTime: Float = 0.2;
let kLoopCount: Int = 0;
let kFrameRate: Float = 15;

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func presentViewOptions() {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            
        } else{
            let newGifActionSheet = UIAlertController(title: "Create new GIF", message: nil, preferredStyle: .actionSheet)
            
            let recordVideo = UIAlertAction(title: "Record a Video", style: .default, handler: {
                (UIAlertAction) in
                self.launchVideoCamera()
            })
            
            let chooseFromExisting = UIAlertAction(title: "Choose from existing", style: .default, handler: {
                (UIAlertAction) in
                self.launchPhotoLibrary()
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            newGifActionSheet.addAction(recordVideo)
            newGifActionSheet.addAction(chooseFromExisting)
            newGifActionSheet.addAction(cancel)
            
            present(newGifActionSheet, animated: true)
            let pinkColor = UIColor(red: 255.0/255.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1.0)
            newGifActionSheet.view.tintColor = pinkColor
        }
    }
    
    func launchVideoCamera(){
        present(getPickerControllerFromSourceType(type: .camera), animated: true)
    }
    
    func launchPhotoLibrary() {
        present(getPickerControllerFromSourceType(type: .photoLibrary), animated: true)
    }
    
    // MARK: UTILS
    
    private func getPickerControllerFromSourceType(type: UIImagePickerController.SourceType) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.sourceType = type
        controller.mediaTypes = [UTType.movie.identifier]
        controller.allowsEditing = true
        controller.delegate = self
        return controller
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType == UTType.movie.identifier {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            
            let start: NSNumber? = info[UIImagePickerController.InfoKey(rawValue: "_UIImagePickerControllerVideoEditingStart") ] as? NSNumber
            let end: NSNumber? = info[UIImagePickerController.InfoKey(rawValue: "_UIImagePickerControllerVideoEditingEnd") ] as? NSNumber
            var duration: NSNumber?
            if let start = start {
                duration = NSNumber(value: (end!.floatValue) - (start.floatValue))
            } else {
                duration = nil
            }
            
            cropVideoToSquare(rawVideoURL: videoURL, start: start, duration: duration)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func cropVideoToSquare(rawVideoURL: URL, start: NSNumber?, duration: NSNumber?) {
        // Create the AVAsset and AVAssetTrack
        let videoAsset = AVAsset(url: rawVideoURL)
        let videoTrack = videoAsset.tracks(withMediaType: .video)[0]
        
        // Crop to square
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.height)
        videoComposition.frameDuration = CMTime(value: 1, timescale: 30)
        
        let instruction = AVMutableVideoCompositionInstruction()
        instruction.timeRange = CMTimeRange(start: .zero, duration: CMTimeMakeWithSeconds(60, preferredTimescale: 30))
        
        // Rotate to portrait
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        let t1 = CGAffineTransform(translationX: videoTrack.naturalSize.height, y: -(videoTrack.naturalSize.width - videoTrack.naturalSize.height) / 2)
        let t2 = t1.rotated(by: .pi / 2)
        
        let finalTransform = t2
        transformer.setTransform(finalTransform, at: .zero)
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        // Export
        guard let exporter = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetHighestQuality) else { return }
        exporter.videoComposition = videoComposition
        let path = createPath()
        exporter.outputURL = URL(fileURLWithPath: path)
        exporter.outputFileType = .mov
        
        var croppedURL: URL?
        
        exporter.exportAsynchronously(completionHandler: {
            croppedURL = exporter.outputURL
            self.convertVideoToGif(croppedURL: croppedURL!, start: start, duration: duration)
        })
    }
    
    func createPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let manager = FileManager.default
        var outputURL = URL(fileURLWithPath: documentsDirectory).appendingPathComponent("output")
        try? manager.createDirectory(at: outputURL, withIntermediateDirectories: true, attributes: nil)
        outputURL = outputURL.appendingPathComponent("output.mov")
        
        // Remove Existing File
        try? manager.removeItem(at: outputURL)
        
        return outputURL.path
    }
    
    //MARK: Gif Conversion and Display methods
    
    func convertVideoToGif(croppedURL: URL, start: NSNumber?, duration: NSNumber?) {
        
        
        let regift: Regift

        if let start = start {
            // Trimmed
            regift = Regift(sourceFileURL: croppedURL as URL, destinationFileURL: nil, startTime: start.floatValue, duration: duration!.floatValue, frameRate: Int(kFrameRate), loopCount: kLoopCount)
        } else {
            // Untrimmed
            regift = Regift(sourceFileURL: croppedURL as URL, destinationFileURL: nil, frameCount: kFrameCount, delayTime: kDelayTime, loopCount: kLoopCount)
        }

        let gifURL = regift.createGif()
        let gif = Gif(gifUrl: gifURL!, videoURL: croppedURL, caption: nil)
        displayGIF(gif: gif)
    }
    
    func displayGIF(gif: Gif){
        let gifEditorVC = storyboard?.instantiateViewController(withIdentifier: "GifEditorViewController") as! GifEditorViewController
        gifEditorVC.gif = gif
        
        DispatchQueue.main.async {
            self.dismiss(animated: true)
            self.navigationController?.pushViewController(gifEditorVC, animated: true)
        }
    }
    
}
