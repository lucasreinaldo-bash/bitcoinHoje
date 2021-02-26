//
//  bitcoinModel.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 23/02/21.
//

import Foundation

struct CriptomoedasData: Decodable{
    let ticker:Ticker
    
    
    
    
    struct Ticker: Decodable {
        let buy:String
    }
    
}

