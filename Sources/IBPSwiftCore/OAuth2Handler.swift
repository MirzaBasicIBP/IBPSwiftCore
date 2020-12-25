//
//  OAuth2Handler.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation
import Alamofire

public protocol OAuth2Protocol {
    
    func onRequestRetry(_ request: Request,
                        for session: Session,
                        dueTo error: Error,
                        completion: @escaping (RetryResult) -> Void)
    
    func onAdaptRequest(_ urlRequest: URLRequest,
                        for session: Session,
                        completion: @escaping (Result<URLRequest, Error>) -> Void)
    
    func onRefreshTokenFail(dueTo error: Error,
                            requestsToRetry: [((RetryResult) -> Void)])
    
    func onRefreshTokenSuccess(requestsToRetry: [((RetryResult) -> Void)])
    
    func onRefreshToken(completion: @escaping (_ success: Bool) -> Void);
    
}


extension OAuth2Protocol {
    
    func onRequestRetry(_ request: Request,
                                          for session: Session,
                                          dueTo error: Error,
                                          completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetryWithError(error))
    }
    
    func onAdaptRequest(_ urlRequest: URLRequest,
                              for session: Session,
                              completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        completion(.success(urlRequest))
    }
    
    func onRefreshToken(completion: @escaping (_ success: Bool) -> Void) {
        completion(false)
    }
    
    func onRefreshTokenFail(dueTo error: Error, requestsToRetry: [((RetryResult) -> Void)]) {
        requestsToRetry.forEach { $0(.doNotRetryWithError(error)) }
    }
    
    func onRefreshTokenSuccess(requestsToRetry: [((RetryResult) -> Void)]) {
        requestsToRetry.forEach { $0(.retry) }
    }
}

open class OAuth2Handler: RequestInterceptor {
    private var sessionManager: Session {
        return ApiClient.sessionManager
    }
    
    public var delegate: OAuth2Protocol?
    
    private let lock = NSLock()
    public let serverUrl = ApiClient.apiConfig.serverUrl

    private var isRefreshing = false
    private var requestsToRetry: [((RetryResult) -> Void)] = []
    init() {
        
    }
    
    public init(delegate: OAuth2Protocol?) {
        self.delegate = delegate
    }

    public func adapt(_ urlRequest: URLRequest,
               for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        self.delegate?.onAdaptRequest(urlRequest, for: session, completion: completion)
    }

    public func retry(_ request: Request,
               for session: Session,
               dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
    
        lock.lock() ; defer { lock.unlock() }
        if let response = request.task?.response as? HTTPURLResponse,
           response.statusCode == ApiClient.apiConfig.refreshTokenStatusCode {
            requestsToRetry.append(completion)

            if !isRefreshing {
                isRefreshing = true
                self.delegate?.onRefreshToken{ [weak self] (success: Bool) in
                    guard let self = self else { return }
                    self.lock.lock() ; defer { self.lock.unlock()}
                    
                    self.isRefreshing = false
                
                    if success {
                        self.delegate?.onRefreshTokenSuccess(requestsToRetry: self.requestsToRetry)
                    } else {
                        self.delegate?.onRefreshTokenFail(dueTo: error, requestsToRetry: self.requestsToRetry)
                    }
                    self.requestsToRetry.removeAll()
                   
                }
            }
        } else {
            self.delegate?.onRequestRetry(request, for: session, dueTo: error, completion: completion)
        }
    }
}
