//
//  Requester.swift
//  Mulltometro
//
//  Created by George Gomes on 01/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

enum Route: String {
    case room = "room"
    case auth = "auth"
    case user = "user"
}

enum Function: String {
    case login = "login"
    case registr = "register"
    case create = "create"
}

final class HTTPRequester {
    
    static let host = "https://mulltometro.herokuapp.com/"
    
    static func request(route: Route, function: Function, parameters: [String: Any], completion: @escaping (Response<Data>) -> Void) {
        
        //create the url with URL
        let url = URL(string: generateUrl(with: route, function: function))!
        
        //create the session object
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            // pass dictionary to nsdata object and set it as request body
        } catch let error {
            completion(Response.failure(error))
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(authorization(), forHTTPHeaderField: "Authorization")
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            if let error = error {
                completion(Response.failure(error))
            }
            
            if let data = data {
                completion(Response.success(data))
            }
        })
        task.resume()
    }
    
    private static func generateUrl(with route: Route, function: Function) -> String {
        return String(stringInterpolation: HTTPRequester.host, route.rawValue, "/", function.rawValue)
    }
    
    private static func authorization() -> String {
        return String("Bearer eyJhbGciOiJIUzI1NiJ9.Z2VvcmdlZ29tZWVzQGdtYWlsLmNvbQ.vNQvD5qwmN0dEOX5U3Svo12e2YAbLkK3wJDLZI1Yr8s")
    }
}
