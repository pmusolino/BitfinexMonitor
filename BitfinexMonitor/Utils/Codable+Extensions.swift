//
//  Codable+Extensions.swift
//  BitfinexMonitor
//
//  Created by Paolo Musolino on 12/05/2019.
//  Copyright © 2019 Bitfinex. All rights reserved.
//

import Foundation

extension Encodable {
    func toJSON() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func toJSONData() -> Data?{
        return try? JSONEncoder().encode(self)
    }
    
    func toJSONString() -> String?{
        if let data = self.toJSONData(){
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

extension Decodable {
    init(from: Any) throws {
        guard JSONSerialization.isValidJSONObject(from) else {
            throw CodableErrors.JsonNotValid
        }
        let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: data)
    }
    
    init(from: String) throws {
        let dataFromString = from.data(using: .utf8)
        guard dataFromString != nil else{
            throw CodableErrors.NilData
        }
        let decoder = JSONDecoder()
        self = try decoder.decode(Self.self, from: dataFromString!)
    }
}

enum CodableErrors: Error{
    case JsonNotValid
    case NilData
    case InitError
}

