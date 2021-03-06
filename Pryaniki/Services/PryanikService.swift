//
//  PryanikService.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright © 2020 Danil Semenov. All rights reserved.
//

import Foundation

enum PryanikServiceError: Error {
    case badUrl
    case decodeError
    case badRequest
}

protocol PryanikServiceProtocol {
    var baseUrl: String { get }
    
    func loadPryanikData(completion: @escaping (Result<PryanikResponse, PryanikServiceError>) -> ())
}

final class PryanikService {
    
    static let shared = PryanikService()
    private init() {}
}

extension PryanikService: PryanikServiceProtocol {
    var baseUrl: String {
        "https://chat.pryaniky.com/"
    }
    
    func loadPryanikData(completion: @escaping (Result<PryanikResponse, PryanikServiceError>) -> ()) {
        guard var finalUrl = URL(string: baseUrl) else {
            completion(.failure(.badUrl))
            return
        }
        
        finalUrl.appendPathComponent("json/data-default-order-custom-data-in-view.json")
        
        URLSession.shared.dataTask(with: finalUrl) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.badRequest))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(.badRequest))
                }
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            if let dict = json as? [String: Any] {
                var pryanikItems: [PryanikItem] = []
                var pryanikTypes: [PryanikViewType] = []
                
                if let pryanikData = dict["data"] as? Array<[String: Any]>,
                    let pryanikView = dict["view"] as? Array<String> {
                    
                    for dataItem in pryanikData {
                        if let name = dataItem["name"] as? String, let itemDict = dataItem["data"] as? [String: Any] {
                            
                            if name == PryanikViewType.hz.rawValue {
                                guard
                                    let text = itemDict["text"] as? String,
                                    let type = PryanikViewType(rawValue: name) else {
                                    DispatchQueue.main.async {
                                        completion(.failure(.decodeError))
                                    }
                                    return
                                }
                                let itemData = PryanikHzItem(name: text)
                                let item = PryanikItem(name: type, data: itemData)
                                pryanikItems.append(item)
                            }
                            else if name == PryanikViewType.picture.rawValue {
                                guard
                                    let text = itemDict["text"] as? String,
                                    let urlString = itemDict["url"] as? String,
                                    let type = PryanikViewType(rawValue: name) else {
                                    DispatchQueue.main.async {
                                        completion(.failure(.decodeError))
                                    }
                                    return
                                }
                                let itemData = PryanikPictureItem(text: text, url: urlString)
                                let item = PryanikItem(name: type, data: itemData)
                                pryanikItems.append(item)
                            }
                            else if name == PryanikViewType.selector.rawValue {
                                guard
                                    let type = PryanikViewType(rawValue: name),
                                    let selectorData = dataItem["data"] as? [String: Any],
                                    let selectedId = selectorData["selectedId"] as? Int,
                                    let variants = selectorData["variants"] as? Array<[String: Any]> else {
                                    DispatchQueue.main.async {
                                        completion(.failure(.decodeError))
                                    }
                                    return
                                }
                                var variantsArray: [PryanikSelectorItem.Variant] = []
                                
                                for variant in variants {
                                    guard
                                        let variantId = variant["id"] as? Int,
                                        let variantText = variant["text"] as? String else {
                                        DispatchQueue.main.async {
                                            completion(.failure(.decodeError))
                                        }
                                        return
                                    }
                                    let item = PryanikSelectorItem.Variant(id: variantId, text: variantText)
                                    variantsArray.append(item)
                                }
                                
                                let itemData = PryanikSelectorItem(selected: selectedId, variants: variantsArray)
                                let item = PryanikItem(name: type, data: itemData)
                                pryanikItems.append(item)
                            }
                            else {
                                continue
                            }
                        }
                    }
                    for item in pryanikView {
                        if let type = PryanikViewType(rawValue: item) {
                            pryanikTypes.append(type)
                        }
                        else {
                            continue
                        }
                    }
                    
                    let response = PryanikResponse(data: pryanikItems, view: pryanikTypes)
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.failure(.decodeError))
                }
            }
        }.resume()
    }
}
