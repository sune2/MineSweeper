//
//  GameMainNode.swift
//  minesweeper
//
//  Created by tamura on 2015/03/05.
//  Copyright (c) 2015年 tamura. All rights reserved.
//

import SpriteKit

class GameMainNode: SKSpriteNode, GameCellProtocol {
    let R: Int = 1
    let C: Int = 1
    let mode: GameMode = .Open
    var cells: [[GameCellNode]] = [[]]
    init(texture: SKTexture!, color: UIColor!, size: CGSize, R: Int, C: Int) {
        self.R = R
        self.C = C
        super.init(texture: texture, color: color, size: size)
        
        let edgeSize: CGFloat = 4
        let h = (size.height-edgeSize) / CGFloat(R)
        let w = (size.width-edgeSize)  / CGFloat(C)
        for i in 0..<R {
            var row: [GameCellNode] = []
            for j in 0..<C {
                let cell = GameCellNode(texture: nil, color: UIColor.grayColor() ,size: CGSize(width: w-4, height: h-4))
                let y = CGRectGetMinY(self.frame) + edgeSize / 2 + h / 2 + CGFloat(i) * h
                let x = CGRectGetMinX(self.frame) + edgeSize / 2 + w / 2 + CGFloat(j) * w
                cell.position = CGPoint(x: x, y: y)
                cell.row = i
                cell.col = j
                cell.delegate = self
                self.addChild(cell)
                row.append(cell)
            }
            cells.append(row)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bombed(cell: GameCellNode) {
        NSLog("bombed \(cell.status), \(cell.row), \(cell.col)")
    }
    func opened(cell: GameCellNode) {
        NSLog("opened \(cell.status), \(cell.row), \(cell.col)")
    }
    func getMode() -> GameMode {
        return self.mode
    }
}