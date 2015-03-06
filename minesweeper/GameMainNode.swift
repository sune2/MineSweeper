//
//  GameMainNode.swift
//  minesweeper
//
//  Created by tamura on 2015/03/05.
//  Copyright (c) 2015年 tamura. All rights reserved.
//

import SpriteKit

// ランダムシャッフル追加
extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

class GameMainNode: SKSpriteNode, GameCellProtocol {
    let R: Int = 1
    let C: Int = 1
    let B: Int = 1
    let mode: GameMode = .Open
    var cells: [[GameCellNode]] = []
    init(texture: SKTexture!, color: UIColor!, size: CGSize, R: Int, C: Int, B: Int) {
        self.R = R
        self.C = C
        self.B = B
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
        // 盤面の生成
        self.createGame()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createGame() {
        // generate bombs
        var cellids: [[Int]] = []
        for i in 0..<R {
            for j in 0..<C {
                cellids.append([i,j])
            }
        }
        cellids.shuffle()
        for i in 0..<B {
            let y = cellids[i][0]
            let x = cellids[i][1]
            cells[y][x].num = -1
        }
        // calculate num of each cells
        for y in 0..<R {
            for x in 0..<C {
                if cells[y][x].num == -1 {
                    continue
                }
                var cnt = 0
                for dy in -1...1 {
                    for dx in -1...1 {
                        let yy = y + dy
                        let xx = x + dx
                        if yy < 0 || yy >= R || xx < 0 || xx >= C {
                            continue
                        }
                        cnt += cells[y+dy][x+dx].num == -1 ? 1 : 0
                    }
                }
                cells[y][x].num = cnt
            }
        }
        
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