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
    
    // MARK: - Localized Outlets
    @IBOutlet weak var lbLValuePerFee: UILabel! {
        didSet {
           lbLValuePerFee.text = R.string.localizable.valuePerFee()
        }
    }
    @IBOutlet weak var lBLValueType: UILabel! {
        didSet {
            lBLValueType.text = R.string.localizable.valueType()
        }
    }
    @IBOutlet weak var lbLSymbol: UILabel! {
        didSet {
            lbLSymbol.text = R.string.localizable.symbol()
        }
    }
    
    // Mark: - Outlets
    @IBOutlet weak var backgroundRedView: UIView! {
        didSet {
            backgroundRedView.roundedCornerColor(radius: 8.0)
        }
    }
    @IBOutlet weak var lbFeeName: UILabel!
    @IBOutlet weak var lbValuePerFee: UILabel!
    @IBOutlet weak var lbValueType: UILabel!
    @IBOutlet weak var lbSybol: UILabel!
    
    var fee: Fee?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(with fee: Fee) {
        lbFeeName.text = fee.nameFee
        lbValuePerFee.text = String(fee.valuePerType)
        lbValueType.text = fee.valueType
        lbSybol.text = fee.simbleType
    }
}
