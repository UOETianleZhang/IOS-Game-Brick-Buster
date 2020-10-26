//
//  GameOver.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/21/20.
//  Copyright © 2020 tra. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnter(from previousState: GKState?) {
    if previousState is PlayingGame {
//      let ball = scene.childNode(withName: BallCategoryName) as! SKSpriteNode
//      ball.physicsBody!.linearDamping = 1.0
      scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
    }
  }
    
    override func willExit(to nextState: GKState) {
      if nextState is PlayingGame {
          let scale = SKAction.scale(to: 0, duration: 0.4)
          scene.childNode(withName: GameMessageName)!.run(scale)
      }
    }
  
  override func isValidNextState(_ stateClass: AnyClass) -> Bool {
    return stateClass is PlayingGame.Type
  }
  
}

