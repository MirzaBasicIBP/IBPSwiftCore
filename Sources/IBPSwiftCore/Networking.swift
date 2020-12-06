//
//  Networking.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 22/11/2020.
//

import Foundation
import Alamofire
import ObjectMapper

protocol NetworkSession {
    func get(from url: URL, completionsHandler: @escaping (Data?, Error?) -> Void)
    func post(with request: URLRequest, completionsHandler: @escaping (Data?, Error?) -> Void)
    func patch(with request: URLRequest, completionsHandler: @escaping (Data?, Error?) -> Void)
}

extension URLSession: NetworkSession {
   func get(from url: URL, completionsHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: url) {data, _, error in
            completionsHandler(data, error)
        }
        
        task.resume()
    }
    
    func post(with request: URLRequest, completionsHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, _, error) in
            completionsHandler(data, error)
        }
        
        task.resume()
    }
    
    func patch(with request: URLRequest, completionsHandler: @escaping (Data?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, _, error) in
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
            ///   - completionHandler: Returns a result object with status of response
            public func get(from url: URL, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                session.get(from: url) {data, error in
                    let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                    completionHandler(result)
                }
            }
            
            /// Calls to the internet that send Data to a specific location
            /// - Warning Make sure that url cant accept POST request
            /// - Parameters:
            ///   - url: The location to send data to
            ///   - body: The object to send to request
            ///   - completionHandler: Returns a result object with status of response
            public func post<T: Codable>(to url: URL, body: T, completionHandler: @escaping (NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "POST"
                    session.post(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                } catch let error {
                    return  completionHandler(.failure(error))
                }
            }
            
            /// Calls to the internet that update Data on a specific location
            /// - Parameters:
            ///   - url: To location to send data to
            ///   - body: The object to send to request
            ///   - completionHandler: Returns a result object with status of response
            public func patch<T: Codable> (to url: URL, body: T, completionHandler: @escaping(NetworkResult<Data>) -> Void) {
                var request = URLRequest(url: url)
                do {
                    let httpBody = try JSONEncoder().encode(body)
                    request.httpBody = httpBody
                    request.httpMethod = "PATCH"
                    session.patch(with: request) { data, error in
                        let result = data.map(NetworkResult<Data>.success) ?? .failure(error)
                        completionHandler(result)
                    }
                } catch let error {
                    return completionHandler(.failure(error))
                }
            }
        }
        
        public enum NetworkResult<Value> {
            case success(Value)
            case failure(Error?)
        }
    }
}
