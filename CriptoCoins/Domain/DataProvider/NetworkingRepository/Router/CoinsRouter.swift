//
//  CoinsRouter.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 19/04/23.
//



import Foundation

enum CoinsRouter {
    //  implementações de casos para o router
    case coinsMarket(currency: String, criptocurrency: [String]?, order: String, parPage: Int, page: Int, percantage: String)
    case coinsMarketOhlc(id: String, currency: String, days: String)
    case coinsMarketChart(id: String, currency: String, from: String, to: String)
    case coinsById(id: String)
    
    
    //  implementações dos paths
    var path: String {
        switch self {
        case .coinsMarket:
            return API.coinsMarkets
        case .coinsMarketOhlc(let id, _, _):
            return String(format: API.coinsByIdOhlc, id)
        case .coinsMarketChart(let id, _, _, _):
            return String(format: API.coinsByIdMarketChart, id)
        case .coinsById(let id):
            return String(format: API.coinsById, id)
        }
    }
    
    // Agora precisamos disso em formato de URL
    // para isso serve essa func abaixo.
    
    func asURLRequest() throws -> URL? {
        guard let url = URL(string: API.baseUrl) else { return nil }
        
        switch self {
                case .coinsMarket(let currency, let crytocurrency, let order, let parPage, let page, let percentage):
                var parameters: [String: String] = [
                    "vs_currency": currency,
                    "order": order,
                    "per_page": String(parPage),
                    "page": String(page),
                    "sparkline": String(false),
                    "price_change_percentage": percentage
                ]
                
                if let crytocurrency = crytocurrency{
                    parameters["ids"] = crytocurrency.joined(separator: ",")
                }
                return url.appendingQueryParameters(path: path, parameters: parameters)
            
            
                case .coinsMarketChart(_, let currency, let from, let to):
                    let parameters: [String: String] = [
                        "vs_currency": currency,
                        "from": from,
                        "to": to
                    ]
                return url.appendingQueryParameters(path: path, parameters: parameters)
            
            
                case .coinsMarketOhlc(_, let currency, let days):
                    let parameters: [String: String] = [
                        "vs_currency": currency,
                        "days": days
                    ]
                return url.appendingQueryParameters(path: path, parameters: parameters)
            
                case .coinsById:
                    let parameters: [String: String] = [
                        "localization": "false",
                        "tickers": String(false),
                        "market_data": String(true),
                        "community_data": String(false),
                        "developer_data": String(false),
                        "sparkline": String(false)
                    ]
                return url.appendingQueryParameters(path: path, parameters: parameters)
            
            }
    }
}


