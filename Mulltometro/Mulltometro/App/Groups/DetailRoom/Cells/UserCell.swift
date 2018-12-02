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
    
    func setup(with user: MulltometroUser) {
        var urlString: String
        if let userImageURL = user.photoURL {
            urlString = userImageURL
            let url = URL(string: urlString)
            imageUser.kf.setImage(with: url)
        } else {
            urlString = "https://studiosol-a.akamaihd.net/uploadfile/letras/fotos/4/4/4/2/44426ec60227fed134090948322b475d.jpg"
            imageUser.image = R.image.addImage()
        }
        
        lbUserName.text = user.name
    }
}
