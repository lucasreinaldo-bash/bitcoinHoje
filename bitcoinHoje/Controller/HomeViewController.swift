import UIKit
import PKHUD

class HomeViewController: UIViewController{
    
    private lazy var logoView = buildLogoView()
    private lazy var cardCriptoView = CardCriptoView()
    private lazy var currencyPickerView =  buildPickerView()
    private lazy var stackView = buildStackView()
    
    
    var criptoKey = CriptoCurrency.list.first!
    var simboloMoedaList = CriptoCurrency.list
    var criptoConfig = CriptoConfig()
    
    private let navigationBarColor = UIColor.white
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureComponents()
        configureDelegate()
        
        
    }
    
    private func configureNavigationBar() {
        if #available(iOS 13, *) {
            navigationItem.standardAppearance = UINavigationBarAppearance()
            navigationItem.standardAppearance?.backgroundColor = navigationBarColor
            navigationItem.standardAppearance?.shadowColor = navigationBarColor
        }
        
        else {
            navigationController?.navigationBar.barTintColor = navigationBarColor
        }
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func configureComponents(){
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        stackView.addArrangedSubview(logoView)
        stackView.addArrangedSubview(cardCriptoView)
        stackView.addArrangedSubview(currencyPickerView)
        
        
        cardCriptoView.dropShadow()
        
        
        
        NSLayoutConstraint.activate([
            
//            logoView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 20),
//            logoView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 40),
//            logoView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -40),
//
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currencyPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    private func configureDelegate(){
        criptoConfig.delegate = self
        currencyPickerView.dataSource = self
        currencyPickerView.delegate = self
        criptoConfig.buscarCripto(coin: CriptoCurrency.list.first!)
    }
}

//MARK:- UIPickerViewDelegate

extension HomeViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ moedasPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return   simboloMoedaList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        PKHUD.sharedHUD.show()

        let currency = simboloMoedaList[row]
        criptoKey = currency
        criptoConfig.buscarCripto(coin: currency)
        
        
    }
    
    func pickerView(_ moedasPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return simboloMoedaList[row].title
        
    }
    
}

//MARK:- CriptoConfigDelegate

extension HomeViewController: CriptoManagerDelegate{
    func atualizarInformacoes(_ criptoConfig: CriptoConfig,  criptoInformations: CriptomoedaModel, coin: CriptoCurrency){
        DispatchQueue.main.sync {
            HUD.hide()
        }
        cardCriptoView.setCriptoCurrency(coin)
        cardCriptoView.setMoneyInfo(criptoInformations.ultimoPreco, highPrice: criptoInformations.maiorPreco)
    
    }
    
    func erroRequest(error: Error) {
        let defaults = UserDefaults()
    }
}

//MARK:- UIFactory

extension HomeViewController {
    
    private func buildPickerView() -> UIPickerView {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints =  false
        return picker
    }
    
    private func buildStackView() -> UIStackView {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 1
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func buildLogoView() -> UIImageView{
        
        let label = UIImageView(image: AssetsIcons.logo)
//        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    
}






