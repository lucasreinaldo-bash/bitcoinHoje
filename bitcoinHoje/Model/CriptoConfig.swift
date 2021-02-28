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
            
            
            //URL da API utilizada
            let mercadoBitcoinURL = "https://www.mercadobitcoin.net/api/"
            
            
            
            //Metodo utilizado para buscar os valores referentes ao ID da cripto recebida por parametro
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
                            
                            
                            //Se não houver conexão com a API, o metodo erroRequest da HomeViewController é acionado
                            //Dessa forma, os valores das criptomoedas será recuperado do armazenamento local, trazendo persistência nos dados.
                            self.delegate?.erroRequest(error: error!)
                            return
                        }
                        
                        if let safeData = data {
                            if let cripto = self.parseJSON(safeData, coinID){
                                
                                //Usando o delegate para se comunicar com a HomeViewController e atualizar as informacoes da View em tempo real
                                self.delegate?.atualizarInformacoes(self, criptoInformations: cripto, coinID: coinID)
                            }
                        }
                        
                        
                    }
                    task.resume()
                }
                
                
                
                
            }
            func parseJSON(_ criptoData:Data, _ coinID:String) -> CriptomoedaModel? {
                
                
                //Instanciando o JSONDecoder para transformar o objeto json em objeto modelado de acordo com o CriptomoedasData
                let decoder = JSONDecoder()
                
                do {
                    
                    let  decoderData = try decoder.decode(CriptomoedasData.self, from: criptoData)
                    
                    let ultimoPreco  = decoderData.ticker.last
                    let maiorPreco = decoderData.ticker.high
                    let menorPreco = decoderData.ticker.low
                    
                    //Adicionando os valores extraidos para a classe modelo
                    let criptomoedaModel = CriptomoedaModel(ultimoPreco: ultimoPreco, maiorPreco: maiorPreco, menorPreco: menorPreco)
                    
                    
                    
                    //Salvando os dados localmente atraves do UserDefaults
                    salvarLocalmente(coinID: coinID, lastPrice: ultimoPreco, highPrice: maiorPreco, lowPrice: menorPreco)
                    
                    return criptomoedaModel
                    
                    
                }catch {
                    
                    
                    delegate?.erroRequest(error: error)
                    return nil
                }
            }
            
            func salvarLocalmente(coinID:String, lastPrice:String, highPrice:String, lowPrice:String){
                
                
                let ultimoPreco = lastPrice.currencyFormatting()
                let maiorPreco = highPrice.currencyFormatting()
                let menorPreco = lowPrice.currencyFormatting()
                
                
                
                
                //Instanciando o UserDefaults para armazenas as informacoes
                let defaults = UserDefaults.standard
                
                defaults.setValue(ultimoPreco, forKey: "lastPrice\(coinID)")
                defaults.setValue(maiorPreco, forKey: "highPrice\(coinID)")
                defaults.setValue(menorPreco, forKey: "lowPrice\(coinID)")
                
                
                //Separando valores no seu formato original para atribuir ao grafico de detalhes
                defaults.setValue(Double(lastPrice), forKey: "lastPriceChart\(coinID)")
                defaults.setValue(Double(highPrice), forKey: "highPriceChart\(coinID)")
                defaults.setValue(Double(lowPrice), forKey: "lowPriceChart\(coinID)")
                
            }
        }
        
        
        
        
