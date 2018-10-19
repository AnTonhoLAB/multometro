//
//  AddFeeHeaderCell.swift
//  Mulltometro
//
//  Created by George Gomes on 19/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class AddFeeHeaderCell: UITableViewCell {
    
    var delegate: RegisterRequester!

    @IBOutlet weak var lbFeeType: UILabel!
    
    @IBAction func didTapAdd(_ sender: Any) {
        delegate.addFee()
    }
}

protocol RegisterRequester {
    func addFee()
}
