//
//  GameScene.swift
//  rubinsteinMathGames
//
//  Created by Gary Old Mac on 4/14/20.
//  Copyright © 2020 com.garyrubinstein. All rights reserved.
//

import SpriteKit
// import GameplayKit

class GameScene: SKScene {
    var screenWidth: CGFloat = 0.0
    var screenHeight: CGFloat = 0.0
    var theSize: CGFloat = 0.0
    var nSize: Int = 6
    var board: [Int] = []
    var numPositions: [CGFloat] = [0,0,0,0,0,0,0,0,0,0]
    var boardState: [Int] = []
    var numPositionsDict: Dictionary<Int, CGFloat> = [:]
    var boardMapDict: Dictionary<Int, Int> = [:]
    var framesize: Int = 0
    var scalePieces: CGFloat = 1.4
    var theMode: Int = 0
    var frameOffset: Int = 0
    var frameOffsetX: Int = 0
    var cRad: CGFloat = 35.0
    var numFrameY: CGFloat = -600.0
    var startingXPostion: CGFloat = 0.0
    var squareColor: UIColor = UIColor(red: 0.8784, green: 0.8588, blue: 0.7098, alpha: 1.0)
    // var squareColor: UIColor = UIColor(red: 0.8392, green: 0.7961, blue: 0, alpha: 1.0) // UIColor.yellow
    var nodelist: [SKShapeNode] = []
    var textnodelist: [SKLabelNode] = []
    var numberList: [Int] = []
    var gamePieceList: [SKShapeNode] = []
    var redCounter: SKShapeNode = SKShapeNode()
    var blueCounter: SKShapeNode = SKShapeNode()
    var redMoveCircle: SKShapeNode = SKShapeNode()
    var blueMoveCircle: SKShapeNode = SKShapeNode()

    var movingRed: Bool = false
    var movingBlue: Bool = false
    var redPos: Int = 0
    var bluePos: Int = 0
    var movesMade: Int = 0

    
    // private var label : SKLabelNode?
    //private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = self.size.width //screenSize.width
        screenHeight = self.size.height // screenSize.height
        print(screenWidth)
        print(screenHeight)
        theSize = min(screenWidth,screenHeight)
        print("theSize")
        print(theSize)
        // addMoveList()
        framesize = Int(2/3*theSize*scalePieces)
        initialize()
    
    }
    
    func initialize() {
        // makeCounters()
        if nSize==6 {
            numberList = [1,2,3,4,5,6,7,8,9,10,12,14,15,16,18,20,21, 24,
            25, 27, 28, 30, 32, 35, 36, 40, 42, 45, 48, 49, 54, 56, 63, 64,
            72, 81]
        }
        let myframe = SKShapeNode(rect: CGRect(x: -framesize/2-frameOffsetX, y: -framesize/2-frameOffset, width: framesize, height: framesize))
        myframe.fillColor = UIColor.red
        myframe.zPosition = 3 // this was 3
        myframe.name = "frame"
        self.addChild(myframe)
        for i in 0...(nSize*nSize-1) {
            // print(i)
            boardMapDict.updateValue(i, forKey: numberList[i])
            board.append(Int(i+1))
            boardState.append(0)
            let row = Int(i/nSize)
            let column = i%nSize
            var squareWidth: CGFloat = CGFloat(framesize/nSize)
            var squareHeight: CGFloat = CGFloat(framesize/nSize)

            let gamePiece = SKShapeNode(rect: CGRect(x: 0, y: 0, width: squareWidth, height: squareWidth))
            gamePiece.name = "piece"+String(i)
            gamePieceList.append(gamePiece)
            gamePiece.fillColor = squareColor

            gamePiece.strokeColor = UIColor.black
            gamePiece.zPosition = 4
            // let gamePiecePosition = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize-frameOffset)
            let gamePiecePosition = CGPoint(x: -framesize/2+column*framesize/nSize-frameOffsetX, y: framesize/2-framesize/nSize-row*framesize/nSize-frameOffset)
            
            
            // originalPositions.append(gamePiecePosition)
            // gamePiece.position = CGPoint(x: -framesize/2+column*framesize/puzzleSize, y: framesize/2-framesize/puzzleSize-row*framesize/puzzleSize-frameOffset)
            gamePiece.position = gamePiecePosition
         
            
            
            let tritext = SKLabelNode(text: String(numberList[i]))
            tritext.fontColor = UIColor.black
            tritext.fontName = "AvenirNext-Bold"
            tritext.fontSize = 64
            tritext.horizontalAlignmentMode = .center
            tritext.verticalAlignmentMode = .center
            tritext.position = CGPoint(x: framesize/(nSize*2), y: framesize/(nSize*2))
            tritext.name = "text"+String(i+1)
            tritext.zPosition = 1
            textnodelist.append(tritext)
            gamePiece.addChild(tritext)
            nodelist.append(gamePiece)
            myframe.addChild(gamePiece)
            // tritext.position = CGPoint(x: 0, y: 0)
            // self.addChild(myflash)
            // makeNumbers()
            // makeCounters()
        } // for i in 0...(nSize*nSize-1) {
        makeCounters()
        makeNumbers()
    } // func initialize()
    
    func makeNumbers() {
        let numberFrame2 = SKSpriteNode(color: UIColor.clear, size: CGSize(width: screenWidth, height: 200))
        numberFrame2.position = CGPoint(x: 0, y: numFrameY)
        numberFrame2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        numberFrame2.zPosition = 3
        let numberFrame = SKShapeNode(rect: CGRect(x: -screenWidth/2, y: -600, width: screenWidth, height: 200.0))
        numberFrame.fillColor = UIColor.red
        numberFrame.zPosition = 3 // this was 3
        numberFrame.name = "numberframe"
        // self.addChild(numberFrame)
        redMoveCircle = SKShapeNode(circleOfRadius: cRad)
        redMoveCircle.name = "mover"
        redMoveCircle.strokeColor = UIColor.red
        redMoveCircle.lineWidth = 10.0
        redMoveCircle.position = CGPoint(x: 80*(1-5), y: 0)
        redMoveCircle.zPosition = 6
        numberFrame2.addChild(redMoveCircle)
        print("added a redMoveCircle ")
        blueMoveCircle = SKShapeNode(circleOfRadius: cRad)
        blueMoveCircle.name = "mover2"
        blueMoveCircle.strokeColor = UIColor.blue
        blueMoveCircle.lineWidth = 10.0
        blueMoveCircle.position = CGPoint(x: 80*(1-5), y: 0)
        blueMoveCircle.zPosition = 6
        numberFrame2.addChild(blueMoveCircle)
        print("added a blueMoveCircle ")
        
        for i in 1...9 {

            let tritext = SKLabelNode(text: String(i))
            tritext.fontColor = UIColor.black
            tritext.fontName = "AvenirNext-Bold"
            tritext.fontSize = 64
            tritext.horizontalAlignmentMode = .center
            tritext.verticalAlignmentMode = .center
            var hpos : CGFloat = CGFloat(80*(i-5))
            numPositions[i] = hpos
            numPositionsDict.updateValue(hpos, forKey: i)
            tritext.position = CGPoint(x: hpos, y: 0) // hardcoded for now
            // tritext.position = CGPoint(x: framesize/(nSize*2), y: framesize/(nSize*2))
            // changing
            tritext.name = "numtext"+String(i)
            tritext.zPosition = 10
            numberFrame2.addChild(tritext)
        }  //for i in 1...9
        // self.addChild(numberFrame)
        self.addChild(numberFrame2)
//        var redCounter: SKShapeNode = //SKShapeNode(circleOfRadius: 50.0)
      //  redCounter.fillColor = UIColor.red
        //redCounter.name = "redcounter"

    } // func makeNumbers()
    
    func makeCounters() {
        // var redCounter: SKShapeNode = SKShapeNode(circleOfRadius: 50.0)
        redCounter = SKShapeNode(circleOfRadius: cRad)
        redCounter.fillColor = UIColor.red
        redCounter.name = "redCounter"
        redCounter.zPosition = 10
        redCounter.position = CGPoint(x: 0, y: -450)
        self.addChild(redCounter)
        print("made a redCounter")
        blueCounter = SKShapeNode(circleOfRadius: cRad)
        blueCounter.fillColor = UIColor.blue
        blueCounter.name = "blueCounter"
        blueCounter.zPosition = 10
        blueCounter.position = CGPoint(x: 100, y: -450)
        self.addChild(blueCounter)
        print("made a blueCounter")
        // redCounter.fillColor = UIColor.red
        // self.addChild(redCounter)
    } //func makeCounters()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "redCounter" {
                    print("found red counter")
                    movingRed = true
                    startingXPostion = node.position.x
                    break
                }
                else if node.name == "blueCounter" {
                    print("found blue counter")
                    startingXPostion = node.position.x
                    movingBlue = true
                    break
                }
            }
        }
    } // func touchesBegan()
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (movingRed || movingBlue) {
          // 2
          let touch = touches.first
          let touchLocation = touch!.location(in: self)
          let previousLocation = touch!.previousLocation(in: self)
          // 3
            var nodeName = "redCounter"
            var circleName = "//mover"
            if movingBlue {
                nodeName = "blueCounter"
                circleName = "//mover2"
            }
        
          let redC = childNode(withName: nodeName) as! SKShapeNode
          let moveC = childNode(withName: circleName) as! SKShapeNode
          // let moveC: SKShapeNode = redMoveCircle
            // let moveC = childNode(withName: "moveCircle")
            // 4
          // 6
            var redY = redC.position.y + (touchLocation.y - previousLocation.y)
            // 6
          var redX = redC.position.x + (touchLocation.x - previousLocation.x)
          var redCircleX = redMoveCircle.position.x + (touchLocation.x - previousLocation.x)
            if movingBlue {
              redCircleX = blueMoveCircle.position.x + (touchLocation.x - previousLocation.x)
            }
            redC.position = CGPoint(x: redX, y: redY)
            // print("redX is",redX)
            // round to the nearest 80
            let rounded: CGFloat = CGFloat(roundf(Float(redX/80)))
            // redMoveCircle.position.x = CGFloat(Double(rounded) * 80.0)
            if movingRed {
                redMoveCircle.position.x = CGFloat(rounded*80)
            }
            else if movingBlue {
                blueMoveCircle.position.x = CGFloat(rounded*80)

            }
        }
        /* print("moving")
        for touch in touches {
            if movingRed {
                print("red to")
                print(touch.location(in: self))
                redCounter.position = CGPoint(x: 0.0,y: 0.0)
                // redCounter.position = touch.location(in: self)
            }
        }*/
    } // func touchesMoved
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch ended")

        var nodeName = "redCounter"
        var circleName = "//mover"
        if movingBlue {
            nodeName = "blueCounter"
            circleName = "//mover2"
        }
        let redC = childNode(withName: nodeName) as! SKShapeNode
        let moveC = childNode(withName: circleName) as! SKShapeNode
        redC.position.x = moveC.position.x
        print(redC.position.x/80+5)
        if (nodeName=="blueCounter") {
            bluePos = Int(redC.position.x/80+5)
        }
        else {
            redPos = Int(redC.position.x/80+5)
        }
        print("bluePos: "+String(bluePos))
        print("redPos: "+String(redPos))
        var product = bluePos * redPos
        print("product "+String(product))
        var tempBoardPos = -1
        if let boardPos: Int = boardMapDict[product] {
            print(boardPos)
            if (boardState[boardPos]==0) {
                tempBoardPos = boardPos
            }
        }
        else {
            print("just started")
        }
        // var boardPos: Int = boardMapDict[product]!
        // print(boardPos)
        // print(boardMapDict.someKey(forValue: 64))
        redC.position.y = numFrameY
        movingRed = false
        movingBlue = false
        // update color of square
        if (tempBoardPos > -1) {
            if (movesMade%2==0) {
                gamePieceList[tempBoardPos].fillColor = UIColor.green
                boardState[tempBoardPos]=1
            }
            else {
                gamePieceList[tempBoardPos].fillColor = UIColor.red
                boardState[tempBoardPos]=2
            }
        }
        
        if (tempBoardPos == -1 && product>0) {
            redC.position.x = startingXPostion
            moveC.position.x = startingXPostion
        }
        else {
            movesMade += 1
            print(boardState)
        }

        
    } // func touchesEnded
    func checkRows() {
        print("checking rows")
    }
    func checkDiagonals() {
        print("checking diagonals")
    }
    
}
