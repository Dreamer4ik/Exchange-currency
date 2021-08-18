//
//  CurrencyTableViewCell.swift
//  Currency change
//
//  Created by Ivan Potapenko on 01.08.2021.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var ccyLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    
    
    
    func configureCellWidth(currency: Currency){
        self.ccyLabel.text = currency.ccy
        self.buyLabel.text = currency.ccy == "BTC" ? "buy:\(currency.buy?.prefix(7) ?? "-") \(currency.baseCcy ?? "")"
            : "buy:\(currency.buy?.prefix(5) ?? "-") \(currency.baseCcy ?? "")"
        self.saleLabel.text = currency.ccy == "BTC" ? "sale:\(currency.sale?.prefix(7) ?? "-") \(currency.baseCcy ?? "")"
            : "sale:\(currency.sale?.prefix(5) ?? "-") \(currency.baseCcy ?? "")"
        //Измение RUR на руб RUB
        if let ccy = currency.ccy {
            switch ccy {
            case "RUR":
                let substring = currency.ccy!.prefix(2)
                self.ccyLabel.text = String(substring) + "B"

            default:
                    self.ccyLabel.text = currency.ccy
            }

        }
    }

}
