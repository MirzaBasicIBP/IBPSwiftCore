//
//  ApiClientConfiguration.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation

class ApiClientConfig {
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
    
    
    /// Set OAuth2Protocol and refresh token status code that will triger OAuth2Protocol delegate to refresh token
    /// - Parameters:
    ///   - delegate: Delegate for `OAuth2Protocol`
    ///   - refreshStatusCode: Default is `401`
    func setOAuth2HandlerDelegate(_ delegate: OAuth2Protocol?, _ refreshStatusCode: Int = ApiClientConfig.sharedInstance().REFRESH_TOKEN_STATUS_CODE) {
        if let oAuth2Handler = oAuth2Handler {
            oAuth2Handler.delegate = delegate
        } else {
            oAuth2Handler = OAuth2Handler(delegate: delegate)
        }
    }
    
    func setServerUrl(_ url: String?) {
        self.SERVER_URL = url
    }
    
    func setClientId(_ clientId: String?)  {
        self.API_CLIENT = clientId
    }
    
    func setApiSecret(_ secret: String?)  {
        self.API_SECRET = secret
    }
    
    func setValidStatusCodeRange(_ range: Range<Int>)  {
        self.VALID_STATUS_CODES = range
    }
    
    func setTimeoutInterval(_ interval: TimeInterval) {
        self.TIMEOUT_INTERVAL = interval
    }
    
    func setRefreshTokenStatusCode(_ code: Int) {
        self.REFRESH_TOKEN_STATUS_CODE = code
    }
    
    
    /// Set  values for `Content-Type` and `Accept`  paremeters in header
    /// - Parameters:
    ///   - accept: Default is `application/json`
    ///   - contentType: Default is `application/json`
    func setHeader(accept: String?, contentType: String?) {
        self.HEADER_ACCEPT = accept
        self.HEADER_CONTENT_TYPE = contentType
    }
    
    var oAuth2handler: OAuth2Handler? {
        return oAuth2Handler
    }

    var serverUrl: String? {
        return SERVER_URL
    }

    var apiClient: String? {
        return API_CLIENT
    }

    var apiSecret: String? {
        return API_SECRET
    }
    
    var validStatusCodes: Range<Int> {
        return VALID_STATUS_CODES
    }
    
    var timeoutInterval: TimeInterval {
        return TIMEOUT_INTERVAL
    }
    
    var refreshTokenStatusCode: Int {
        return REFRESH_TOKEN_STATUS_CODE
    }
    
    var getHeaderAccept: String? {
        return HEADER_ACCEPT
    }
    
    var getHeaderContentType: String? {
        return HEADER_CONTENT_TYPE
    }
}
