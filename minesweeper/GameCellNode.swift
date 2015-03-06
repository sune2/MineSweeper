//
//  GameGridNode.swift
//  minesweeper
//
//  Created by tamura on 2015/03/05.
//  Copyright (c) 2015年 tamura. All rights reserved.
//

import SpriteKit

protocol GameCellProtocol {
    func opened(cell: GameCellNode)
    func bombed(cell: GameCellNode)
    func getMode() -> GameMode
}

enum GameCellStatus {
    case Unopened
    case Flagged
    case Opened
}

class GameCellNode: SKSpriteNode {
    var delegate: GameCellProtocol!
    var _status: GameCellStatus = .Unopened
    var status: GameCellStatus {
        get {
            return _status
        }
        set(val) {
            _status = val
            self.draw()
        }
    }
    var row: Int = 0, col: Int = 0, num: Int = 0
    var label: SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    override init(texture: SKTexture!, color: UIColor!, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.userInteractionEnabled = true
        // init label
        label.fontSize = 25
        label.verticalAlignmentMode = .Center
        label.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(label)
        
        self.addChild(SKSpriteNode(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(10, 10)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        switch delegate.getMode() {
        case .Open:
            if status == .Unopened {
                status = .Opened
                if num >= 0 {
                    delegate.opened(self)
                } else {
                    delegate.bombed(self)
                }
            }
        case .Flag:
            if status == .Unopened {
                status = .Flagged
            } else if status == .Flagged {
                status = .Unopened
            }
        }
    }
    func draw() {
        switch status {
        case .Unopened:
            label.text = ""
        case .Flagged:
            label.text = "🚩"
        case .Opened:
            if num == -1 {
                label.text = "🔥"
            } else if num == 0 {
                label.text = "*"
            } else {
                label.text = "\(num)"
            }
        }
    }
}