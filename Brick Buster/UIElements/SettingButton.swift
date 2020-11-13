//
//  SettingButton.swift
//  Brick Buster
//
//  Created by yujian on 2020/10/24.
//  Copyright © 2020 tra. All rights reserved.
//

import UIKit

class SettingButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor     = Colors.tropicBlue
        tintColor = .white
        layer.cornerRadius  = frame.size.height/2
        setImage(UIImage(named:"setting"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
