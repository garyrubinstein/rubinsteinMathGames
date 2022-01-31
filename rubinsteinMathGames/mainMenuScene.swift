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
