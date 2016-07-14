//
//  WaitingForTap.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/25/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForTap: GKState {
  
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnterWithPreviousState(previousState: GKState?) {    
    let scale = SKAction.scaleTo(1.0, duration: 0.5)
    scene.fgNode.childNodeWithName("Ready")!.runAction(scale)
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is WaitingForBomb.Type
  }
}
