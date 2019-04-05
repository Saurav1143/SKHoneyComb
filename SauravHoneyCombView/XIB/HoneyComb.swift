//
//  HoneyComb.swift
//  SauravHoneyCombView
//
//  Created by Sourav on 4/5/19.
//  Copyright © 2019 Saurav. All rights reserved.
//

import UIKit

class HoneyComb: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var honeyCombButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        intialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        intialize()
    }
    
    private func intialize() {
        Bundle.main.loadNibNamed("HoneyComb", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame.size = self.frame.size
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
}
