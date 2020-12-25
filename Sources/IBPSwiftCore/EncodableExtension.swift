//
//  EncodableExtension.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

import Foundation

extension Encodable {
    public func encoded() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
