//
//  SavedGifsViewController.swift
//  GifMaker_Swift_Template
//
//  Created by Lucas Lopes on 21/01/24.
//  Copyright © 2024 Gabrielle Miller-Messner. All rights reserved.
//

import Foundation
import UIKit

var gifs: [Gif] = []

class SavedGifsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, GifPreviewViewControllerDelegate {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellMargin: CGFloat = 12.0
    
    var gifsFilePath: String {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsPath = directories[0]
        let gifsPath = URL(fileURLWithPath: documentsPath).appendingPathComponent("/savedGifs")
        return gifsPath.path
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emptyView.isHidden = gifs.count > 0
        collectionView.reloadData()                                          
        
        self.applyTheme(.dark)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let unarchivedGifs = NSKeyedUnarchiver.unarchiveObject(withFile: gifsFilePath) as? [Gif] {
            gifs = unarchivedGifs
        } else {
            gifs = []
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GifCell", for: indexPath) as! GifCell
        
        let gif = gifs[indexPath.item]
        cell.configure(for: gif)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - (cellMargin * 2.0))/2.0
        return CGSizeMake(width, width)
    }
    
    func previewVC(preview: GifPreviewViewController, didSaveGif gif: Gif) {
        gifs.append(gif)
        NSKeyedArchiver.archiveRootObject(gifs, toFile: gifsFilePath)
    }
}
