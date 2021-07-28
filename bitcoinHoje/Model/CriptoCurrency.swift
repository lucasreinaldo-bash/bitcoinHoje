//
//  CriptoCurrency.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 21/07/21.
//

import Foundation

struct CriptoCurrency {
    
    let id: String
    let title: String

    static let list = [
        CriptoCurrency(id: "BTC", title: "BITCOIN"),
        CriptoCurrency(id: "XRP", title: "XRP"),
        CriptoCurrency(id: "LTC", title: "LITECOIN"),
        CriptoCurrency(id: "ETH", title: "ETHEREUM"),
        CriptoCurrency(id: "BCH", title: "BITCOINCASH"),
        CriptoCurrency(id: "LINK", title: "CHAILINK")


    ]
}
