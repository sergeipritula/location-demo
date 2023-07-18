//
//  Encodable+toDictionary.swift
//  LocationDemo
//
//  Created by Sergey Pritula on 19.07.2023.
//

import Foundation

extension Encodable {
    var toDictionnary: [String : Any] {
        guard let data =  try? JSONEncoder().encode(self) else {
            return [:]
        }
        
        let dict = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dict ?? [:]
    }
}
