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

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let cell = GameMainNode(texture:nil, color:UIColor.whiteColor(),
            size: CGSize(width: 300, height: 300), R: 5, C: 5, B: 5)
        cell.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        self.addChild(cell)
        
        // button
        let button = MyButton(fontNamed: "Chalkduster")
        button.text = "hfdksljfkdsjfdlskjfkdlsj"
        button.fontSize = 25
        button.position = CGPointMake(10,50)
        self.addChild(button)
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
