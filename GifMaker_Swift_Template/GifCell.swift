//
//  GifCell.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 24/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImageView: UIImageView!
    
    func configure(for gif: Gif) {
        self.gifImageView.image = gif.gifImage
    }

}
