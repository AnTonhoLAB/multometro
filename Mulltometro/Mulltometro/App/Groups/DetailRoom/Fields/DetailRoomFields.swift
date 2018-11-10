//
//  DetailRoomFieldsViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 06/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class DetailRoomFields: UIView {
    
    @IBOutlet var contentView: DetailRoomFields!
    @IBOutlet weak var lbAdmin: UILabel!
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DetailRoomFields", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
