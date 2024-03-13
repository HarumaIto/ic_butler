//
//  TransactionCollectionViewCell.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/13.
//

import UIKit

class TransactionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var entryPoint: UILabel!
    @IBOutlet var exitPoint: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var balance: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(transaction: Transaction) {
        entryPoint.text = transaction.entryCode
        exitPoint.text = transaction.exitCode
        date.text = transaction.date
        balance.text = "\(transaction.balance)円"
    }
}
