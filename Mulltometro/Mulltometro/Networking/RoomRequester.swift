//
//  CloudCommunication.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Rswift

class RoomRequester {
    
    private init() {}
    
    static func addRoom(with room: [String: Any], completion: @escaping (Response<Room>) -> Void) {

//        function.httpsCallable("addRoom").call(room) { (res, err) in
//
//            if let err = err {
//                completion(.failure(err))
//            }
//            if let res = res {
//                guard let value = res.data as? [String: Any] else { return }
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let room = try JSONDecoder().decode(Room.self, from: jsonData)
//                    completion(.success(room))
//                } catch let error {
//                    completion(.failure(error))
//                }
//            }
//        }
    }
    
    static func getAllRooms(completion: @escaping(Response<[Room]>) -> Void) {
        let user: User = CDManager.Object()
        
        CDManager.getSinlgeObject(user) { response in
            switch response {
                
            case .success(let admin):
                print(admin)
                let param = ["id": admin.uid]
                
                HTTPRequester.request(route: .room, function: .getMyRooms, parameters: param, completion: { response  in
                    switch response {
                        
                    case .success(let data):
                        do {
                            let roomFromData = try JSONDecoder().decode([Room].self, from: data.getArrayOfObject(with: "rooms"))
                            completion(.success(roomFromData))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                    }
                })

                break
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
    static func enterRoom(roomId: String, completion: @escaping (Response<Room>) -> Void) {
        let user: User = CDManager.Object()
        
        CDManager.getSinlgeObject(user) { response in
            switch response {
            case .success(let admin):
                print(admin)
                
                
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
}

struct ResponseRooms: Codable {
    var rooms: [Room]!
}
