//
//  GameViewController.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 4/14/20.
//  Copyright © 2020 com.garyrubinstein. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let getBool = UserDefaults.standard.value(forKey: "plus") as? Bool {
            UserDefaults.standard.set(getBool, forKey: "plus")
        }
        else {
            UserDefaults.standard.set(false, forKey: "plus")
        }
        if let getInt = UserDefaults.standard.value(forKey: "games") as? Int {
            UserDefaults.standard.set(getInt+1, forKey: "games")
        }
        else {
            UserDefaults.standard.set(0, forKey: "games")
        }
        var sceneName = "mainMenu"
        var plus = false // getBool
        var numGames = 10 // getInt
        if (!plus && numGames>9) {
            sceneName = "purchasePlus"
        }
        var plusMenu = false
        if (plus==false && numGames>9) {
            plusMenu = true
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if (!plusMenu) {
                if let scene = MainMenuScene(fileNamed: "mainMenu") {// "mainMenu") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFit
                    
                    // Present the scene
                    view.presentScene(scene)
                }
            }
            else {
                if let scene = PurchasePlusScene(fileNamed: "purchasePlus") {// "mainMenu") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFit
                    
                    // Present the scene
                    view.presentScene(scene)
                }
            }

            
            
            
            /*
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            */
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
