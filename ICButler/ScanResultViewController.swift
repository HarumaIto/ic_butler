//
//  ScanResultViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import UIKit
import RealmSwift

class ScanResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var cardInfo: CardInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! realm.write {
            realm.add(cardInfo!)
        }
        
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
