//
//  UserCell.swift
//  Mulltometro
//
//  Created by George Gomes on 17/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Kingfisher
import Rswift

class UserCell: UITableViewCell {
    
    static let identifier: String = "UserCell"

    @IBOutlet weak var lbUserName: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var btAddFee: UIButton!
    
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
    
    func setup(with user: MulltometroUser, admin: MulltometroUser?) {
        var urlString: String
        if let userImageURL = user.photoURL {
            if userImageURL == "" {
                imageUser.image = R.image.profile()
            } else {
                urlString = userImageURL
                let url = URL(string: urlString)
                imageUser.kf.setImage(with: url)
            }
        } else {
            imageUser.image = R.image.profile()
        }
        
        if let admin = admin {
            if admin.uid != AuthManager.getCurrentUserId() {
                self.btAddFee.isHidden = true
            }
        }
        
        lbUserName.text = user.name
    }
}
