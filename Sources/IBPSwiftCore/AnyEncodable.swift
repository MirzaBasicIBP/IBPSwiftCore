//
//  AnyEncodable.swift
//  IBPSwiftCore
//
//  Created by Mirza Basic on 06/12/2020.
//

public struct AnyEncodable: Encodable {
    public let value: Encodable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }
}

extension Encodable {
    public func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}
