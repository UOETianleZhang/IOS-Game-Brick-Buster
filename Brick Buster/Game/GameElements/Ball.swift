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
    var radius = 5
    let img = #imageLiteral(resourceName: "ball")
    static let name = "ball"
    
    override init() {
        super.init()
        initObject()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initObject() {
        self.fillTexture = SKTexture(image: img)
        self.fillColor = .white
        self.name = Ball.name
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.radius))
        self.physicsBody?.categoryBitMask = BitMask.Ball
        self.physicsBody?.contactTestBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall | BitMask.Stone
        self.physicsBody?.collisionBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall | BitMask.Stone
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.friction = 0.0
    }
    
    func setShape(radius: Int){
        self.radius = radius
    }
    
    func shotWithFixedSpeed(angle : Double) {
        let v : Double = 1
        let dx = v * cos(angle * Double.pi / 180)
        let dy = v * sin(angle * Double.pi / 180)
        DispatchQueue.main.async {
            self.physicsBody?.applyImpulse(CGVector(dx: dx, dy: dy))
        }
    }
}

