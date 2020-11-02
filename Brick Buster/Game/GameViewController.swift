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
    var score: Int64?
    private var targetMap = map1
    private var isExtraLifeUsed = false
    private var isExtraPaddleLengthUsed = false
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getEquipments()
        
        if(self.isExtraLifeUsed){
            self.extraLife = 1
        }else{
            self.extraLife = 0
        }
        
        
        self.coin = data.coins
        self.score = 0
        self.scoreLabel.text = String(self.score!)
        self.lifeLabel.text = String(self.extraLife!)
        self.coinLabel.text = String(self.coin!)

        if let view = self.view as! SKView? {
            //get target map
            self.getTargetMap()
            
            //create game scene
            self.scene = GameScene(size: view.frame.size, map: self.targetMap, gameViewController: self)
            self.scene?.isExtraLifeUsed = self.isExtraLifeUsed
            self.scene?.isPaddleLengthUsed = self.isExtraPaddleLengthUsed
            self.scene!.scaleMode = .aspectFill
            
            //display game scene
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
        self.score = Int64(score)
        self.scoreLabel.text = String(self.score!)
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
        data.lives += self.extraLife!
        data.coins = self.coin!
        data.score += self.score!
        DB.addOrUpdate(data:data)
        
        //pop to main vc
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    private func getEquipments(){
        for element in equipments{
            //check if extra life is used
            if element == equipment.life && data.lives > 0{
                data.lives -= 1
                self.isExtraLifeUsed = true
            }
            //check if extra paddle length is used
            if element == equipment.bat && data.bats > 0{
                data.bats -= 1
                self.isExtraPaddleLengthUsed = true
            }
        }
    }
    
    private func getTargetMap(){
        switch stage{
            case 1:
                self.targetMap = map1
            case 2:
                self.targetMap = map2
            case 3:
                self.targetMap = map3
            case 4:
                self.targetMap = map4
            case 5:
                self.targetMap = map5
            case 6:
                self.targetMap = map6
            case 7:
                self.targetMap = map7
            case 8:
                self.targetMap = map8
            case 9:
                self.targetMap = map9
            default:
                self.targetMap = map1
                break
        }
    }
}
