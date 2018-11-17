//
//  ParticipantsGroupCell.swift
//  Mulltometro
//
//  Created by George Gomes on 16/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class ParticipantsGroupCell: UITableViewCell {
    
    static let identifier: String = "ParticipantsGroupCell"
    
    var users: [String]?

    @IBOutlet weak var labelUsers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        if let users = users {
//            self.labelUsers.text = users.description
        }
    }
    
}
