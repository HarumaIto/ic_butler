//
//  ScanResultViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import UIKit
import RealmSwift

class ScanResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var cardName: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardInfo!.transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Util からでディスプレイサイズ取得
        // Width はそれを使い，高さは適切な値で返してやる
        let returnSize = CGSize(width: Util.returnDisplaySize().width - 36, height: 84)

        return returnSize
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransactionCell", for: indexPath)
        let transaction: Transaction = cardInfo!.transactions[indexPath.row]
        
        let entry = cell.contentView.viewWithTag(2) as! UILabel
        entry.text = transaction.entryCode
        let exit = cell.contentView.viewWithTag(1) as! UILabel
        exit.text = transaction.exitCode
        let date = cell.contentView.viewWithTag(4) as! UILabel
        date.text = transaction.date
        let balance = cell.contentView.viewWithTag(3) as! UILabel
        balance.text = "\(transaction.balance)円"
        
        return cell
    }
    
    @IBAction func backButton() {
        self.dismiss(animated: false)
    }
    
    @IBAction func pushCardsButton() {
        
    }
}
