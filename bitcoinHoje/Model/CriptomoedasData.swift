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
        let last:String
        let high:String
        let low:String
        
        
        //As variaveis foram criadas com o mesmo nome utilizado na API , para que a recuperação dos dados ocorra sem problemas
    }
    
}

