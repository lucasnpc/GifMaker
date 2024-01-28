//
//  DetailViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    var gif: Gif!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shareButton.layer.cornerRadius = 4.0
        
        gifImageView.image = gif.gifImage
        applyTheme(.darkTranslucent)
    }
    
    @IBAction func shareGif(_ sender: Any) {
        var itemsToShare: [Any]
        itemsToShare = [gif.gifData!]
        
        let shareController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { (activityType, completed, returnedItems, activityError) in
            if completed {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        self.present(shareController, animated: true)
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
