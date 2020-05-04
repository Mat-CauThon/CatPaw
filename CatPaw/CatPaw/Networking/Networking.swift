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
    
    private enum Urls: String {
        case cats = "https://api.thecatapi.com/v1/images/search"
        case breeds = "https://api.thecatapi.com/v1/breeds"
    }
    
    private var delegate: UIViewControllerDelegate
    
    init(delegate: UIViewControllerDelegate) {
        self.delegate = delegate
    }
    
    public func loadBreeds(completion:@escaping ([Breed]?)->()) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            let urlTxt = Urls.breeds.rawValue
            let safeURL = urlTxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let components = URLComponents(string: safeURL)!
            var request = URLRequest(url: components.url!)
            request.setValue("b2e2af0a-38d7-45ec-a919-483e4cd9915a", forHTTPHeaderField: "x-api-key")
            
            let task = URLSession.shared.dataTask(with: request) { data, responce, err in
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
                    let parsedResult = try decoder.decode([CodableBreed].self, from: data)
                    var breeds: [Breed] = []
                    for codableBreed in parsedResult {
                        breeds.append(codableBreed.retBreed())
                    }
                    completion(breeds)
                    
                } catch {
                    DispatchQueue.main.async {
                        self?.delegate.alarm(message: "Service doesn't respond")
                    }
                }
            }
            task.resume()
        }
    }
    
    public func loadCats(items: [URLQueryItem], completion: @escaping ((CatClass?)->())) {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [weak self] in
            let urlTxt = Urls.cats.rawValue
            let safeURL = urlTxt.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            var components = URLComponents(string: safeURL)!
            components.queryItems = items
//            for item in items {
//                components.queryItems?.append(URLComponents)
//            }
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
//                    decoder.keyDecodingStrategy = .convertFromSnakeCase
//                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let parsedResult = try decoder.decode([CodableCatClass].self, from: data)
                    
                    for codableCat in parsedResult {
                        var breedsList: [Breed] = []
                        for codableBreed in codableCat.breeds {
                            breedsList.append(codableBreed.retBreed())
                        }
                        completion(CatClass(id: codableCat.id, url: codableCat.url, width: codableCat.width, height: codableCat.height, breeds: breedsList))
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
