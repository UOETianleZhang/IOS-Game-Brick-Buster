//
//  Brick.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/16/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

import SpriteKit

class Prop: SKSpriteNode {
    var width = 15
    var height = 15
    static let name = "prop"
    
    init(position: CGPoint, img:UIImage) {
        super.init(texture: SKTexture(image: img) ,color: .clear, size: CGSize(width: width, height: height))
        self.position = position
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Prop
        self.physicsBody?.contactTestBitMask = BitMask.Paddle | BitMask.Ground
        self.physicsBody?.collisionBitMask = BitMask.Paddle | BitMask.Ground
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -30)
    }
    
    func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        fatalError("must override")
    }
}

class ProlongProp : Prop {
    init(position: CGPoint) {
        super.init(position: position, img: #imageLiteral(resourceName: "long"))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        if paddle.xScale < 3.5 {
            paddle.xScale *= 1.5
        }
    }
}

class ShortenProp : Prop {
    init(position: CGPoint) {
        super.init(position: position, img: #imageLiteral(resourceName: "short"))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        if paddle.xScale >= 1/4 {
            paddle.xScale /= 1.5
        }
    }
}

class ThreeBallsProp : Prop {
    init(position: CGPoint) {
        super.init(position: position, img: #imageLiteral(resourceName: "three"))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        let pos = CGPoint(x: paddle.position.x, y: paddle.position.y + CGFloat(paddle.height))
        gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 45)
        gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 91)
        gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 135)
    }
}

class ExpandProp : Prop {
    init(position: CGPoint) {
        super.init(position: position, img: #imageLiteral(resourceName: "expand"))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        for ball in gameScene.children.filter({ $0.name == "ball" }) {
            let ball = ball as! Ball
            let pos = ball.position
            gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 90)
            gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 210)
            gameScene.createBall(position: pos).shotWithFixedSpeed(angle: 330)
        }
    }
}

class StoneProtectionProp : Prop {
    init(position: CGPoint) {
        super.init(position: position, img: #imageLiteral(resourceName: "wall"))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func conduct(gameScene : GameScene, paddle: Paddle, prop: Prop) {
        //get width & height & yposition
        let width = gameScene.getBrickWidth()
        let height = gameScene.getBrickHeight()
        var stoneList: [Stone] = []
        
        //create wall
        let stoneNum = Int(gameScene.frame.width) / width + 1
        for i in 0..<stoneNum{
            let stone = Stone(rectOf: CGSize(width: width, height: height))
            stone.position = CGPoint(x: i * width, y: Int(paddle.position.y) - 30)
            
            //add stone
            stoneList.append(stone)
            gameScene.addChild(stone)
        }
        
        //dissmiss after 5 seconds
        DispatchAfter(after: 5) {
            for (_, stone) in stoneList.enumerated() {
                stone.removeFromParent()
            }
        }
    }
    
    private func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
}
