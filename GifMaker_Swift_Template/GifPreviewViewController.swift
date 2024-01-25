//
//  GifPreviewViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

protocol GifPreviewViewControllerDelegate{
    func previewVC(preview: GifPreviewViewController, didSaveGif gif: Gif)
}

class GifPreviewViewController: UIViewController {
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var gif: Gif?
    var previewDelegate: GifPreviewViewControllerDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Preview"
        self.applyTheme(.dark)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gifImageView.image = gif?.gifImage
        
        // Customize Buttons
        self.shareButton.layer.cornerRadius = 4.0
        self.shareButton.layer.borderColor = UIColor(red: 255.0/255.0, green: 65.0/255.0, blue: 112.0/255.0, alpha: 1.0).cgColor
        self.shareButton.layer.borderWidth = 1.0
        
        self.saveButton.layer.cornerRadius = 4.0
    }
    
    @IBAction func shareGif(sender: AnyObject) {
        let url: URL = (self.gif?.gifURL)!
        let animatedGIF = NSData(contentsOf: url)!
        let itemsToShare = [animatedGIF]

        let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

        activityVC.completionWithItemsHandler = {(activity, completed, items, error) in
            if (completed) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }

        navigationController?.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func createAndSave() {
        do {
            self.gif!.gifData = try Data(contentsOf: (self.gif?.gifURL)!)

            previewDelegate?.previewVC(preview: self, didSaveGif: gif!)
            navigationController!.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
    }
}
