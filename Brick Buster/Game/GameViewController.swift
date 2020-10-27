//
//  GameViewController.swift
//  GameProduct
//
//  Created by Zhihao Qin on 10/14/20.
//  Copyright © 2020 Zhihao Qin. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var stage: Int64 = 1
var equipments: [equipment] = []

class GameViewController: UIViewController {
    
    var scene:GameScene?
    var moveRightTimer : Timer?
    var moveLeftTimer : Timer?
    var extraLife: Int?
    var coins: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extraLife = 1
        self.coins = 0

        if let view = self.view as! SKView? {

            self.scene = GameScene(size: view.frame.size, map: map1, gameViewController: self)
            self.scene!.scaleMode = .aspectFill
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func paddleMoveRight(){
        self.scene?.paddleMoveRight()
    }
    
    @objc func paddleMoveLeft(){
        self.scene?.paddleMoveLeft()
    }
}
