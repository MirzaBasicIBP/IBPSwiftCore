//
//  AppError.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation
import Alamofire

open class AppError: Error {
    public let title: String
    public let message: String

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

open class ApiError: AppError {

    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// Returns the associated error
    public var error: Error?

    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?) {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        super.init(title: "Network error", message: "A network error has occured")
    }

    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?,
        errorMessage: String) {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        super.init(title: "", message: errorMessage)
    }

    public static func fromDataResponse<T>(response: DataResponse<T, AFError>) -> ApiError? {
        switch response.result {
        case .failure(let error):
            return ApiError(request: response.request,
                            response: response.response,
                            data: response.data,
                            error: error)
        default:
            return nil
        }
    }
}
