//
//  Paddle.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/18/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation

import SpriteKit

class Paddle: SKSpriteNode {
    var isHit = false
    var hitRemaining = 0
    static let img = #imageLiteral(resourceName: "paddle")
    let width : Int = 70
    let height : Int = 20
    static let name = "paddle"
    
    override private init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: CGSize(width: width, height: height))
        self.position = position
        initObject()
    }
    
    convenience init() {
        self.init(texture: SKTexture(image: Paddle.img), color: .clear, size: CGSize())
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.name = Paddle.name
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Paddle
        self.physicsBody?.contactTestBitMask = BitMask.Ball
        self.physicsBody?.collisionBitMask = BitMask.Ball
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0.0
    }
}
