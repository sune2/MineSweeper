//
//  GameScene.swift
//  minesweeper
//
//  Created by tamura on 2015/03/05.
//  Copyright (c) 2015年 tamura. All rights reserved.
//

import SpriteKit

enum GameMode {
    case Open
    case Flag
}

class GameScene: SKScene, MyButtonDelegate, GameMainProtocol {
    var R: Int = 1
    var C: Int = 1
    var B: Int = 1

    var _mode: GameMode = .Open
    var mode: GameMode {
        get { return _mode }
        set(val) {
            _mode = val
            self.changeMode()
        }
    }
    var modeButton = MyButton(fontNamed: "Chalkduster")
    var gameMain: GameMainNode = GameMainNode(texture:nil, color:nil, size: CGSizeMake(300,300), R: 1, C: 1, B: 1)
    
    func setStage(R: Int, C: Int, B: Int) {
        self.R = R
        self.C = C
        self.B = B
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        gameMain = GameMainNode(texture:nil, color:UIColor.whiteColor(),
            size: CGSize(width: 300, height: 300), R: self.R, C: self.C, B: self.B)
        gameMain.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        gameMain.delegate = self
        self.addChild(gameMain)
        
        // mode change button
        modeButton.text = "[Open Mode]"
        modeButton.fontSize = 25
        modeButton.position = CGPointMake(CGRectGetMidX(self.frame),70)
        modeButton.name = "mode"
        modeButton.delegate = self
        self.addChild(modeButton)
        
        // retry button
        var retryButton = MyButton(fontNamed: "Chalkduster")
        retryButton.text = "[Retry]"
        retryButton.fontSize = 25
        retryButton.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMaxY(self.frame)-100)
        retryButton.name = "retry"
        retryButton.delegate = self
        self.addChild(retryButton)
    }
    func myButtonPushed(button: MyButton) {
        if button.name == "mode" {
            if mode == .Open {
                mode = .Flag
            } else {
                mode = .Open
            }
            NSLog("mode changed")
        } else if button.name == "retry" {
            self.startGame()
        }
    }
    
    func startGame() {
        let scene = GameScene()
        scene.setStage(5, C:5, B:5)
        // Configure the view.
        let skView = self.view! as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene.scaleMode = .AspectFill
        scene.size = skView.frame.size
        
        skView.presentScene(scene)
    }
    
    func changeMode() {
        gameMain.mode = mode
        if mode == .Open {
            modeButton.text = "[Open Mode]"
        } else {
            modeButton.text = "[Flag Mode]"
        }
    }
    
    func finished(text: String, color: UIColor) {
        let node = SKSpriteNode(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.7), size: self.frame.size)
        node.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        node.zPosition = 2
        self.addChild(node)
        
        var label = self.getLabel(text)
        label.fontColor = color
        node.addChild(label)
        
        var retryButton = MyButton(fontNamed: "Chalkduster")
        retryButton.text = "[Retry]"
        retryButton.name = "retry"
        retryButton.position = CGPoint(x: 0, y: -80)
        retryButton.delegate = self
        node.addChild(retryButton)
    }

    func getLabel(text: String) -> SKLabelNode {
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.fontSize = 60
        label.text = text
        return label
    }

    func gameover() {
        for row in gameMain.cells {
            for cell in row {
                cell.status = GameCellStatus.Opened
            }
        }
        self.finished("GameOver", color: UIColor.redColor())
    }
    
    func cleared() {
        self.finished("Clear!!", color: UIColor.greenColor())
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
