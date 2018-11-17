//
//  DetailRoomViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 23/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailRoomFields: DetailRoomFields!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            let nib = UINib(nibName: ParticipantsGroupCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: ParticipantsGroupCell.identifier)
            tableView.estimatedRowHeight = 180
            tableView.rowHeight = UITableView.automaticDimension
            tableView.allowsSelection = true
        }
    }
    
    var room: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateQR))
        
        if let room = room {
            navigationItem.title = room.nameRoom
            detailRoomFields.roomFields = room
            detailRoomFields.setupFields()
        }
    }
    
    @objc func didTapCreateQR() {
        guard let room = room, let id = room.id else { return }
        performSegue(withIdentifier: R.segue.detailViewController.toQRView, sender: id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? QRViewController{
                destinationNavigationController.QRString = sender as? String
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell  = (tableView.dequeueReusableCell( withIdentifier:ParticipantsGroupCell.identifier ) as! ParticipantsGroupCell)
//        if let room = room, let users = room.users {
//            cell.users = users
//        }
//        cell.setup()

        let cell = Bundle.main.loadNibNamed(ParticipantsGroupCell.identifier, owner: self, options: nil)?.first as! ParticipantsGroupCell
            if let room = room, let users = room.users {
                cell.users = users
            }
            cell.setup()

        return cell
    }
    
}

extension UINavigationItem {
    func backBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
