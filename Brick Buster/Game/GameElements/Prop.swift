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
    var width = 25
    var height = 25
    
    
    init(position: CGPoint) {
        super.init(texture: nil ,color: .green, size: CGSize(width: width, height: height))
        self.position = position
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Prop
        self.physicsBody?.contactTestBitMask = BitMask.Paddle
        self.physicsBody?.collisionBitMask = BitMask.Paddle
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = true
        self.physicsBody?.velocity = CGVector(dx: 0, dy: -30)
    }
}

