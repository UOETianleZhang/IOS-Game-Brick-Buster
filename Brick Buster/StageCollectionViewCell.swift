//
//  StageCollectionViewCell.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/24.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class StageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(image: UIImage, frontimg: UIImage) {
        imageView.image = image
        imageView.contentMode = .scaleToFill
        
        let frontimgview = UIImageView(image: frontimg)
        frontimgview.frame = CGRect(x: -15, y: -15, width: self.frame.size.width+30, height: self.frame.size.height+30)
        frontimgview.contentMode = .scaleToFill
        frontimgview.alpha = 0.5
        imageView.addSubview(frontimgview)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "StageCollectionViewCell", bundle: nil)
    }

}
