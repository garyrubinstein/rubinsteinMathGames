//
//  mainMenuScene.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 8/26/21.
//  Copyright © 2021 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        print("hello")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.view!.presentScene(scene)
        }
    }
}
