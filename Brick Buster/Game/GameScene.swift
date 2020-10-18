//
//  GameScene.swift
//  GameProduct
//
//  Created by Zhihao Qin on 10/14/20.
//  Copyright © 2020 Zhihao Qin. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    var contentCreated = false
    private var paddle:Paddle?
    private var balls = [Ball]()
    private var bricks = [Brick]()
    private var brickWidth = 50
    private var brickHeight = 20
    private var paddleWidth = 70
    private var paddleHeight = 15
    private var ballRadius = 5
    private var map: [[Int]]?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.map = [[]]
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    init(size: CGSize, map: [[Int]]){
        super.init(size: size)
        
        self.map = map;
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        if !contentCreated {
            createContent()
            contentCreated = true
        }
    }

    private func createContent() {
        //create ground
        let ground = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: size.height/10))
        ground.position = CGPoint(x: size.width / 2, y: 0)
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.collisionBitMask = BitMask.Ball
        ground.physicsBody?.categoryBitMask = BitMask.Ground
        ground.physicsBody?.contactTestBitMask = BitMask.Ball
        addChild(ground)

        //create wall
        let wall = SKNode()
        wall.position = CGPoint(x: 0, y: 0)
        wall.physicsBody?.restitution = 1.0
        wall.physicsBody?.collisionBitMask = BitMask.Wall
        wall.physicsBody?.categoryBitMask = BitMask.Wall
        wall.physicsBody?.contactTestBitMask = BitMask.Wall
        wall.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        addChild(wall)
        
        //create ball
        for _ in 0..<1 {
            //create ball
            let ball = Ball(circleOfRadius: CGFloat(self.ballRadius))
            ball.setShape(radius: self.ballRadius)
            ball.position = CGPoint(x: 100, y: 105)
            
            //append ball
            balls.append(ball)
            addChild(ball)
        }
        
        //create brick
        self.createBricks()
        
        //create paddle
        //testBox = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        self.paddle = Paddle(rectOf: CGSize(width: self.paddleWidth, height: self.paddleHeight))
        self.paddle!.setShape(width: self.paddleWidth, height: self.paddleHeight)
        self.paddle!.position = CGPoint(x: 100, y: 100)
        
        addChild(paddle!)
    }
    
    private func createBricks(){
        if self.map!.count == 0 || self.map![0].count == 0{
            return
        }
        
        let bricksHeightNum = self.map!.count
        let bricksWidthNum = self.map![0].count
        
        let leftBoarder = 20
        let rightBoarder = 20
        let upBoarder = 20
        let downBoarder = 100
        
        
        self.brickWidth = (Int(size.width) - leftBoarder - rightBoarder)/bricksWidthNum
        self.brickHeight = (Int(size.height) - upBoarder - downBoarder)/bricksHeightNum
        if self.brickHeight > 20 {
            self.brickHeight = 20
        }
        
        print("brickWidth:\(self.brickWidth), brickHeight:\(self.brickHeight)")
        
        //create bricks
        for i in 0..<bricksHeightNum {
            let brickList = self.map![i]
            let yPosition = Float(size.height) - Float(upBoarder) - (Float(i) + 0.5)*Float(self.brickHeight)
            for j in 0..<bricksWidthNum{
                if brickList[j] != 0{
                    //create bricks
                    let xPosition = Float(leftBoarder) + (Float(j) + 0.5)*Float(self.brickWidth)
                                        
                    //create brick
                    let brick = Brick(rectOf: CGSize(width: self.brickWidth, height: self.brickHeight))
                    brick.setShape(width: self.brickWidth, height: self.brickHeight)
                    brick.position = CGPoint(x: Int(xPosition), y: Int(yPosition))

                    //append brick
                    bricks.append(brick)
                    addChild(brick)
                }
            }
        }
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask {
        case BitMask.Brick:
            checkNodeIsBox(contact.bodyA.node)

        default:
            break
        }

        switch contact.bodyB.categoryBitMask {
        case BitMask.Brick:
            checkNodeIsBox(contact.bodyB.node)

        default:
            break
        }
    }

//    func didEnd(_ contact: SKPhysicsContact) {
//        print(contact.bodyA.contactTestBitMask)
//        print(contact.bodyB.contactTestBitMask)
//    }
}

extension GameScene {
    private func checkNodeIsBox(_ node: SKNode?) {
        //guard let box = node else { return }

//        if box.physicsBody?.categoryBitMask == BitMask.Brick {
//            let label = box.children.first! as! Label
//            var tag = Int(label.text!)!
//            if (tag > 1) {
//                tag -= 1
//                label.text = "\(tag)"
//            } else {
//                box.removeFromParent()
//            }
//        }
        
        guard let brick = node as? Brick else { return }
        
        if brick.physicsBody?.categoryBitMask == BitMask.Brick {
            if brick.hitRemaining == 0{
                brick.removeFromParent()
            }
        }
    }
}

extension GameScene {
    private func shot() {
        for (index, ball) in balls.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 * Double(index)) {
                ball.physicsBody?.applyForce(CGVector(dx: 400 + CGFloat(index) * 0.1, dy: 800))
            }
        }
    }
}

extension GameScene {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        shot()
    }
}

extension GameScene {
    func paddleMoveRight(){
        if paddle!.position.x + CGFloat(paddle!.width)/2.0 < size.width - 20{
            paddle?.position = CGPoint(x: (paddle?.position.x)! + 10, y: (paddle?.position.y)!)
        }
    }
    
    func paddleMoveLeft(){
        if paddle!.position.x - CGFloat(paddle!.width)/2.0 > 20{
            paddle?.position = CGPoint(x: (paddle?.position.x)! - 10, y: (paddle?.position.y)!)
        }
    }
}