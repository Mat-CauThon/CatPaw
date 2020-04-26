//
//  Networks.swift
//  CatPaw
//
//  Created by Roman Mishchenko on 19.04.2020.
//  Copyright © 2020 Roman Mishchenko. All rights reserved.
//

import Foundation
import SwiftUI

final class Networking {
    
    private var url: String
    private var delegate: UIViewControllerDelegate
    private var limit: Int
    
    init(url: String, delegate: UIViewControllerDelegate, limit: Int) {
        self.url = url
        self.delegate = delegate
        self.limit = limit
    }
    
    func loadCats(completion:@escaping (CatClass?)->()) {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            let safeURL = self?.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var components = URLComponents(string: safeURL!)!
            components.queryItems = [URLQueryItem(name: "limit", value: String(self?.limit ?? 0)), URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "mime_types", value: "jpg")]
            var request = URLRequest(url: components.url!)
            
            request.setValue("b2e2af0a-38d7-45ec-a919-483e4cd9915a", forHTTPHeaderField: "x-api-key")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, err in
                
                guard let data = data, err == nil else {
                    DispatchQueue.main.async {
                        self?.delegate.alarm(message: "Failed loading, check your Internet connection")
                    }
                    completion(nil)
                    return
                }
                
                do {

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let parsedResult = try decoder.decode([CodableCatClass].self, from: data)
                    
                    for codableCat in parsedResult {
                        completion(CatClass(id: codableCat.id, url: codableCat.url, width: codableCat.width, height: codableCat.height))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        self?.delegate.alarm(message: "Service doesn't respond")
                    }
                }
                
                 
                
            }
            task.resume()
        }
    }
}
