//
//  ViewController.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 23/02/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CriptoManagerDelegate {
    func erroRequest(error: Error) {
        
    }
    
    
    @IBOutlet weak var lastPriceLabel: UILabel!
    @IBOutlet weak var moedasPickerView: UIPickerView!

    @IBOutlet weak var criptoImageView: UIImageView!
    
    

    
    var precoList:[Double] = []
    var moedasDestinoList: [Double] = []
    var criptoKey: String = "BTC"
    var simboloMoedaList: [String] = ["BITCOIN","LITECOIN","XRP","ETHEREUM","BITCOIN CASH","CHAILINK"]
    
    
    var criptoConfig = CriptoConfig()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        switch simboloMoedaList[row] {
        case "BITCOIN":
        criptoConfig.buscarCripto(coinID:"BTC")
        case "XRP":
        criptoConfig.buscarCripto(coinID:"XRP")
        case "BITCOIN CASH":
        criptoConfig.buscarCripto(coinID:"BCH")
        case "ETHEREUM":
        criptoConfig.buscarCripto(coinID:"ETH")
        case "CHAILINK":
        criptoConfig.buscarCripto(coinID:"LINK")
        case "LITECOIN":
        criptoConfig.buscarCripto(coinID:"LTC")
        default:
            criptoConfig.buscarCripto(coinID:"BTC")
        }
        criptoKey = simboloMoedaList[row]
        
        return simboloMoedaList[row]
    }
    
    func atualizarInformacoes(_ criptoConfig: CriptoConfig,  criptoInformations: CriptomoedaModel, coinID: String){
        
        var buy = Float(criptoInformations.buy)
        var buyFormated = String(format: "%.2f",buy as! CVarArg)
        
 
        let defaults = UserDefaults()
        let criptoID = defaults.float(forKey: "lastPrice\(coinID)")
        
        DispatchQueue.main.async {
            self.lastPriceLabel.text = "R$ \(criptoID)"
            
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
        print(error)
    }
    
    
}

}
