//
//  Requester.swift
//  Mulltometro
//
//  Created by George Gomes on 01/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

enum Route: String {
    case room
    case auth
    case user
}

enum Function: String {
    case login
    case register
    case create
    case getMyRooms
}

final class HTTPRequester {
    
    static let host = "https://mulltometro.herokuapp.com/"
    static let method = "POST"
    
    static func request(route: Route, function: Function, parameters: [String: Any], completion: @escaping (Response<Data>) -> Void) {
        
        if !NetworkingManager.isConnected { completion(.failure(RequestError.noConnection)) }
        //create the url with URL
        let url = URL(string: generateUrl(with: route, function: function))!
        
        //create the session object
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            // pass dictionary to nsdata object and set it as request body
        } catch let error {
            completion(Response.failure(error))
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(authorization(), forHTTPHeaderField: "Authorization")
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let error = error {
                completion(Response.failure(error))
            }
            
            if let response = response, let statusCode = response.getStatusCode(), let data = data {
                if statusCode == 200 {
                    completion(Response.success(data))
                } else {
                    completion(Response.failure(RequestError(code: data.getCode())))
                }
            }
        })
        task.resume()
    }
    
    private static func generateUrl(with route: Route, function: Function) -> String {
        return String(stringInterpolation: HTTPRequester.host, route.rawValue, "/", function.rawValue)
    }
    
    private static func authorization() -> String {
        let tokenItem = KeychainHelper(service: KeychainConfiguration.serviceName, account: KeychainConfiguration.account, accessGroup: KeychainConfiguration.accessGroup)
        do {
            let token = try tokenItem.readPassword()
            return String("Bearer " + token)
        } catch {
            return ""
        }
    }
}

extension URLResponse {
    
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

extension Data {
    // Only works with errors returns
    func getCode() -> Int {
        do {
            let responseObject = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            guard let responseBind = responseObject, let code = responseBind["code"], let codeBind = code as? Int else { return 0 }
            return codeBind
        } catch {
            return 0
        }
    }
    
    func getArrayOfObject(with name: String) throws -> Data {
        do {
            let responseObject = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
            guard let responseBind = responseObject,
                let objectAny = responseBind[name] as? [[String: Any]] else { throw RequestError(code: 0) }
            
            let jsonData = try JSONSerialization.data(withJSONObject:objectAny)
            return jsonData
        } catch {
            throw RequestError(code: 0)
        }
    }
}
