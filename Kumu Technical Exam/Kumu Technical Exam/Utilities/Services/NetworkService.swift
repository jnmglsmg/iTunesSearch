//
//  NetworkService.swift
//  Kumu Technical Exam
//
//  Created by Erica Caber on 7/17/21.
//  Copyright © 2021 JM Sumague. All rights reserved.
//

import UIKit

struct Resource<T: Decodable> : Decodable {
    let url: String
}

class NetworkService: NSObject {
    static let shared = NetworkService()
    typealias URLRequestCompletion = (_ result: Data?, _ error: Error?) -> Void
    
    func loadData(with urlString: String, completion:@escaping URLRequestCompletion) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            completion(data, nil)
        }.resume()
    }
}
