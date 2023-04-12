//
//  CoinsMarketChart.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 12/04/23.
//  codable por causa do JSON

import Foundation

struct CoinsMarketChartModel: Codable {
    let prices : [GraphicDataModel]
}
