//
//  Dead,swift
//  DropCharge
//
//  Created by Skyrocket Software on 8/27/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//

import SpriteKit
import GameplayKit


class Dead: GKState {
  unowned let scene: GameScene
  
  init(scene: SKScene) {
    self.scene = scene as! GameScene
    super.init()
  }
  
  override func didEnterWithPreviousState(previousState: GKState?) {
    if previousState is Lava {
      scene.physicsWorld.contactDelegate = nil
      scene.player.physicsBody?.dynamic = false
      
      let moveUpAction = SKAction.moveByX(0, y: scene.size.height/2, duration: 0.5)
      moveUpAction.timingMode = .EaseOut
      let moveDownAction = SKAction.moveByX(0, y: -(scene.size.height * 1.5), duration: 1.0)
      moveDownAction.timingMode = .EaseIn
      let sequence = SKAction.sequence([moveUpAction, moveDownAction])
      scene.player.runAction(sequence)
      scene.runAction(scene.soundGameOver)
    }
  }
  
  override func isValidNextState(stateClass: AnyClass) -> Bool {
    return stateClass is Idle.Type
  }
}
