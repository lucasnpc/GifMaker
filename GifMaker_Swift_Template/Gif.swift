//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 22/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif: NSObject, NSCoding {
    var gifURL: URL?
    var caption: String?
    var gifImage: UIImage?
    var videoURL: URL?
    var gifData: Data?
    
    init(gifUrl: URL?, videoURL: URL?, caption: String?) {
        self.gifURL = gifUrl
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: gifURL!.absoluteString)
        self.gifData = nil
    }
    
    init(name: String?){
        self.gifImage = UIImage.gif(name: name!)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.gifURL, forKey: "gifURL")
        coder.encode(self.caption, forKey: "caption")
        coder.encode(self.videoURL, forKey: "videoURL")
        coder.encode(self.gifImage, forKey: "gifImage")
        coder.encode(self.gifData, forKey: "gifData")
    }
    
    required init?(coder: NSCoder) {
        super.init()
            
        // Unarchive the data, one property at a time
        self.gifURL = coder.decodeObject(forKey: "gifURL") as? URL
        self.caption = coder.decodeObject(forKey: "caption") as? String
        self.videoURL = coder.decodeObject(forKey: "videoURL") as? URL
        self.gifImage = coder.decodeObject(forKey: "gifImage") as? UIImage
        self.gifData = coder.decodeObject(forKey: "gifData") as? Data
    }
}
