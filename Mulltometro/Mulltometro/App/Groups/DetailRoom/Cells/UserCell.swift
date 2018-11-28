//
//  UserCell.swift
//  Mulltometro
//
//  Created by George Gomes on 17/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {
    
    static let identifier: String = "UserCell"

    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    var name: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapApplyFee(_ sender: Any) {
        print("DID TA APPLY")
    }
    
    func setup(with name: String, photoURL: String?) {
        lbUserName.text = name
        print(photoURL)
        let url = URL(string: "https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/4/4/4/2/44426ec60227fed134090948322b475d.jpg")
        imageUser.kf.setImage(with: url)
    }
}
