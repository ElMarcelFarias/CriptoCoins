//
//  GlobalStore.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 25/04/23.
//

import Foundation

protocol GlobalStoreProtocol: GerericStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>)
}

class GlobalStore: GenericStoreRequest, GlobalStoreProtocol {
    func fetchGlobal(completion: @escaping completion<GlobalModel?>) {
        do {
            guard let url = try GlobalRouter.global.asURLRequest() else {
                return completion(nil, error)
            }
            request(url: url, completion: completion)
            
        } catch let error {
            completion(nil, error)
        }
    }
    
    
}
