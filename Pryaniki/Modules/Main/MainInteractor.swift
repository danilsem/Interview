//
//  MainInteractor.swift
//  Pryaniki
//
//  Created by Admin on 30.09.2020.
//  Copyright (c) 2020 Danil Semenov. All rights reserved.

import Foundation

final class MainInteractor {
    let service: PryanikServiceProtocol
    
    init(service: PryanikServiceProtocol = PryanikService.shared) {
        self.service = service
    }
}

// MARK: - Extensions -

extension MainInteractor: MainInteractorInterface {
    func getPryanikData(completion: @escaping (Result<[PryanikItem], PryanikServiceError>) -> ()) {
        self.service.loadPryanikData { (result) in
            switch result {
            case .success(let response):
                var pryanikArray: [PryanikItem] = []
                for item in response.view {
                    for dataItem in response.data {
                        if item == dataItem.name {
                            pryanikArray.append(dataItem)
                        }
                    }
                }
                completion(.success(pryanikArray))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
