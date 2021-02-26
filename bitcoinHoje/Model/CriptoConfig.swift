//
//  CriptomoedaConfig.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 26/02/21.
//

import Foundation


protocol CriptoManagerDelegate {
    func atualizarInformacoes(_ criptoConfig: CriptoConfig,  criptoInformations: CriptomoedaModel, coinID: String)
    func erroRequest (error: Error)
}
struct CriptoConfig{
    
    
    var delegate: CriptoManagerDelegate?
    
    let mercadoBitcoinURL = "https://www.mercadobitcoin.net/api/"
    
    
    
    func buscarCripto(coinID:String){
        let enderecoFinal = "\(mercadoBitcoinURL)\(coinID)/ticker"
        
        performRequest(with: enderecoFinal, with: coinID)
    }
    
    func performRequest(with enderecoFinal: String, with coinID: String){
        
        //Criando a URL
        if let url = URL(string: enderecoFinal){
            
            //Criando a URLSession
            let session = URLSession(configuration: .default)
            
            //Iniciando tarefa para a sessao criada
            
            let task = session.dataTask(with: url){
                (data, response, error) in
                
                
                if error != nil {
                    print("estouaqui")
                    self.delegate?.erroRequest(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let cripto = self.parseJSON(safeData, coinID){
                        self.delegate?.atualizarInformacoes(self, criptoInformations: cripto, coinID: coinID)
                    }
                      }
                
                
            }
            task.resume()
        }
        
       
        
        
    }
    func parseJSON(_ criptoData:Data, _ coinID:String) -> CriptomoedaModel? {
        
        let decoder = JSONDecoder()
        
        do {
            
          let  decoderData = try decoder.decode(CriptomoedasData.self, from: criptoData)
        
            let buy  = decoderData.ticker.buy 
            
            
            let criptomoedaModel = CriptomoedaModel(buy: buy)
            
            salvarLocalmente(coinID: coinID, lastPrice: buy)
            
            return criptomoedaModel
        
        
        }catch {
            
    
            delegate?.erroRequest(error: error)
            return nil
        }
    }
    
    func salvarLocalmente(coinID:String, lastPrice:String){
        
        let defaults = UserDefaults.standard
        
        defaults.setValue(Float(lastPrice), forKey: "lastPrice\(coinID)")
        
    }
}




