//
//  Paddle.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/18/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

import SpriteKit

class Paddle: SKShapeNode {
    var isHit = false
    var hitRemaining = 0
    var width : Int = 70
    var height : Int = 15
    
    
    override init() {
        super.init()
        let rect = CGRect(origin: CGPoint(x: -width / 2, y: -height / 2), size: CGSize(width: width, height: height))
        self.path = CGPath(rect: rect, transform: nil)
        initObject()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.fillColor = .purple
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Paddle
        self.physicsBody?.contactTestBitMask = BitMask.Ball
        self.physicsBody?.collisionBitMask = BitMask.Ball
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0.0
    }
    
    func setShape(width: Int, height: Int){
        self.width = width
        self.height = height
    }
}
