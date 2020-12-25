//
//  ApiClientConfiguration.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation

open class ApiClientConfig {
    private var SERVER_URL: String?
    private var API_CLIENT: String?
    private var API_SECRET: String?
    private var VALID_STATUS_CODES: Range = 200..<300
    private var TIMEOUT_INTERVAL: TimeInterval = 15
    
    private var HEADER_ACCEPT: String? = "application/json"
    private var HEADER_CONTENT_TYPE: String? = "application/json"

    private var REFRESH_TOKEN_STATUS_CODE: Int = 401

    private var oAuth2Handler: OAuth2Handler?
    
    
    private static var instance: ApiClientConfig?

    public static func sharedInstance() -> ApiClientConfig {
        if ApiClientConfig.instance == nil {
            ApiClientConfig.instance = ApiClientConfig()
        }
        return ApiClientConfig.instance!
    }

    private init() {
    }
    
    
    /// Set OAuth2Protocol  delegate to oweride OAuth2Protocol methods for Api request costumizations
    /// - Parameters:
    ///   - delegate: Delegate for `OAuth2Protocol`
    public func setOAuth2HandlerDelegate(_ delegate: OAuth2Protocol?) {
        if let oAuth2Handler = oAuth2Handler {
            oAuth2Handler.delegate = delegate
        } else {
            oAuth2Handler = OAuth2Handler(delegate: delegate)
        }
    }
    
    public func setServerUrl(_ url: String?) {
        self.SERVER_URL = url
    }
    
    public func setClientId(_ clientId: String?)  {
        self.API_CLIENT = clientId
    }
    
    public func setApiSecret(_ secret: String?)  {
        self.API_SECRET = secret
    }
    
    public func setValidStatusCodeRange(_ range: Range<Int>)  {
        self.VALID_STATUS_CODES = range
    }
    
    public func setTimeoutInterval(_ interval: TimeInterval) {
        self.TIMEOUT_INTERVAL = interval
    }
    
    public func setRefreshTokenStatusCode(_ code: Int) {
        self.REFRESH_TOKEN_STATUS_CODE = code
    }
    
    
    /// Set  values for `Content-Type` and `Accept`  paremeters in header
    /// - Parameters:
    ///   - accept: Default is `application/json`
    ///   - contentType: Default is `application/json`
    public func setHeader(accept: String?, contentType: String?) {
        self.HEADER_ACCEPT = accept
        self.HEADER_CONTENT_TYPE = contentType
    }
    
    public var oAuth2handler: OAuth2Handler? {
        return oAuth2Handler
    }

    public var serverUrl: String? {
        return SERVER_URL
    }

    public var apiClient: String? {
        return API_CLIENT
    }

    public var apiSecret: String? {
        return API_SECRET
    }
    
    public var validStatusCodes: Range<Int> {
        return VALID_STATUS_CODES
    }
    
    public var timeoutInterval: TimeInterval {
        return TIMEOUT_INTERVAL
    }
    
    public var refreshTokenStatusCode: Int {
        return REFRESH_TOKEN_STATUS_CODE
    }
    
    public var getHeaderAccept: String? {
        return HEADER_ACCEPT
    }
    
    public var getHeaderContentType: String? {
        return HEADER_CONTENT_TYPE
    }
}
