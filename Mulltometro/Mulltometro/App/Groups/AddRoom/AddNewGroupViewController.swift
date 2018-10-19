//
//  AddNewGroupViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 18/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class AddNewGroupViewController: UIViewController {
    
    @IBOutlet weak var btCancel: UIBarButtonItem! { didSet { btCancel.title = R.string.localizable.cancel() } }
    @IBOutlet weak var btCreate: UIBarButtonItem! { didSet { btCreate.title = R.string.localizable.create() } }
    
    @IBOutlet weak var registerTableView: UITableView! {
        didSet {
            registerTableView.dataSource = self
            registerTableView.delegate = self
            registerTableView.estimatedRowHeight = 100
            registerTableView.rowHeight = UITableView.automaticDimension
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCreate(_ sender: Any) {
        
//        guard let roomName = tfRoomName.text else { return }
//        let dueDate = (dayPicker.selectedRow(inComponent: 0) + 1) % 30
//
//        let room = stParticipate.isOn ? Room(likeUserTo: roomName, dueDate: dueDate)
//                                      : Room(name: roomName, dueDate: dueDate)
//
//        RoomRequester.addRoom(with: room.toData())
    }
}

extension AddNewGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "roomRegisterCell", for: indexPath) as! RoomRegisterCell
        case 1:
            return tableView.dequeueReusableCell(withIdentifier: "addFeeHeaderCell", for: indexPath) as! AddFeeHeaderCell
        default:
            return RoomRegisterCell()
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 500
//        default:
//            return 20
//        }
//    }
    
    
}

extension AddNewGroupViewController: UITableViewDelegate {
    
}

