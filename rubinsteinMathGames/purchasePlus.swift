//
//  purchasePlus.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 1/26/22.
//  Copyright © 2022 com.garyrubinstein. All rights reserved.
//

import SpriteKit

class PurchasePlusScene: SKScene {
    override func didMove(to view: SKView) {
        if let getBool = UserDefaults.standard.value(forKey: "plus") as? Bool {
            UserDefaults.standard.set(getBool, forKey: "plus")
        }
        else {
            UserDefaults.standard.set(false, forKey: "plus")
        }
        print("plus is")
        print(UserDefaults.standard.value(forKey: "plus")!)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        if let scene = MainMenuScene(fileNamed: "mainMenu") {
        // if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.view!.presentScene(scene)
        }
    }
}
