//
//  TransactionTableViewCell.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet var entryPoint: UILabel!
    @IBOutlet var exitPoint: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var balance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(transaction: Transaction) {
        entryPoint.text = transaction.entryCode
        exitPoint.text = transaction.exitCode
        date.text = transaction.date
        balance.text = "\(transaction.balance)円"
    }
}
