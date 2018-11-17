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
    @IBOutlet weak var tvUsers: UITableView! {
        didSet {
            tvUsers.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup() {
        if let users = users {
            print(users)
        }
    }
}

extension ParticipantsGroupCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "TODO")!
    }
    
    
}
