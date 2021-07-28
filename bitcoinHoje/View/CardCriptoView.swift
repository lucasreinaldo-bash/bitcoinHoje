//
//  CardCriptoView.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 14/07/21.
//

import Foundation
import UIKit


class CardCriptoView: UIView {
    
    private lazy var container = containerView()
    private lazy var stackView = buildStackView()
    private lazy var title = titleLabel()
    lazy var currencyLabel = currencyValueLabel()
    lazy var iconView = currencyIconImageView()
    lazy var messageLabel = messageLowPriceLabel()
    private lazy var buttonCharView = buildChartButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        addSubview(container)
        container.addSubview(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(iconView)
        stackView.addArrangedSubview(messageLabel)
        stackView.addArrangedSubview(buttonCharView)



        NSLayoutConstraint.activate([
        
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: stackView.topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: container.topAnchor,constant: 20),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),

            
            
        ])

        
    }
    
    
}

//Mark: UI Factory

extension CardCriptoView {
    
    private func containerView() -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 14
        container.dropShadow()
        container.clipsToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        
        return container
        
    }
    
    private func buildStackView() -> UIStackView {
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.setCustomSpacing(20,after: iconView)
        stack.setCustomSpacing(40, after: messageLabel)
        stack.distribution = .fill
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func titleLabel() -> UILabel{
    
        let label = UILabel()
        label.text = "Último Preço"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func currencyValueLabel() -> UILabel{
    
        let label = UILabel()
        label.text = "R$"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func currencyIconImageView() -> UIImageView{
    
        let label = UIImageView(image: AssetsIcons.iconBTC)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 50
        ).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50
        ).isActive = true

        return label
    }
    
    private func messageLowPriceLabel() -> UILabel{
    
        let label = UILabel()
        label.text = "Maior preço em 24 hrs: "
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func buildChartButton() -> UIButton{
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .orange.withAlphaComponent(80)
        button.setTitle("Vizualizar Gráfico", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    public func setCriptoCurrency(_ currency: CriptoCurrency) {
        DispatchQueue.main.async { [weak self] in
            self?.iconView.image = AssetsIcons.currencyIcon(currency.id)
        }
    }
    
    public func setMoneyInfo(_ lastPrice: String, highPrice: String){
        DispatchQueue.main.async { [weak self] in
            self?.currencyLabel.text = lastPrice.currencyFormatting()
            self?.messageLabel.text = "Maior preço em 24 hrs: \(highPrice.currencyFormatting())"

        }

    }
    
}

extension UIView {

  // OUTPUT 1
  func dropShadow(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowOffset = CGSize(width: -1, height: 4)
    layer.shadowRadius = 3

//    let shadowRect = CGRect(x: 0, y: 0, width: 0, height: bounds.h)
//    layer.shadowPath = UIBezierPath(rect: frame).cgPath
//    layer.shouldRasterize = true
//    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
}
