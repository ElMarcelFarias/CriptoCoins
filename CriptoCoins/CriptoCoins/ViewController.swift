//
//  ViewController.swift
//  CriptoCoins
//
//  Created by Marcel Leite de Farias on 12/04/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataProvider = ListCoinsDataProvider()
        dataProvider.delegete = self
        dataProvider.fetchListCoins(by: "brl",
                                    with: nil,
                                    orderBy: "market_cap_desc",
                                    total: 10,
                                    page: 1,
                                    percentagePrice: "1h")
    }


}

extension ViewController: ListCoinsDataProviderDelegate {
    func success(model: Any) {
        let coinList = model as? [CoinModel]
        print(coinList ?? "Vazio")
    }
    
    func errorData(_ provider: GenericDataProviderDelegate?, error: Error) {
        print(error.localizedDescription)
    }
}

