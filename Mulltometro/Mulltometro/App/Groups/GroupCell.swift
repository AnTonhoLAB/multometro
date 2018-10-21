//
//  GroupCell.swift
//  Mulltometro
//
//  Created by George Gomes on 20/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet {
            backGroundView.roundedCornerColor(radius: 5)
        }
    }
    @IBOutlet weak var lbNameRoom: UILabel!
    @IBOutlet weak var lbUsersCount: UILabel!
    @IBOutlet weak var lbNumberOfUsers: UILabel!
    
    @IBOutlet weak var lbIsAdmin: UILabel!
    
    var group: Room?
    
    func setUpRoom() {
        guard let group = group else { return }
        
        lbNameRoom.text = group.nameRoom
        if let users = group.users {
            lbNumberOfUsers.text =  String(users.count)
        }
        if group.adminId == AuthManager.getCurrentUserId() {
            lbIsAdmin.text = "Admin"
        }
    }

}
