//
//  CriptomoedaConfig.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 26/02/21.
//

import Foundation


protocol CriptoManagerDelegate {
    func atualizarInformacoes(criptoInformations: CriptomoedaModel)
}
struct CriptoConfig{
    
    
    var delegate: CriptoManagerDelegate?
    
    let mercadoBitcoinURL = "https://www.mercadobitcoin.net/api/"
    
    
    
    func buscarCripto(coinID:String){
        let enderecoFinal = "\(mercadoBitcoinURL)\(coinID)/ticker"
        
        performRequest(endURL: enderecoFinal)
    }
    
    func performRequest(endURL: String){
        
        //Criando a URL
        if let url = URL(string: endURL){
            
            //Criando a URLSession
            let session = URLSession(configuration: .default)
            
            //Iniciando tarefa para a sessao criada
            
            let task = session.dataTask(with: url){
                (data, response, error) in
                
                
                if error != nil {
                    print(error)
                    return
                }
                
                if let safeData = data {
                    if let cripto = self.parseJSON(moedasData: safeData){
                        self.delegate?.atualizarInformacoes(criptoInformations: cripto)
                    }
                      }
                
                
            }
            task.resume()
        }
        
       
        
        
    }
    func parseJSON(moedasData:Data) -> CriptomoedaModel? {
        
        let decoder = JSONDecoder()
        
        do {
          let  decoderData = try decoder.decode(CriptomoedasData.self, from: moedasData)
        
            let buy  = decoderData.ticker.buy
            
            
            let criptomoedaModel = CriptomoedaModel(buy: buy)
            
            
            return criptomoedaModel
        
        
        }catch {
            print(error)
            return nil
        }
    }
}




