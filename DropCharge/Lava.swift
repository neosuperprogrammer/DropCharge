//
//  Lava.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/27/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Lava: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnterWithPreviousState(previousState: GKState?) {
    scene.runAction(scene.soundHitLava)
    if debugFlag == false {
      scene.playerTrail.particleBirthRate = 0
      let smokeTrail = scene.addTrail("SmokeTrail")
      scene.runAction(SKAction.waitForDuration(2.0),
        completion:{
          self.scene.removeTrail(smokeTrail)
      })
    }
    
    scene.boostPlayer()
    scene.lives -= 1
    scene.screenShakeByAmt(50)
    scene.player.runAction(scene.squishAndStretch)
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is Jump.Type || stateClass is Fall.Type || stateClass is Dead.Type
  }
}
