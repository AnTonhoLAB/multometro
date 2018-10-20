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
    
    @IBOutlet weak var expandedView: UIView!
    
    var fees = [String]()
    
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

extension AddNewGroupViewController: RegisterRequester {
    func addFee() {
        self.expandedView.frame.size.height = 1000
        self.registerTableView.reloadData()
        fees.append("newValue")
        
        registerTableView.scrollToRow(at: IndexPath(item: 1, section: 0), at: .top, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.registerTableView.beginUpdates()
            self.registerTableView.insertRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
            self.registerTableView.endUpdates()
        }
    }
    
    func cancelFee() {
        fees.removeLast()
        registerTableView.deleteRows(at: [IndexPath(item: 2, section: 0)], with: .automatic)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
            guard let self = self else { return }
            self.registerTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            self.expandedView.frame.size.height = 1
        }
    }
    
}

extension AddNewGroupViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fees.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: "roomRegisterCell", for: indexPath) as! RoomRegisterCell
        case 1:
            let addFeeHeaderCell = tableView.dequeueReusableCell(withIdentifier: "addFeeHeaderCell", for: indexPath) as! AddFeeHeaderCell
            addFeeHeaderCell.delegate = self
            return addFeeHeaderCell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "addFeeRegisterCell", for: indexPath) as! AddFeeRegisterCelll
        }
    }
    
}

extension AddNewGroupViewController: UITableViewDelegate {
    
}


