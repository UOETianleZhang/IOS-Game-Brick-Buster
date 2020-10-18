//
//  Ball.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/16/20.
//  Copyright © 2020 tra. All rights reserved.
//

import SpriteKit

class Ball: SKShapeNode {
    var isShot = false
    var radius = 8
    
    
    override init() {
        super.init()
        
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.fillColor = .red
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.radius))
        self.physicsBody?.categoryBitMask = BitMask.Ball
        self.physicsBody?.contactTestBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall
        self.physicsBody?.collisionBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
    }
}

