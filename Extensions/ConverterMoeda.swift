//
//  ConverterMoeda.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 27/02/21.
//

import Foundation


extension String {

    func currencyFormatting() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = Locale(identifier: "pt_BR")
            formatter.maximumFractionDigits = 2
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
    
}
