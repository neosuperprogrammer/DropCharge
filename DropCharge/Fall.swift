//
//  Fall.swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/27/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit

class Fall: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnterWithPreviousState(previousState: GKState?) {
    scene.runAnim(scene.animFall)
    scene.player.runAction(scene.squishAndStretch)
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is Jump.Type || stateClass is Lava.Type
  }

}
