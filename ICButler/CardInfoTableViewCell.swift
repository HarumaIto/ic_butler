//
//  CardInfoTableViewCell.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/05.
//

import UIKit

class CardInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var balance: UILabel!
    @IBOutlet var transactionCount: UILabel!
    
    @IBOutlet var balanceProgress: UIProgressView!
    @IBOutlet var transactionProgress: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(cardInfo: CardInfo) {
        name.text = cardInfo.name
        // 金額は0~20000だから 0~1で正規化
        balance.text = "\(cardInfo.balance)円"
        balanceProgress.progress = Float(cardInfo.balance) / 20000.0
        // 最大で取得できる取引履歴は20件だから
        transactionCount.text = "\(cardInfo.transactions.count)件"
        transactionProgress.progress = Float(cardInfo.transactions.count) / 20.0
    }
}
