//
//  JSONResponseDecoder.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 07/06/19.
//  Copyright © 2019 NetworkLayerDemo. All rights reserved.
//

import Foundation

class JSONResponseDecoder {

    typealias JSONDecodeCompletion<T> = (T?, Error?) -> Void

    static func decodeFrom<T: Decodable>(_ responseData: Data, returningModelType: T.Type, completion: JSONDecodeCompletion<T>) {
        do {
            let model = try JSONDecoder().decode(returningModelType, from: responseData)
            completion(model, nil)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: ", context)
            completion(nil, DecodingError.dataCorrupted(context))
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.keyNotFound(key, context))
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.valueNotFound(value, context))
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: ", context.debugDescription, "\n codingPath:", context.codingPath)
            completion(nil, DecodingError.typeMismatch(type, context))
        } catch {
            print("error: ", error.localizedDescription)
            completion(nil, error)
        }
    }

}
