//
//  Stone.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/28/20.
//  Copyright © 2020 tra. All rights reserved.
//

import Foundation
import SpriteKit

class Stone: SKSpriteNode {
    let img = #imageLiteral(resourceName: "stone")
    var width = 100
    var height = 20
    
    override private init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: SKTexture(image: img), color: color, size: size)
        self.width = Int(size.width)
        self.height = Int(size.height)
        initObject()
    }
    
    convenience init(rectOf: CGSize) {
        self.init(texture: nil, color: .clear, size: rectOf)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.width, height: self.height))
        self.physicsBody?.categoryBitMask = BitMask.Stone
        self.physicsBody?.contactTestBitMask = BitMask.Ball
        self.physicsBody?.collisionBitMask = BitMask.Ball
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.isDynamic = false
        self.physicsBody?.friction = 0.0
    }
}
