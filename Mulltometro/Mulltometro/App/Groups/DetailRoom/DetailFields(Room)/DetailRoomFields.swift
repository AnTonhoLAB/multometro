//
//  DetailRoomFieldsViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 06/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class DetailRoomFields: UIView {
    
//    @IBOutlet var contentView: DetailRoomFields!
    @IBOutlet weak var lbAdmin: UILabel!
    @IBOutlet weak var lbDueDate: UILabel!
    
    var roomFields: Room?
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        commonInit() 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "DetailRoomFields", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
    }
    
    func setupFields() {
        if let room = roomFields, let admin = room.admin {
            if admin.uid == AuthManager.getCurrentUserId() {
                lbAdmin.text = "You"
            } else {
                lbAdmin.text = admin.name
            }
            lbDueDate.text = String(room.dueDate)
        }
    }
}
