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
    private var testBox:SKShapeNode?
    private var balls = [Ball]()
    
    override init(size: CGSize) {
        super.init(size: size)
        
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
//        //create balls
//        for _ in 0..<10 {
//            let ball = SKShapeNode(circleOfRadius: 10)
//            ball.fillColor = .red
//            addChild(ball)
//            ball.position = CGPoint(x: size.width / 2, y: 500)
//            ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//            ball.physicsBody?.velocity = CGVector(dx: 200, dy: 200)
//        }
//
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
            let ball = Ball(circleOfRadius: 10)
            balls.append(ball)
            ball.fillColor = .red
            addChild(ball)
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
            // 设置初速度
            //ball.physicsBody?.velocity = CGVector(dx: 600 + CGFloat(row) * 1, dy: 600)
            ball.position = CGPoint(x: size.width / 2, y: size.height/10)

            ball.physicsBody?.categoryBitMask = BitMask.Ball
            ball.physicsBody?.contactTestBitMask = BitMask.Box
            ball.physicsBody?.collisionBitMask = BitMask.Box

            ball.physicsBody?.linearDamping = 0
            ball.physicsBody?.restitution = 1
        }
        
        //create box
//        for row in 1...5 {
//            let box = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
//            box.position = CGPoint(x: 50 + (row * 50 + 20), y: (400 - row * 50 + 20))
//            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
//            box.physicsBody?.categoryBitMask = BitMask.Box
//            box.physicsBody?.contactTestBitMask = BitMask.Ball
//            box.physicsBody?.collisionBitMask = BitMask.Box
//            box.physicsBody?.linearDamping = 0
//            box.physicsBody?.restitution = 1.0
//            box.physicsBody?.isDynamic = false
//            box.fillColor = .red
//
//            let label = Label(text: "\(row)")
//            label.fontSize = 22
//            label.typoTag = 666
//            label.fontName = "Arial-BoldMT"
//            label.color = .white
//            label.position = CGPoint(x: 0, y: -label.frame.size.height / 2)
//            box.addChild(label)
//
//            addChild(box)
//        }
        
        //test move box
        testBox = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
        testBox!.position = CGPoint(x: 100, y: 400)
        testBox!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        testBox!.physicsBody?.categoryBitMask = BitMask.Box
        testBox!.physicsBody?.contactTestBitMask = BitMask.Ball
        testBox!.physicsBody?.collisionBitMask = BitMask.Box
        testBox!.physicsBody?.linearDamping = 0
        testBox!.physicsBody?.restitution = 1.0
        testBox!.physicsBody?.isDynamic = false
        testBox!.fillColor = .blue
        
        let label = Label(text: "1000")
        label.fontSize = 22
        label.typoTag = 666
        label.fontName = "Arial-BoldMT"
        label.color = .white
        label.position = CGPoint(x: 0, y: -label.frame.size.height / 2)
        testBox!.addChild(label)
        
        addChild(testBox!)
    }
}


extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        switch contact.bodyA.categoryBitMask {
        case BitMask.Box:
            checkNodeIsBox(contact.bodyA.node)

        default:
            break
        }

        switch contact.bodyB.categoryBitMask {
        case BitMask.Box:
            checkNodeIsBox(contact.bodyB.node)

        default:
            break
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        print(contact.bodyA.contactTestBitMask)
        print(contact.bodyB.contactTestBitMask)
    }
}

extension GameScene {
    private func checkNodeIsBox(_ node: SKNode?) {
        guard let box = node else { return }

        if box.physicsBody?.categoryBitMask == BitMask.Box {
            let label = box.children.first! as! Label
            var tag = Int(label.text!)!
            if (tag > 1) {
                tag -= 1
                label.text = "\(tag)"
            } else {
                box.removeFromParent()
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
    func moveRight(){
        testBox?.position = CGPoint(x: (testBox?.position.x)! + 10, y: (testBox?.position.y)!)
    }
    
    func moveLeft(){
        testBox?.position = CGPoint(x: (testBox?.position.x)! - 10, y: (testBox?.position.y)!)
    }
}
