//
//  purchasePlus.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 1/26/22.
//  Copyright © 2022 com.garyrubinstein. All rights reserved.
//

import SpriteKit
import StoreKit
var plus = false
var numgames = 0
let ProductID = "com.example.nonconsumable"// "unlimiteduseproductgame" //"com.example.nonconsumable" //"unlimiteduseproductgame"
var instructionsNode: SKNode = SKNode()
var instructionsBox = SKShapeNode()

class PurchasePlusScene: SKScene, SKPaymentTransactionObserver {
    override func didMove(to view: SKView) {
        if let getBool = UserDefaults.standard.value(forKey: "plus") as? Bool {
            UserDefaults.standard.set(getBool, forKey: "plus")
        }
        else {
            UserDefaults.standard.set(false, forKey: "plus")
        }
        print("stored plus is")
        plus = UserDefaults.standard.value(forKey: "plus")! as! Bool
        print("plus variable is")
        print(plus)
        SKPaymentQueue.default().add(self)
        // SKPaymentQueue.default().add(self)
        makeMenu()
    }
    /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        if let scene = MainMenuScene(fileNamed: "mainMenu") {
        // if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            self.view!.presentScene(scene)
        }
    }
    */
/*    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            // print("hi")
            var doFinish = true
            if transaction.transactionState == .purchased {
                print("purchased")
                plus = true
                UserDefaults.standard.set(true, forKey: "plus")
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
            else if transaction.transactionState == .restored {
                print("restored")
                plus = true
                UserDefaults.standard.set(true, forKey: "plus")
                let scene = MainMenuScene(fileNamed: "MainMenuScene")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
            else if transaction.transactionState == .failed {
                print("failed!")
                plus = false
                // plus = true // for now
                UserDefaults.standard.set(false, forKey: "plus")
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
    
    
    func purchasePlus() -> Bool {
        if SKPaymentQueue.canMakePayments() {
            print("making payment")
            // plus = true
            // UserDefaults.standard.set(true, forKey: "tester")
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = ProductID
            SKPaymentQueue.default().add(paymentRequest)
            return true
        }
        else {
            print("payment failed")
            return false
        }
        
        // UserDefaults.standard.set(true, forKey: "tester")
        // let scene = MainMenuScene(fileNamed: "MainMenuScene")
        // scene!.scaleMode = .aspectFit
        // self.view?.presentScene(scene)
    }
    
    func restorePlus() -> Bool {
        print("In restorePlus")
        print(SKPaymentQueue.default().restoreCompletedTransactions())
        return false
    }

    func purchasePlus2() {
        plus = true
        UserDefaults.standard.set(true, forKey: "tester")
        let scene = MainMenuScene(fileNamed: "MainMenuScene")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)

        
    }
 */
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            // print("hi")
            var doFinish = true
            if transaction.transactionState == .purchased {
                print("purchased")
                plus = true
                UserDefaults.standard.set(true, forKey: "tester")
                let scene = MainMenuScene(fileNamed: "mainMenu")
                scene!.scaleMode = .aspectFit
                self.view?.presentScene(scene)
            }
            else if transaction.transactionState == .restored {
                print("restored")
                plus = true
                UserDefaults.standard.set(true, forKey: "tester")
                let scene = MainMenuScene(fileNamed: "mainMenu")
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
    func makeMenu() {
        var yesorno = "no"
        if (plus) {
            yesorno = "yes"
        }
        var instructionText: String =
        "Plus is "+yesorno+"\nI hope you have enjoyed\nyour 10 free plays!\nTo get unlimited play\nclick 'buy' for $0.99\nIf you have previously\n unlocked, click 'buy'\nand you will not be\ncharged again."
        instructionsNode = createMultiLineText(textToPrint: instructionText, color: UIColor.white, fontSize: 48, fontName: "Helvetica", fontPosition: CGPoint(x: 0.0, y: 250.0), fontLineSpace: 0.0)
        let inBox: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 600, height: 600))
        inBox.fillColor = UIColor.purple
        instructionsBox = inBox
        instructionsBox.zPosition = 20
        // instructionsBox.addChild(instructionsText)
        instructionsBox.addChild(instructionsNode)
        let iapCancelButton = SKShapeNode(rectOf: CGSize(width: 150, height: 60))
        iapCancelButton.fillColor = UIColor.red
        iapCancelButton.position = CGPoint(x: -200.0, y: -250.0)
        iapCancelButton.name = "iapcancel"
        let cancelText = SKLabelNode(text: "CANCEL")
        cancelText.zPosition = 25
        cancelText.fontSize = 36
        cancelText.fontColor = UIColor.black
        cancelText.fontName = "AvenirNext-Bold"
        iapCancelButton.addChild(cancelText)
        // instructionsBox.addChild(iapCancelButton)
        let iapBuyButton = SKShapeNode(rectOf: CGSize(width: 150, height: 60))
        iapBuyButton.fillColor = UIColor(red: 0, green: 0.6392, blue: 0.0078, alpha: 1.0)
        iapBuyButton.position = CGPoint(x: 0.0, y: -250.0)
        iapBuyButton.name = "iapbuy"
        let buyText = SKLabelNode(text: "BUY")
        buyText.zPosition = 25
        buyText.fontSize = 36
        buyText.fontColor = UIColor.black
        buyText.fontName = "AvenirNext-Bold"
        iapBuyButton.addChild(buyText)
        instructionsBox.addChild(iapBuyButton)
        let iapRestoreButton = SKShapeNode(rectOf: CGSize(width: 150, height: 60))
        iapRestoreButton.fillColor = UIColor.yellow
        iapRestoreButton.position = CGPoint(x: 200.0, y: -250.0)
        iapRestoreButton.name = "iaprestore"
        let restoreText = SKLabelNode(text: "RESTORE")
        restoreText.zPosition = 25
        restoreText.fontSize = 32
        restoreText.fontColor = UIColor.black
        restoreText.fontName = "AvenirNext-Bold"
        iapRestoreButton.addChild(restoreText)
        // instructionsBox.addChild(iapRestoreButton)
        self.addChild(instructionsBox)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var scenename = ""
        if let touch = touches.first {
            let location = touch.location(in: self)
            // print(location)
            
            let nodes = self.nodes(at: location)
            for node in nodes {
                // print(node.name!)
                if let nodeName = node.name {
                    print("The node name is \(nodeName)")
                    if nodeName.hasPrefix("iap") {
                        print("prefix iap")
                        if nodeName.hasPrefix("iapcancel") {
                            print("iap cancel")
                            // instructionsBox.isHidden = true
                        }
                        else if nodeName.hasPrefix("iapbuy"){
                            print("buy")
                            let result2  = purchasePlus()
                            // print("purchasePluse() returned"+String(result2))
                            // instructionsBox.isHidden = true
                        }
                        else {
                            print("restore")
                            let result = restorePlus()
                            // print("restore returned"+String(result))
                            // instructionsBox.isHidden = true
                        }
                    }
                }
            }
        }
    }
}
