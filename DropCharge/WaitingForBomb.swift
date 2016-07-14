//
//  WaitingForBomb.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/26/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForBomb: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
    
  override func didEnterWithPreviousState(previousState: GKState?) {
    if previousState is WaitingForTap {
      // Scale out title & ready label
      let scale = SKAction.scaleTo(0, duration: 0.4)
      scene.fgNode.childNodeWithName("Title")!.runAction(scale)
      scene.fgNode.childNodeWithName("Ready")!.runAction(SKAction.sequence([SKAction.waitForDuration(0.2), scale]))
      // Bounce bomb
      let scaleUp = SKAction.scaleTo(1.25, duration: 0.25)
      let scaleDown = SKAction.scaleTo(1.0, duration: 0.25)
      let sequence = SKAction.sequence([scaleUp, scaleDown])
      let repeatSeq = SKAction.repeatActionForever(sequence)
      scene.fgNode.childNodeWithName("Bomb")!.runAction(SKAction.unhide())
      scene.fgNode.childNodeWithName("Bomb")!.runAction(repeatSeq)
      
      scene.runAction(scene.soundBombDrop)
      scene.runAction(scene.soundTickTock)
    }
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is Playing.Type
  }
  
  override func willExitWithNextState(nextState: GKState) {
    if nextState is Playing {
      let bomb = scene.fgNode.childNodeWithName("Bomb")!
      if debugFlag == false {
        let explosion = scene.explosion(2.0)
        explosion.position = bomb.position
        scene.fgNode.addChild(explosion)
      }
      bomb.removeFromParent()
      scene.runAction(scene.soundExplosions[3])
      scene.screenShakeByAmt(100)
    }
  }

}

