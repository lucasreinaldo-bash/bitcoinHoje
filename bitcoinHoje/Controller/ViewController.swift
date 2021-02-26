//
//  ViewController.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 23/02/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CriptoManagerDelegate {
    
    @IBOutlet weak var moedasPickerView: UIPickerView!


    @IBOutlet weak var ultimoPrecoLabel: UILabel!
    
    var valorBTC:String = "0"
    
    var precoList:[Double] = []
    var moedasDestinoList: [Double] = []
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
        
        
        return simboloMoedaList[row]
    }
    
    func atualizarInformacoes(criptoInformations: CriptomoedaModel){
        
        ultimoPrecoLabel.text = String(format: "%.2f",criptoInformations.buy)
        print()
    }
    
}

