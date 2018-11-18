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
    @IBOutlet weak var detailTransparent: UIView! {
        didSet {
           detailTransparent.frame.size = detailRoomFields.frame.size
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: HeaderCell.identifier, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: HeaderCell.identifier)
            tableView.estimatedRowHeight = 180
            tableView.rowHeight = UITableView.automaticDimension
       }
    }
    
    var room: Room?
    var tableViewData: [TableViewData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreateQR))
        
        if let room = room {
            navigationItem.title = room.nameRoom
            tableViewData = [TableViewData(opened: false, title: "Participants", sectionData: room.users),
                             TableViewData(opened: false,title: "Fees", sectionData: room.fees)]
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableViewData = tableViewData else { return 0 }
        
        if tableViewData[section].opened == true {
            guard let sectionData = tableViewData[section].sectionData else { return 0}
            return sectionData.count + 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewData = tableViewData else { return UITableViewCell() }
    
        if indexPath.row == 0 { // "HEADER"
            let cell = Bundle.main.loadNibNamed(HeaderCell.identifier, owner: self, options: nil)?.first as! HeaderCell
            cell.title = tableViewData[indexPath.section].title
            cell.setup()
            return cell
        } else {
        
            if let fees = tableViewData[indexPath.section].sectionData as? [Fee] {
                let cell = Bundle.main.loadNibNamed(FeeCell.identifier, owner: self, options: nil)?.first as! FeeCell
                cell.setup(with: fees[indexPath.row - 1])
                return cell
            }
        
            if let users = tableViewData[indexPath.section].sectionData as? [String] {
                let cell = Bundle.main.loadNibNamed(UserCell.identifier, owner: self, options: nil)?.first as! UserCell
                cell.setup(with: users[indexPath.row - 1])
                return cell
            }
        
            let cell = Bundle.main.loadNibNamed(HeaderCell.identifier, owner: self, options: nil)?.first as! HeaderCell
            cell.setup()
            return cell
        }
    }
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard var tableViewData = tableViewData else { return }
    
        if tableViewData[indexPath.section].opened {
            tableViewData[indexPath.section].opened = false
            self.tableViewData = tableViewData
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            tableViewData[indexPath.section].opened = true
            self.tableViewData = tableViewData
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
    }
}

extension UINavigationItem {
    func backBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

struct TableViewData {
    var opened: Bool!
    var title: String!
    var sectionData: [Any]?
}
