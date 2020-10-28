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
    var extraLife: Int64?
    var coin: Int64?
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.extraLife = data.lives
        self.coin = data.coins
        self.scoreLabel.text = String(0)
        self.lifeLabel.text = String(self.extraLife!)
        self.coinLabel.text = String(self.coin!)

        if let view = self.view as! SKView? {

            self.scene = GameScene(size: view.frame.size, map: map9, gameViewController: self)
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
    
    func updateScore(score: Int){
        self.scoreLabel.text = String(score)
    }
    
    func updateLife(life: Int64){
        self.extraLife = life
        self.lifeLabel.text = String(life)
    }
    
    func updateCoin(coin: Int64){
        self.coin = coin
        self.coinLabel.text = String(coin)
    }
    
    func backToMainVC(){
        //get all VC
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        
        //set transition
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "cube")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        
        //pass parameters
        data.lives = self.extraLife!
        data.coins = self.coin!
        
        //pop to main vc
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
