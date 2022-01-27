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
        if let getBool = UserDefaults.standard.value(forKey: "plus") as? Bool {
            UserDefaults.standard.set(getBool, forKey: "plus")
        }
        else {
            UserDefaults.standard.set(false, forKey: "plus")
        }
        print("plus is")
        print(UserDefaults.standard.value(forKey: "plus")!)
        print("hello")
        let sample = SKVideoNode(fileNamed: "instructions.mov")
        sample.position = CGPoint(x: frame.midX,
                                  y: frame.midY)
        addChild(sample)
        sample.play()
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
