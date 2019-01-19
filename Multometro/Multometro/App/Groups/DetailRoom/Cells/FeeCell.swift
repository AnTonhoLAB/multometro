//
//  FeeCell.swift
//  Multometro
//
//  Created by George Gomes on 17/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class FeeCell: UITableViewCell {
    // Mark: - Class Property
    static let identifier: String = "FeeCell"
    
    // Mark: - Outlets
    @IBOutlet weak var backgroundRedView: UIView! {
        didSet {
            backgroundRedView.roundedCornerColor(radius: 8.0)
        }
    }
    @IBOutlet weak var lbFeeName: UILabel!
    @IBOutlet weak var lbValuePerFee: UILabel!
    @IBOutlet weak var lbSybol: UILabel!
    
    var fee: Rule?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with fee: Rule) {
        lbFeeName.text = fee.name
        lbValuePerFee.text = String(fee.valuePerFee)
        lbSybol.text = fee.symbol.decode()
    }
}
