//
//  Gif.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 22/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class Gif: NSObject {
    
    var url: URL?
    var caption: String?
    var gifImage: UIImage?
    var videoURL: URL?
    var gifData: Data?
    
    init(gifUrl: URL?, videoURL: URL?, caption: String?) {
        self.url = gifUrl
        self.videoURL = videoURL
        self.caption = caption
        self.gifImage = UIImage.gif(url: url!.absoluteString)
        self.gifData = nil
    }
    
    init(name: String?){
        self.gifImage = UIImage.gif(name: name!)
    }
}
