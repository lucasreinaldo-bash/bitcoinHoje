//
//  CriptoDetalhesViewController.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 26/02/21.
//

import UIKit
import Charts
class CriptoDetalhesViewController: UIViewController, ChartViewDelegate {

    
    var criptoID = "BTC"
    var lineChart = LineChartView()
    override func viewDidLoad() {
        super.viewDidLoad()
        lineChart.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lineChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300)
        lineChart.center = view.center
        view.addSubview(lineChart)
        
        atualizarChat()
    }
    

    func atualizarChat(){
        
        
        //Instanciando o UserDefaults
        let defaults = UserDefaults()
        
       
        //Recuperando valores armazenados localmente para atribuir ao grafico
        let menorPreco = defaults.double(forKey: "lowPriceChart\(criptoID)")
        let maiorPreco = defaults.double(forKey: "highPriceChart\(criptoID)")
        let ultimoPreco = defaults.double(forKey: "lastPriceChart\(criptoID)")
        
        var dados = [ChartDataEntry]()
        
        dados.append(ChartDataEntry(x:Double(menorPreco), y: Double(menorPreco)))

        dados.append(ChartDataEntry(x:Double(maiorPreco), y: Double(maiorPreco)))
        dados.append(ChartDataEntry(x:Double(maiorPreco), y: Double(ultimoPreco)))
        
        
        let informacoesGrafico = LineChartDataSet(entries: dados, label: nomeCripto(sigla: criptoID))
        let chartData = LineChartData(dataSet: informacoesGrafico)
        
        lineChart.data = chartData
      
       
    }
    
    //Funcao retorna o nome da cripto correspondente a sigla recebida
    func nomeCripto(sigla:String) -> String {
        
        var moeda : String = ""
        
        switch sigla {
        case "BTC":
            moeda = "Bitcoin"
        case "BCH":
            moeda = "Bitcoin Cash"
        case "XRP":
                moeda = "XRP"
        case "LINK":
            moeda = "Chailink"
        case "ETH":
            moeda = "Ethereum"
        default:
            moeda = "Litecoin"
        }
        
        return moeda
    }

    
    
}
