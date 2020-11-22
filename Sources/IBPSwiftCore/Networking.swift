//
//  Networking.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 22/11/2020.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionsHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionsHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) {data, _, error in
            completionsHandler(data, error)
        }
        
        task.resume()
    }
}

extension IBPSwiftCore {
    public class Networking {
        /// Responsible for handling all networking data
        /// - Warning: Must create before using any public API
        public class Manager {
            public init () {}
            
            internal var session: NetworkSession = URLSession.shared
            
            /// Calls to the internet that retrieve Data from specific location
            /// - Parameters:
            ///   - url: The location to fetch data from
            ///   - completionHandler: Returns a result object with status of request
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) {data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
