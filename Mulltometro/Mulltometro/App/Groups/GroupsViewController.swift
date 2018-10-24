//
//  GroupsViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 01/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    @IBOutlet weak var btAddRoom: UIBarButtonItem! {
        didSet {
            btAddRoom.tintColor = .redSystem
        }
    }
    @IBOutlet weak var tableViewRooms: UITableView! {
        didSet {
            tableViewRooms.dataSource = self
            tableViewRooms.delegate = self
            tableViewRooms.estimatedRowHeight = 180
            tableViewRooms.rowHeight = UITableView.automaticDimension
            tableViewRooms.allowsSelection = true
        }
    }
    
    var newAddFlag = false
    var rooms: [Room] = [Room]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let navController = navigationController {
            navController.navigationBar.tintColor = .redSystem
        }
        
        RoomRequester.getAllRooms {[weak self] res in
            guard let self = self else { return }
            
            switch res {
            case .success(let rooms):
                self.rooms = rooms
                self.tableViewRooms.reloadSections(IndexSet(integer: 0), with: .bottom)
            case .failure(_):
                print("TODO")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if newAddFlag {
            newAddFlag.toggle()
            self.tableViewRooms.beginUpdates()
            self.tableViewRooms.insertRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
            self.tableViewRooms.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationNavigationController = segue.destination as? UINavigationController {
            if let destinationController = destinationNavigationController.viewControllers.first as? AddNewGroupViewController {
                destinationController.delegate = self
            }
        }
        
        if let destinationController = segue.destination as? DetailViewController {
            destinationController.room = sender as? Room
        }

    }
    
    @IBAction func didTapAddRoom(_ sender: Any) {
        performSegue(withIdentifier: R.segue.groupsViewController.toAddGroup, sender: nil)
    }
}

extension GroupsViewController: RegisterForNewGroup {
    func added(new group: Room) {
        newAddFlag.toggle()
        rooms.append(group)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }

            self.tableViewRooms.beginUpdates()
            self.tableViewRooms.insertRows(at: [IndexPath(item: 0, section: 0)], with: .automatic)
            self.tableViewRooms.endUpdates()
        }
    }
}

extension GroupsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupCell
        cell.group = rooms[(rooms.count - 1) - indexPath.row]
        cell.setUpRoom()
        return cell
    }
}

extension GroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: R.segue.groupsViewController.toRoomDetail, sender: rooms[indexPath.row])
    }
    
}

protocol RegisterForNewGroup {
    func added(new group: Room )
}
