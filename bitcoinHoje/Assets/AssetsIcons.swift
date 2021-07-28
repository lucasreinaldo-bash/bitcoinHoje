//
//  AssetsIcons.swift
//  bitcoinHoje
//
//  Created by Lucas Reinaldo on 14/07/21.
//


import UIKit


public class AssetsIcons {
    
    public static let iconXRP = UIImage(named: "iconXRP", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let iconBCH = UIImage(named: "iconBCH", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let iconETH = UIImage(named: "iconETH", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let iconLINK = UIImage(named: "iconLINK", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let iconLTC = UIImage(named: "iconLTC", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let iconBTC = UIImage(named: "iconBTC", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    public static let logo = UIImage(named: "logo", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    
    public static func currencyIcon(_ currencyId: String) -> UIImage? {
        return UIImage(named: "icon\(currencyId)", in: Bundle(for: AssetsIcons.self), compatibleWith: nil)
    }



}
