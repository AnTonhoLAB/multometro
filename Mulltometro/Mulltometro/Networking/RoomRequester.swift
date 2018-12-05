//
//  CloudCommunication.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Firebase
import Rswift

class RoomRequester {
    
    private static var function = Functions.functions()
    
    private init() {}
    
    static func addRoom(with room: [String: Any], completion: @escaping (Response<Room>) -> Void) {

        function.httpsCallable("addRoom").call(room) { (res, err) in
            
            if let err = err {
                completion(.failure(err))
            }
            if let res = res {
                guard let value = res.data as? [String: Any] else { return }
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let room = try JSONDecoder().decode(Room.self, from: jsonData)
                    completion(.success(room))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func getAllRooms(completion: @escaping(Response<[Room]>) -> Void) {
        let user: User = CDManager.Object()
        
        CDManager.getSinlgeObject(user) { response in
            switch response {
                
            case .success(let admin):
                let user = [
                    "email":AuthManager.getCurrentEmail(),
                    "name": admin.name ?? AuthManager.getCurrentEmail(),
                    "firstTime": false,
                    "uid": AuthManager.getCurrentUserId(),
                    "photoURL": admin.pthotoURL ?? ""
                    ] as [String : Any]
                
                function.httpsCallable("getAllRooms").call(user) { (res, err) in
                    
                    if let res = res {
                        guard let roomsData = res.data as? [[String: Any]] else { return }
                        
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: roomsData, options: [])
                            let rooms = try JSONDecoder().decode([Room].self, from: jsonData)
                            completion(.success(rooms))
                        } catch let error {
                            completion(.failure(error))
                        }
                    }
                    
                    if let err = err {
                        completion(.failure(err))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func enterRoom(roomId: String, completion: @escaping (Response<Room>) -> Void) {
        let user: User = CDManager.Object()
        
        CDManager.getSinlgeObject(user) { response in
            switch response {
            case .success(let admin):
                let user = [
                    "email":AuthManager.getCurrentEmail(),
                    "name": admin.name ?? AuthManager.getCurrentEmail(),
                    "firstTime": false,
                    "uid": AuthManager.getCurrentUserId(),
                    "photoURL": admin.pthotoURL ?? ""
                    ] as [String : Any]
                
                let enterInRoom = ["user": user, "roomId": roomId] as [String : Any]
                
                
                function.httpsCallable("enterRoom").call(enterInRoom) { (res, err) in
                    if let res = res, let roomData = res.data as? [String: Any] {
                        do{
                            let jsonData = try JSONSerialization.data(withJSONObject: roomData, options: [])
                            let room = try JSONDecoder().decode(Room.self, from: jsonData)
                            completion(.success(room))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                    
                    if let err = err {
                        completion(.failure(err))
                    }
                }
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}
