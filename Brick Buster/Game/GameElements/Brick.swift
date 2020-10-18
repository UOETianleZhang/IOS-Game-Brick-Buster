//
//  Brick.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/16/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

import SpriteKit

class Brick: SKShapeNode {
    var isHit = false
    var hitRemaining = 0
    var width = 50
    var height = 20
    
    
    override init() {
        super.init()
        print("here")
        self.width = 50
        self.height = 20
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.fillColor = .blue
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Brick
        self.physicsBody?.contactTestBitMask = BitMask.Ball
        self.physicsBody?.collisionBitMask = BitMask.Ball
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = false
    }
    
    func setShape(width: Int, height: Int){
        self.width = width
        self.height = height
    }
}
