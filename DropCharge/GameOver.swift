//
//  GameOver.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
    
  override func didEnterWithPreviousState(previousState: GKState?) {
    if previousState is Playing {
      scene.playBackgroundMusic("SpaceGame.caf")
      let gameOver = SKSpriteNode(imageNamed: "GameOver")
      gameOver.position = scene.getCameraPosition()
      gameOver.zPosition = 10
      scene.addChild(gameOver)
      
      let explosion = scene.explosion(3.0)
      explosion.position = gameOver.position
      explosion.zPosition = 11
      scene.addChild(explosion)
      scene.runAction(scene.soundExplosions[3])
      scene.screenShakeByAmt(200)
    }
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is WaitingForTap.Type
  }
}

