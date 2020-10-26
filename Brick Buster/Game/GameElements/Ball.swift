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
    let img = #imageLiteral(resourceName: "ball")
    
    
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
        self.name = "ball"
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(self.radius))
        self.physicsBody?.categoryBitMask = BitMask.Ball
        self.physicsBody?.contactTestBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall
        self.physicsBody?.collisionBitMask = BitMask.Brick | BitMask.Ground | BitMask.Paddle | BitMask.Wall
        self.physicsBody?.usesPreciseCollisionDetection = true;
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.restitution = 1.0
        self.physicsBody?.friction = 0.0
    }
    
    func setShape(radius: Int){
        self.radius = radius
    }
    
    func shotWithFixedSpeed(angle : Double) {
        let v : Double = 350
        let dx = v * cos(angle * Double.pi / 180)
        let dy = v * sin(angle * Double.pi / 180)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.physicsBody?.applyForce(CGVector(dx: dx, dy: dy))
        }
    }
}
