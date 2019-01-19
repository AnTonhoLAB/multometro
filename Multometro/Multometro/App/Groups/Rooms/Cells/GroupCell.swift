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
//    @IBOutlet weak var lbUsersCount: UILabel!
    @IBOutlet weak var lbNumberOfUsers: UILabel!
    
    @IBOutlet weak var lbIsAdmin: UILabel!
    
    var group: Room?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func setUpRoom() {
        guard let group = group else { return }
        
        lbNameRoom.text = group.name.decode()
        if let users = group.userInRooms {
            lbNumberOfUsers.text = String(users.count)
        } else {
            lbNumberOfUsers.text = "0"
        }
        
        lbIsAdmin.text = group.admin?.mulltometroUserId == AuthManager.getCurrentUserId() ? "Admin" : "Member"
        
    }

}
