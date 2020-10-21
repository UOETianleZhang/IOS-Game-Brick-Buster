//
//  WaitingForGameStart.swift
//  Brick Buster
//
//  Created by Zhihao Qin on 10/21/20.
//  Copyright © 2020 tra. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForStart: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnter(from previousState: GKState?) {
    let scale = SKAction.scale(to: 1.0, duration: 0.25)
    scene.childNode(withName: GameMessageName)!.run(scale)
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

