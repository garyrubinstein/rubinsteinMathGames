//
//  mainMenuScene.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 8/26/21.
//  Copyright © 2021 com.garyrubinstein. All rights reserved.
//

import SpriteKit
import StoreKit
// var plus = false
// let ProductID = "unlimiteduseproductgame"

class MainMenuScene: SKScene {
    var startButton: SKShapeNode = SKShapeNode()
    var startButtonLabel: SKLabelNode = SKLabelNode()
    var instructionsButton: SKShapeNode = SKShapeNode()
    var instructionsButtonLabel: SKLabelNode = SKLabelNode()
    override func didMove(to view: SKView) {
        if let getBool = UserDefaults.standard.value(forKey: "plus") as? Bool {
            UserDefaults.standard.set(getBool, forKey: "plus")
        }
        else {
            UserDefaults.standard.set(false, forKey: "plus")
        }
        // print("plus is")
        // print(UserDefaults.standard.value(forKey: "plus")!)
        // print("hello")
        var buttonWidth: CGFloat = 250.0
        var buttonHeight: CGFloat = 150.0
        startButton = SKShapeNode(rect: CGRect(x: -buttonWidth/2, y: -450-buttonHeight/2, width: buttonWidth, height: buttonHeight))
        startButton.fillColor = UIColor.red
        startButton.name = "startButton"
        startButton.zPosition = 5
        // var startLabel: SKLabelNode = SKLabelNode()
        startButtonLabel.text = "Start"
        startButtonLabel.fontName="Optima-ExtraBlack"
        startButtonLabel.fontSize = 48
        startButtonLabel.zPosition = 10
        startButtonLabel.position = CGPoint(x: 0, y: -450)
        startButton.addChild(startButtonLabel)
        // redCounter.position = CGPoint(x: 0, y: -450)
        self.addChild(startButton)
        
        instructionsButton = SKShapeNode(rect: CGRect(x: -buttonWidth/2, y: -250-buttonHeight/2, width: buttonWidth, height: buttonHeight))
        instructionsButton.fillColor = UIColor.systemGreen
        instructionsButton.name = "instructionsButton"
        instructionsButton.zPosition = 5
        // var startLabel: SKLabelNode = SKLabelNode()
        instructionsButtonLabel.text = "How To Play"
        instructionsButtonLabel.fontName="Optima-ExtraBlack"
        instructionsButtonLabel.fontSize = 40
        instructionsButtonLabel.zPosition = 10
        instructionsButtonLabel.position = CGPoint(x: 0, y: -250)
        instructionsButton.addChild(instructionsButtonLabel)
        // redCounter.position = CGPoint(x: 0, y: -450)
        self.addChild(instructionsButton)
        
        /*
        let sample = SKVideoNode(fileNamed: "instructions2.mov")
        sample.position = CGPoint(x: frame.midX,
                                  y: frame.midY)
        addChild(sample)
        sample.play()
        */
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                print("nodename")
                // print(node.name)
                if node.name == "startButton" {
                    print("startButton")
                    if let scene = SKScene(fileNamed: "GameScene") {
                        // Set the scale mode to scale to fit the window
                        scene.scaleMode = .aspectFit
                        
                        // Present the scene
                        self.view!.presentScene(scene)
                    }
                }
                if node.name == "instructionsButton" {
                    print("instructionsButton")
                    node.isHidden = true
                    let sample = SKVideoNode(fileNamed: "instructions2.mov")
                    sample.position = CGPoint(x: frame.midX,
                                              y: frame.midY)
                    addChild(sample)
                    sample.play()
                }
            }
        }
/*        for t in touches {
            let location = t.location(in: self)
            let touchedNode = atPoint(location)
            print(touchedNode.name ?? "noname")
        } */
        /* if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
            
            // Present the scene
            self.view!.presentScene(scene)
        } */
    }
    /*
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            // print("hi")
            var doFinish = true
            if transaction.transactionState == .purchased {
                print("purchased")
                plus = true
                UserDefaults.standard.set(true, forKey: "tester")
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
            else if transaction.transactionState == .restored {
                print("restored")
                plus = true
                UserDefaults.standard.set(true, forKey: "tester")
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
            else if transaction.transactionState == .failed {
                print("failed!")
                plus = false
                UserDefaults.standard.set(false, forKey: "tester")
            }
            else {
                print("transactionstate was not recognized")
                doFinish = false
            }
            if doFinish {
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    
    func purchasePlus() {
        if SKPaymentQueue.canMakePayments() {
            print("making payment")
            // plus = true
            // UserDefaults.standard.set(true, forKey: "tester")
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = ProductID
            SKPaymentQueue.default().add(paymentRequest)
        }
        else {
            print("payment failed")
        }
        
        // UserDefaults.standard.set(true, forKey: "tester")
        // let scene = MainMenuScene(fileNamed: "MainMenuScene")
        // scene!.scaleMode = .aspectFit
        // self.view?.presentScene(scene)
    }
    
    func restorePlus() {
        print("In restorePlus")
        print(SKPaymentQueue.default().restoreCompletedTransactions())
    }

    func purchasePlus2() {
        plus = true
        UserDefaults.standard.set(true, forKey: "tester")
        let scene = MainMenuScene(fileNamed: "MainMenuScene")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)

        
    }
    func createMultiLineText(textToPrint:String, color:UIColor, fontSize:CGFloat, fontName:String, fontPosition:CGPoint, fontLineSpace:CGFloat)->SKNode{
        
        // create node to hold the text block
        var textBlock = SKNode()
        
        //create array to hold each line
        let textArr = textToPrint.components(separatedBy: "\n")
        
        // loop through each line and place it in an SKNode
        var lineNode: SKLabelNode
        for line: String in textArr {
            lineNode = SKLabelNode(fontNamed: fontName)
            lineNode.text = line
            lineNode.fontSize = fontSize
            lineNode.fontColor = color
            lineNode.fontName = fontName
            lineNode.position = CGPoint(x: fontPosition.x, y: fontPosition.y - CGFloat(textBlock.children.count ) * fontSize + fontLineSpace)
            textBlock.addChild(lineNode)
        }
        
        // return the sknode with all of the text in it
        return textBlock
    }
    func cleanUp() {

        for transaction in SKPaymentQueue.default().transactions {

            SKPaymentQueue.default().finishTransaction(transaction)
        }
    }
     */
}
