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
    
    
    override init() {
        super.init()
        
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.fillColor = .red
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        self.physicsBody?.categoryBitMask = BitMask.Ball
        self.physicsBody?.contactTestBitMask = BitMask.Box | BitMask.Ground
        self.physicsBody?.collisionBitMask = BitMask.Box
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
    }
}

