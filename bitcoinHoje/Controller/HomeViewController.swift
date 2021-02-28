        //
        //  ViewController.swift
        //  bitcoinHoje
        //
        //  Created by Lucas Reinaldo on 23/02/21.
        //

        import UIKit

        class HomeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CriptoManagerDelegate {
            
            @IBOutlet weak var highPriceLabel: UILabel!
            @IBOutlet weak var lastPriceLabel: UILabel!
            @IBOutlet weak var moedasPickerView: UIPickerView!

            @IBOutlet weak var criptoImageView: UIImageView!
            
            

            
            var precoList:[Double] = []
            var moedasDestinoList: [Double] = []
            var criptoKey: String = "BTC"
            var simboloMoedaList: [String] = ["BITCOIN","XRP","LITECOIN","ETHEREUM","BITCOIN CASH","CHAILINK"]
            
            
            var criptoConfig = CriptoConfig()
            
            

            override func viewDidLoad() {
                super.viewDidLoad()
                criptoConfig.delegate = self
                moedasPickerView.dataSource = self
                moedasPickerView.delegate = self
                criptoConfig.buscarCripto(coinID:"BTC")
                
              
                
            }
         
            //Funcoes responsaveis em popular o PickerView
            
            func numberOfComponents(in pickerView: UIPickerView) -> Int {
               1
            }
            
            func pickerView(_ moedasPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
              return   simboloMoedaList.count
            }
            
            func pickerView(_ moedasPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                
                
                
                
                //Estrutura Case que serve para avaliar a seleção do usuario e atribuir a sigla correspondente
                //Essa sigla será utilizada para concatenar a URL da api do Mercado Bitcoin
                switch simboloMoedaList[row] {
                case "BITCOIN":
                criptoConfig.buscarCripto(coinID:"BTC")
                    criptoKey = "BTC"
                case "XRP":
                criptoConfig.buscarCripto(coinID:"XRP")
                    criptoKey = "XRP"
                case "BITCOIN CASH":
                criptoConfig.buscarCripto(coinID:"BCH")
                    criptoKey = "BCH"
                case "ETHEREUM":
                criptoConfig.buscarCripto(coinID:"ETH")
                    criptoKey = "ETH"
                case "CHAILINK":
                criptoConfig.buscarCripto(coinID:"LINK")
                    criptoKey = "LINK"
                case "LITECOIN":
                criptoConfig.buscarCripto(coinID:"LTC")
                    criptoKey = "LTC"
                default:
                    criptoConfig.buscarCripto(coinID:"BTC")
                    criptoKey = "BTC"
                }
                
                
                return simboloMoedaList[row]
            }
            
            func atualizarInformacoes(_ criptoConfig: CriptoConfig,  criptoInformations: CriptomoedaModel, coinID: String){
                

               
                //Preciso do DispatchQuee para atualizar os valores da View que sao provinientes do delegate
                DispatchQueue.main.async {
                    self.lastPriceLabel.text = criptoInformations.ultimoPreco.currencyFormatting()
                    self.highPriceLabel.text = "Maior preço em 24 hrs : \(criptoInformations.maiorPreco.currencyFormatting())"
                
                    
                    //Alterando as imagens de acordo com a sigla da Criptomoeda
                    //As imagens estão salvas no Assets, e são instanciadas utilizando o Image Literal
                    switch coinID {
                    case "BTC":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconBTC")
                    case "BCH":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconBCH")
                    case "XRP":
                            self.criptoImageView.image = #imageLiteral(resourceName: "iconXRP")
                    case "LINK":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconLINK")
                    case "ETH":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconETH")
                    default:
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconLTC")
                    }
               
                
            }
            func erroRequest (error: Error){
           
            }
            
             
            
        }
            
            
            //Metodo acionado quando há erro de conexão com a API
            //Caso o dispostivo esteja sem conexão com a internet, as informações atribuidas aos labels serão do banco de dados local
            
            func erroRequest(error: Error) {
                let defaults = UserDefaults()
                
                let lastPrice = defaults.string(forKey: "lastPrice\(criptoKey)")
                let highPrice = defaults.string(forKey: "highPrice\(criptoKey)")
                let lastPriceFormated = lastPrice!.replacingOccurrences(of: "Optional(", with: "+", options: .literal, range: nil)
                let highPriceFormated = highPrice!.replacingOccurrences(of: "Optional(", with: "+", options: .literal, range: nil)
                
                
             
                DispatchQueue.main.async {
                    self.lastPriceLabel.text = lastPriceFormated
                    self.highPriceLabel.text = "Maior preço em 24 hrs : \(highPriceFormated)"
                    
                    //Alterando as imagens de acordo com a sigla da Criptomoeda
                    //As imagens estão salvas no Assets, e são instanciadas utilizando o Image Literal
                    
                    switch self.criptoKey {
                    case "BTC":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconBTC")
                    case "BCH":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconBCH")
                    case "XRP":
                            self.criptoImageView.image = #imageLiteral(resourceName: "iconXRP")
                    case "LINK":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconLINK")
                    case "ETH":
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconETH")
                    default:
                        self.criptoImageView.image = #imageLiteral(resourceName: "iconLTC")
                    }
               
                
            }
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                //Passando por parametro o ID da moeda
                //Essa ID será tratado para acessar a instancia do UserDefaults correspondente a criptoselecionada
                if segue.identifier == "grafico" {
                    let destinationVC = segue.destination as! CriptoDetalhesViewController
                    destinationVC.criptoID = criptoKey
                }
            }
            
            
        }
