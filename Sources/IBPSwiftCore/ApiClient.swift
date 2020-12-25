//
//  ApiClient.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation
import Alamofire


open class ApiClient {
    public static var apiConfig = ApiClientConfig.sharedInstance()
    
    
    /// Manager with configuration for request headers and Oauth2Handler interceptor if it is available in ApiClientConfig
    public static let sessionManager: Session = {
        var defaultHeaders = HTTPHeaders.default
        if let contentType = apiConfig.getHeaderContentType {
            defaultHeaders.add(HTTPHeader.contentType(contentType))
        }
        if let accept = apiConfig.getHeaderAccept {
            defaultHeaders.add(HTTPHeader.accept(accept))
        }
    
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders.dictionary
        configuration.timeoutIntervalForRequest = apiConfig.timeoutInterval
       
        let session = Session(configuration: configuration,
                              interceptor: apiConfig.oAuth2handler)
        return session
    }()

    
    /// Create URL with server base url and path to specific location.
    /// - Warning  `path` parameter must be valid location, if `serverUrl`  is not set in  `ApiClientConfig` then `path` parameter must be full url.
    /// - Parameter path: `String` path to specific location.
    /// - Returns: `URL` with full path to specific location.
    
     public func buildUrl(_ path: String) -> URL {
        if let serverUrl = ApiClient.apiConfig.serverUrl {
            var url = URL(string: serverUrl)!
            url.appendPathComponent(path)
            return url
            
        } else {
            var url = URL(string: path)!
            url.appendPathComponent(path)
            return url
        }
    }
    
    /// Make request to specific url location that will send data and receve response with data
    /// - Parameters:
    ///   - httpMethod: `HTTPMethod` for the `URLRequest`. `.get` by default.
    ///   - body: `Encodable` value to be encoded into the `URLRequest`. `nil` by default.
    ///   - path: `String` path to url location
    ///   - encoder: `ParameterEncoder` to be used to encode the `body` value into the `URLRequest`.
    ///   - headers: `HTTPHeaders` value to be added to the `URLRequest`. `nil` by default.
    ///   - decoder: `DataDecoder` to be used to decode the response data. `JSONDecoder()` by default.
    ///   - callback: `@escaping (ResponseModel?, ApiError?) -> Void` Calback that will return data or error from the response
    public func makeRequest<ResponseModel: Decodable>(
        using httpMethod: HTTPMethod,
        body: Encodable?,
        path: String,
        encoder: ParameterEncoder = JSONParameterEncoder.default,
        headers: HTTPHeaders = [:],
        decoder: DataDecoder = JSONDecoder(),
        requestModifier: Session.RequestModifier? = nil,
        callback: @escaping (ResponseModel?, ApiError?) -> Void) {

        let url = buildUrl(path)

        ApiClient.sessionManager.request(
            url,
            method: httpMethod,
            parameters: body == nil ? nil : AnyEncodable(value: body!),
            encoder: encoder,
            headers: headers,
            requestModifier: requestModifier)
            .validate(statusCode: ApiClient.apiConfig.validStatusCodes)
        .responseDecodable(
            decoder: decoder,
            completionHandler: { (response: DataResponse<ResponseModel, AFError>) in
                switch response.result {
                case .success(let responseBody):
                    callback(responseBody, nil)
                case .failure:
                    callback(nil, ApiError.fromDataResponse(response: response))
                }
        })
    }
}
