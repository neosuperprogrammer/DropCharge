//
//  Jump.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/27/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Jump: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnterWithPreviousState(previousState: GKState?) {
    if previousState is Lava {
      return
    }
    if debugFlag == false {
      if scene.playerTrail.particleBirthRate == 0 {
        scene.playerTrail.particleBirthRate = 200
      }
    }
    scene.player.runAction(scene.squishAndStretch)
  }
  
  override func updateWithDeltaTime(seconds: NSTimeInterval) {
    if abs(scene.player.physicsBody!.velocity.dx) > 100.0 {
      if scene.player.physicsBody!.velocity.dx > 0 {
        scene.runAnim(scene.animSteerRight)
      } else {
        scene.runAnim(scene.animSteerLeft)
      }
    } else {
      scene.runAnim(scene.animJump)
    }
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is Fall.Type
  }
}
