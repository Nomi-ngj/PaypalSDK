//
//  Dictionary + Extension.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import Foundation

extension NSDictionary{
    //decoding objects
    func decode<T:Decodable>(as ObjectType:T.Type) throws -> T{
        let documentJson = NSDictionary()
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let documentObject = try JSONDecoder().decode(ObjectType, from: documentData)
        
        return documentObject
    }
}
