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
    var tilesPlaced: Int = 0 // for beginning of game want to know when it becomes 2 so the submit button can be displayed
    var nSize: Int = 6
    var board: [Int] = []
    var numPositions: [CGFloat] = [0,0,0,0,0,0,0,0,0,0]
    var boardState: [Int] = []
    var numPositionsDict: Dictionary<Int, CGFloat> = [:]
    var boardMapDict: Dictionary<Int, Int> = [:]
    var framesize: Int = 0
    var darkGreen: UIColor = UIColor(red: 0.3765, green: 0.6471, blue: 0.2314, alpha: 1.0)
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
    var illegalMoveMessages: [String] = []
    var gamePieceList: [SKShapeNode] = []
    var startButton: SKShapeNode = SKShapeNode()
    var startButtonLabel: SKLabelNode = SKLabelNode()
    var submitButton: SKShapeNode = SKShapeNode()
    var submitButtonLabel: SKLabelNode = SKLabelNode()
    var redCounter: SKShapeNode = SKShapeNode()
    var blueCounter: SKShapeNode = SKShapeNode()
    var redMoveCircle: SKShapeNode = SKShapeNode()
    var blueMoveCircle: SKShapeNode = SKShapeNode()
    var started: Bool = false
    var movingRed: Bool = false
    var movingBlue: Bool = false
    var touchNothing: Bool = true
    var redPos: Int = 0
    var bluePos: Int = 0
    var movesMade: Int = 0
    var justStarted: Bool = true
    var submitted: Bool = false
    var gameOver: Bool = false
    var messages: SKLabelNode = SKLabelNode()
    // var messageBox: SKShapeNode = SKShapeNode()
    var messageBox: SKSpriteNode = SKSpriteNode()
    var messageBoxWidth: CGFloat = 300.0
    var messageBoxHeight: CGFloat = 200.0

    
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
        let mbx: CGFloat = 0.0
        let mby: CGFloat = 525.0
        messageBoxWidth = 750
        messageBoxHeight = 1334/5
        // messageBox.name = "bar"
        messageBox.size = CGSize(width: messageBoxWidth, height: messageBoxHeight)
        messageBox.color = UIColor(red: 0.8784, green: 0.8588, blue: 0.7098, alpha: 1.0) //SKColor.white
        messageBox.position = CGPoint(x: mbx, y: mby)
        // messageBox = SKShapeNode(rect: CGRect(x: mbx-messageBoxWidth/2, y: mby-messageBoxHeight/2, width: messageBoxWidth, height: messageBoxHeight))
        
        // messageBox.fillColor = UIColor.yellow
        messageBox.zPosition = 10
        messageBox.isHidden = false
        // messages = SKLabelNode(text: "hi")
        messages.text = "Instructions\nTry to get 4 in a row!"
        messages.numberOfLines = 2
        messages.fontName="Optima-ExtraBlack"
        messages.fontColor = .black
        messages.verticalAlignmentMode = .center
        messages.horizontalAlignmentMode = .center
        messages.fontSize = 24.0
        messages.zPosition = 1
        messages.position = CGPoint(x: 0, y: 0)
        messages.zPosition = 10
        messageBox.addChild(messages)
        self.addChild(messageBox)
        
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
        makeButton()
        illegalMoveMessages.append("Illegal Move\nYou must move one of the counters")
        illegalMoveMessages.append("Illegal Move\nThat product has alreaady been played")

    } // func initialize()
    func resetGame() {
        justStarted = true
        movesMade = 0
        messages.text = "Instructions\nTry to get 4 in a row!"
        for i in 0...(35) {
            boardState[i]=0
            gamePieceList[i].fillColor = squareColor
        }
        started = false
        movingRed = false
        movingBlue = false
        redPos = 0
        bluePos = 0
        movesMade = 0
        justStarted = true
        gameOver = false
        redCounter.position = CGPoint(x: -50, y: -450)
        blueCounter.position = CGPoint(x: 50, y: -450)
    }
    
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
        redMoveCircle.strokeColor = UIColor.blue
        redMoveCircle.lineWidth = 10.0
        redMoveCircle.position = CGPoint(x: 80*(1-5), y: 0)
        redMoveCircle.zPosition = 6
        redMoveCircle.isHidden = true
        numberFrame2.addChild(redMoveCircle)
        print("added a redMoveCircle ")
        blueMoveCircle = SKShapeNode(circleOfRadius: cRad)
        blueMoveCircle.name = "mover2"
        blueMoveCircle.strokeColor = UIColor.blue
        blueMoveCircle.lineWidth = 10.0
        blueMoveCircle.position = CGPoint(x: 80*(1-5), y: 0)
        blueMoveCircle.zPosition = 6
        blueMoveCircle.isHidden = true
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
        redCounter.fillColor = UIColor.blue
        redCounter.name = "redCounter"
        redCounter.zPosition = 10
        redCounter.position = CGPoint(x: -50, y: -450)
        redCounter.isHidden = true
        self.addChild(redCounter)
        print("made a redCounter")
        blueCounter = SKShapeNode(circleOfRadius: cRad)
        blueCounter.fillColor = UIColor.blue
        blueCounter.name = "blueCounter"
        blueCounter.zPosition = 10
        blueCounter.position = CGPoint(x: 50, y: -450)
        blueCounter.isHidden = true
        self.addChild(blueCounter)
        print("made a blueCounter")
        // redCounter.fillColor = UIColor.red
        // self.addChild(redCounter)
    } //func makeCounters()
    
    func makeButton() {
        var buttonWidth: CGFloat = 400.0
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
        // print("made a redCounter")
        submitButton = SKShapeNode(rect: CGRect(x: -buttonWidth/2, y: -450-buttonHeight/2, width: buttonWidth, height: buttonHeight))
        submitButton.fillColor = darkGreen
        submitButton.name = "submitButton"
        submitButton.zPosition = 5
        // var startLabel: SKLabelNode = SKLabelNode()
        submitButtonLabel.text = "Submit"
        submitButtonLabel.fontName="Optima-ExtraBlack"
        submitButtonLabel.fontSize = 48
        submitButtonLabel.zPosition = 10
        submitButtonLabel.position = CGPoint(x: 0, y: -450)
        submitButton.addChild(submitButtonLabel)
        submitButton.isHidden = true
        self.addChild(submitButton)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            touchNothing = true
            for node in touchedNode {
                print("nodename")
                print(node.name)
                if node.name == "startButton" {
                    print("start button")
                    touchNothing = false
                    redCounter.isHidden = false
                    blueCounter.isHidden = false
                    // redMoveCircle.isHidden = false
                    // blueMoveCircle.isHidden = false
                    startButton.isHidden = true
                    submitButton.isHidden = false
                    // startButtonLabel.text = "
                    resetGame()
                }
                else if node.name == "redCounter" {
                    touchNothing = false
                    print("found red counter")
                    movingRed = true
                    startingXPostion = node.position.x
                    break
                }
                else if node.name == "blueCounter" {
                    print("found blue counter")
                    touchNothing = false
                    startingXPostion = node.position.x
                    movingBlue = true
                    break
                }
                else {
                    touchNothing = true
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
                blueMoveCircle.isHidden = false
            }
            else {
                redMoveCircle.isHidden = false
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
        print("touchNothing")
        print(touchNothing)
        if (!started) {
            started = true
            messages.fontSize = 48.0
            messages.fontColor = UIColor.red
            messages.text = "Player 1\nMove both counters"
            return // break
        }
        if (touchNothing) {
            return
        }

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
        var oldBluePos = bluePos
        var oldRedPos = redPos
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
            justStarted = false
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
            makeMove(tempBoardPos: tempBoardPos)
            /* if (movesMade%2==0) {
                gamePieceList[tempBoardPos].fillColor = UIColor(red: 0.3765, green: 0.6471, blue: 0.2314, alpha: 1.0) //UIColor.green
                boardState[tempBoardPos]=1
            }
            else {
                gamePieceList[tempBoardPos].fillColor = UIColor.red
                boardState[tempBoardPos]=2
            }
            */
        }
        
        if (tempBoardPos == -1 && product>0) {
            redC.position.x = startingXPostion
            moveC.position.x = startingXPostion
            bluePos = oldBluePos
            redPos = oldRedPos
            messages.text = "Illegal move\nThat space is taken.  Try again."
        }
        else {
            movesMade += 1
            if (movesMade%2 == 0) {
                messages.fontColor = darkGreen
                messages.text = "Player 2\nMove one of the counters"
                messages.numberOfLines = 2
            }
            else if (movesMade>1){
                messages.fontColor = UIColor.red
                messages.text = "Player 1\nMove one of the counters"
                messages.numberOfLines = 2
            }
            // print(boardState)
            if (checkAll()>0) {
                gameOver = true
            }
            var possibleMoves = 36
            if (!justStarted) {
                possibleMoves = checkDraw(blue: bluePos, red: redPos)
                // print(getRepeats(numbers: [1,2,1,2,2,1]))
                print("possible moves",possibleMoves)
                if (possibleMoves == 0) {
                    print("Draw!")
                    gameOver == true
                }
            }
            if (gameOver) {
                redCounter.isHidden = true
                blueCounter.isHidden = true
                redMoveCircle.isHidden = true
                blueMoveCircle.isHidden = true
                messageBox.isHidden = false
                if (possibleMoves == 0) {
                    messages.fontColor = UIColor.black
                    messages.text = "Draw"
                }
                else {
                    messages.fontColor = UIColor.black
                    messages.text = "Game Over"
                    if (movesMade%2==0) {
                        messages.fontColor = UIColor.red
                        messages.text = "Game Over\nPlayer 1 wins!"
                        messages.numberOfLines = 2
                    }
                    else {
                        messages.fontColor = darkGreen
                        messages.text = "Game Over\nPlayer 2 wins!"
                        messages.numberOfLines = 2
                    }
                    started = true
                    startButton.isHidden = false
                    submitButton.isHidden = true
                    redCounter.isHidden = true
                    blueCounter.isHidden = true
                    redMoveCircle.isHidden = true
                    blueMoveCircle.isHidden = true
                    justStarted = true
                }

            }
        }

        
    } // func touchesEnded
    
    func makeMove(tempBoardPos: Int) {
        if (movesMade%2==0) {
            gamePieceList[tempBoardPos].fillColor = UIColor(red: 0.3765, green: 0.6471, blue: 0.2314, alpha: 1.0) //UIColor.green
            boardState[tempBoardPos]=1
        }
        else {
            gamePieceList[tempBoardPos].fillColor = UIColor.red
            boardState[tempBoardPos]=2
        }
    }

    func checkDraw(blue: Int, red: Int)->Int {
        print("in checkDraw")
        print(blue,red)
        // returns 1 if it is a draw and a 0 if it isn't
        var count: Int = 0
        // will count how many legal moves are possible on the next turn
        // if it is 0, the game is a draw
        var i: Int = 1
        while (i<10) {
            // print(boardState[boardMapDict[i*blue]!])
            if (boardState[boardMapDict[i*blue]!]==0) {
                count += 1
            }
            if (boardState[boardMapDict[i*red]!]==0) {
                count += 1
            }
            i = i+1
        }
        return count
    }
    
    func checkAll()->Int {
        var toCheck:[[Int]] = []
        toCheck.append([0,1,2,3,4,5])
        toCheck.append([6,7,8,9,10,11])
        toCheck.append([12,13,14,15,16,17])
        toCheck.append([18,19,20,21,22,23])
        toCheck.append([24,25,26,27,28,29])
        toCheck.append([30,31,32,33,34,35])
        toCheck.append([0,6,12,18,24,30])
        toCheck.append([1,7,13,19,25,31])
        toCheck.append([2,8,14,20,26,32])
        toCheck.append([3,9,15,21,27,33])
        toCheck.append([4,10,16,22,28,34])
        toCheck.append([5,11,17,23,29,35])
        toCheck.append([12,19,26,33])
        toCheck.append([6,13,20,27,34])
        toCheck.append([0,7,14,21,28,35])
        toCheck.append([1,8,15,22,29])
        toCheck.append([2,9,16,23])
        toCheck.append([3,8,13,18])
        toCheck.append([4,9,14,19,24])
        toCheck.append([5,10,15,20,25,30])
        toCheck.append([11,16,21,26,31])
        toCheck.append([17,22,27,32])
        var winner: Int = 0
        for i in toCheck {
            var numList = getNums(numbers: i)
            // print(numList)
            winner = getRepeats(numbers: numList)
            if (winner>0) {
                print(String(winner)+" wins!")
                messages.text = String(winner)+" wins!"
                return winner
            }
        }
        return 0
    }
    func getNums(numbers: [Int])->[Int] {
        var theNums: [Int] = []
        for i in numbers {
            theNums.append(boardState[i])
        }
        return theNums
    }
    func getRepeats(numbers: [Int])->Int {
        // returns 0 if no 4 in a row
        // returns 1 if 4 1s in a row
        // returns 2 if 4 2s in a row
        var count = 0
        var n = -1
        for i in numbers {
            if (i != n) {
                count = 1 // found a new number
            }
            else {
                count += 1
                if (count == 4) {
                    return i
                }
            }
            n = i
        }
        return 0
    }
}
