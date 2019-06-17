//
//  PlayParameters.swift
//  Cider
//
//  Created by Scott Hoyt on 8/1/17.
//  Copyright © 2017 Scott Hoyt. All rights reserved.
//

import Foundation

/// An object that represents play parameters for resources.
public typealias PlayParameters = JSONValue

public enum JSONValue : Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case object([String: JSONValue])
    case array([JSONValue])
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let stringValue = (try? container.decode(String.self)).map(JSONValue.string) {
            self = stringValue
        } else if let intValue = (try? container.decode(Int.self)).map(JSONValue.int) {
            self = intValue
        } else if let doubleValue = (try? container.decode(Double.self)).map(JSONValue.double) {
            self = doubleValue
        } else if let boolValue = (try? container.decode(Bool.self)).map(JSONValue.bool) {
            self = boolValue
        } else if let objectValue = (try? container.decode([String: JSONValue].self)).map(JSONValue.object) {
            self = objectValue
        } else if let arrayValue = (try? container.decode([JSONValue].self)).map(JSONValue.array) {
            self = arrayValue
        } else {
            throw DecodingError.typeMismatch(JSONValue.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Not a JSON"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        // Unimplemented for now...
    }
    
    public func toSwiftObject() -> [String: Any] {
        if case .object = self {
            return self.toRawValue() as! [String: Any]
        } else {
            return [:]
        }
    }
    
    public func toRawValue() -> Any {
        switch self {
        case .string(let value): return value
        case .int(let value): return value
        case .double(let value): return value
        case .bool(let value): return value
        
        case .object(let value):
            return value.mapValues { return $0.toRawValue() }
        
        case .array(let value):
            return value.map { return $0.toRawValue() }
        }
    }
}
