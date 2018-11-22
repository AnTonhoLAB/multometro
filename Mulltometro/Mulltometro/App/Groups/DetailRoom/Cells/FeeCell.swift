//
//  FeeCell.swift
//  Mulltometro
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
    
    var fee: Fee?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(with fee: Fee) {
        lbFeeName.text = fee.nameFee
        lbValuePerFee.text = String(fee.valuePerType)
        lbSybol.text = fee.simbleType
    }
}
