//
//  Networking.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 22/11/2020.
//

import Foundation
extension IBPSwiftCore {
    public class Networking {
        /// Responsible for handling all networking data
        /// - Warning: Must create before using any public API
        public class Manager {
            public init () {}
            
            private let session = URLSession.shared
            
            public func loadData(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                let task = session.dataTask(with: url) {data, response, error in
                    
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
                task.resume()
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
