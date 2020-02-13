//
//  UserCell.swift
//  Multometro
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
    
    var user: UserInRoom?
    weak var delegate: ApplyFeeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapApplyFee(_ sender: Any) {
        guard let delegate = delegate, let user = user else { return }
//        delegate.applyFee(in: user)
    }
    
    func setup(with user: UserInRoom, admin: MultometroUser?, on delegate: ApplyFeeDelegate) {
        self.user = user
        self.delegate = delegate
        var urlString: String
        if let userImageURL = user.mulltometroUser.photoURL {
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
            if admin.id != AuthManager.getCurrentUserId() {
                self.btAddFee.isHidden = true
            }
        }
        
        lbUserName.text = user.mulltometroUser.userName.decode()
    }
}

protocol ApplyFeeDelegate: class {
    func applyFee(in user: MultometroUser)
}
