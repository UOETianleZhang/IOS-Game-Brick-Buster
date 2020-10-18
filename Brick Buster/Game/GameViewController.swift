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

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {

            self.scene = GameScene(size: view.frame.size, map: map2)
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
    
    
    @IBAction func moveLeftHolding(_ sender: Any) {
        guard moveLeftTimer == nil else { return }
        moveLeftTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(paddleMoveLeft), userInfo: nil, repeats: true)
    }

    
    @IBAction func moveLeftReleased(_ sender: Any) {
        moveLeftTimer?.invalidate()
        moveLeftTimer = nil
    }
    
    @IBAction func moveRightReleased(_ sender: Any) {
        moveRightTimer?.invalidate()
        moveRightTimer = nil
    }
    
    @IBAction func moveRightHolding(_ sender: Any) {
        guard moveRightTimer == nil else { return }
        moveRightTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(paddleMoveRight), userInfo: nil, repeats: true)
    }
    
    @objc func paddleMoveRight(){
        self.scene?.paddleMoveRight()
    }
    
    @objc func paddleMoveLeft(){
        self.scene?.paddleMoveLeft()
    }
}
