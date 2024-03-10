//
//  ScanResultViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import UIKit
import RealmSwift

class ScanResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var cardName: UILabel!
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var cardInfo: CardInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cards = Array(realm.objects(CardInfo.self))
        var isExists: Bool = false
        for card in cards {
            if card.id == cardInfo!.id {
                isExists = true
                try! realm.write {
                    if card.name != "Felica" {
                        card.name = cardInfo!.name
                    }
                    card.balance = cardInfo!.balance
                    card.transactions = cardInfo!.transactions
                }
            }
        }
        
        if !isExists {
            try! realm.write {
                realm.add(cardInfo!)
            }
        }
        
        cardName.text = cardInfo!.name
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionCell")
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardInfo!.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionTableViewCell
        let transaction: Transaction = cardInfo!.transactions[indexPath.row]
        cell.setCell(transaction: transaction)
        
        return cell
    }
    
    @IBAction func backButton() {
        self.dismiss(animated: false)
    }
    
    @IBAction func pushCardsButton() {
        
    }
}
