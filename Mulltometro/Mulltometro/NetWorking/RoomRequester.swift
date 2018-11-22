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
//        let user = ["adminId": AuthManager.getCurrentUserId()]
                let user = [
                            "email":AuthManager.getCurrentEmail(),
                            "name":AuthManager.getCurrentEmail(),
                            "firstTime": false,
                            "uid": AuthManager.getCurrentUserId()
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
    }
    
    static func enterRoom(roomId: String, completion: @escaping (Response<Room>) -> Void) {
        let enterInRoom = ["uid": AuthManager.getCurrentUserId(), "roomId": roomId]
        
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
    }
   
//    func jsonToObject<T>(from: HTTPSCallableResult, object: T ) where T: Decodable {
//        guard let data = from.data as? [[String: Any]] else { return }
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
//            let returnable = try JSONDecoder().decode(object.self, from: jsonData)
//            return returnable
//        } catch {
//
//        }
//    }
    
//    static func getAllRooms(completion: @escaping(Response<[Room]>) -> Void) {
//        let user = [
//                    "email":AuthManager.getCurrentEmail(),
//                    "name":AuthManager.getCurrentEmail(),
//                    "firstTime": false,
//                    "uid": AuthManager.getCurrentUserId()
//                    ] as [String : Any]
//
//
//        let ref  = Firestore.firestore().collection("room")
//
//        let query = ref.whereField("users", arrayContains: user)
//
//        query.getDocuments { (res, err) in
//
//
//            if let res = res {
//    //            let i = res.documents.map{ return $0.data()}
//                let roomsData = res.documents.map{ return $0.data() } //as? [[String: Any]] else { return }
//
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: roomsData, options: [])
//                    let rooms = try JSONDecoder().decode([Room].self, from: jsonData)
//
//                    completion(.success(rooms))
//                } catch let error {
//                    completion(.failure(error))
//                }
//    //        }
//
//            }
//
//        }
//
//        let ref = Database.database().reference(withPath: "user")
//
//        var usersQuery = ref.queryOrderedByKey()
//        usersQuery.whe
//    }
    
}
