//
//  ViewController.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 23/02/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    


    @IBOutlet weak var moedasPickerView: UIPickerView!

    @IBOutlet weak var valorBtcLabel: UILabel!
    @IBOutlet weak var moedasPicker: UIPickerView!
    
    
    var precoList:[Double] = []
    var moedasDestinoList: [Double] = []
    var simboloMoedaList: [String] = ["Real","Dolar", "Euro"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recuperarCotacaoBtc()
        moedasPickerView.dataSource = self
        moedasPickerView.delegate = self
        
        
    }
    func recuperarCotacaoBtc() {
        
        guard let url = URL(string: "https://blockchain.info/ticker") else {return}
        URLSession.shared.dataTask(with: url){(data, response, error) in
            
            
            if error != nil {
                print(error!)
                return
                
            }
            
            guard let data = data else {return}
            
            
            do {
                let bitcoin = try JSONDecoder().decode([String: BitcoinData].self, from: data)
                
                for(_, value) in bitcoin {
                 
                    self.precoList.append(value.buy)
//                    self.simboloMoedaList.append(key)
                    
                    DispatchQueue.main.async {
                        self.moedasPickerView.reloadAllComponents()
                    }
                    
                }
                self.valorBtcLabel.text = String(format: "R$%.2f",self.precoList[0])
            }
            catch{
                print(error)
            }
        }.resume()
    }
    
    //Funcoes responsaveis em popular o PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ moedasPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return   simboloMoedaList.count
    }
    
    func pickerView(_ moedasPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return simboloMoedaList[row]
    }
    
}

