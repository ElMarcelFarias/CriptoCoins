//
//  GlobalRouter.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 19/04/23.
//

import Foundation

//  Implementação para o Router do Global Values, dados globais de criptomoedas

enum GlobalRouter {
    case global
    
    var path: String {
        switch self {
        case .global:
            return API.global
        }
    }
    
    // Agora precisamos disso em formato de URL
    // para isso serve essa func abaixo.
    // ela é uma implementação simples por quê não precisa de queryparameters.
    
    func asURLRequest() throws -> URL? {
        guard let url = URL(string: API.baseUrl) else { return nil }
        let URLRequest = URLRequest(url: url.appendingPathComponent(path))
        
        switch self {
        case .global:
            return URLRequest.url
        }
    }

    
    
}




