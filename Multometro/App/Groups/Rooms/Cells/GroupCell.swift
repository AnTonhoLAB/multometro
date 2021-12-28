//
//  GroupCell.swift
//  Multometro
//
//  Created by George Gomes on 20/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet {
            backGroundView.roundedCornerColor(radius: 15)
        }
    }
    @IBOutlet weak var lbNameRoom: UILabel!
    @IBOutlet weak var lbNumberOfUsers: UILabel!
    
    @IBOutlet weak var lbIsAdmin: UILabel!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setUpRoom(group: Room) {
        
        lbNameRoom.text = group.name.decode()
        if let users = group.userInRooms {
            let validUsers = users.filter{ $0.userType != UserType.ADMIN }
            lbNumberOfUsers.text = String(validUsers.count)
        } else {
            lbNumberOfUsers.text = "0"
        }
        
//        let maUser =
            lbIsAdmin.text = group.myUser.userType.rawValue// group.admin?.mulltometroUserId == AuthManager.getCurrentUserId() ? "Admin" : "Member"
        
    }

}
