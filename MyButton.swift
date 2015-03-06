//
//  MyButton.swift
//  minesweeper
//
//  Created by tamura on 2015/03/06.
//  Copyright (c) 2015年 tamura. All rights reserved.
//

import SpriteKit

protocol MyButtonDelegate {
    func myButtonPushed(button: MyButton)
}

class MyButton: SKLabelNode {
    var _highlighted: Bool = false
    var delegate: MyButtonDelegate!
    var baseSize: CGFloat = 25
    var highlighted: Bool {
        get {
            return _highlighted
        }
        set(val) {
            _highlighted = val
            self.fontSize = _highlighted ? baseSize * CGFloat(1.1) : baseSize;
        }
    }
    override init(fontNamed fontName: String!) {
        super.init(fontNamed: fontName)
        self.userInteractionEnabled = true
    }
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.highlighted = true
    }
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        self.highlighted = false
    }
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.highlighted = false
        var pushed = false
        for touch in touches {
            let node = self.parent!.nodeAtPoint(touch.locationInNode(self.parent))
            if node == self {
                pushed = true
            }
        }
        if pushed {
            delegate.myButtonPushed(self)
        }
    }
}