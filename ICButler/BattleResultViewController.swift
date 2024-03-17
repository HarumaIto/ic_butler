//
//  BattleResultViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/16.
//

import UIKit

class BattleResultViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {

    @IBOutlet var cardView: UIView!
    @IBOutlet var cardNumber: UILabel!
    @IBOutlet var cardName: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    var cardInfo: CardInfo?
    var firstCard: CardInfo?
    var secondCard: CardInfo?
    
    var primaryColor: UIColor = UIColor(hexString: "#F4C06D")
    
    var stationCodeLines = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        cardInfo = getWinnerCard()
        cardView.backgroundColor = primaryColor
        cardName.text = cardInfo!.name
        
        guard let path = Bundle.main.path(forResource: "StationCode", ofType: "csv") else {
            print("Not found file")
            return
        }
        
        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            stationCodeLines = csvString.components(separatedBy: .newlines)
        } catch let error as NSError {
            print("エラー\(error)")
            return
        }
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
    
    func getStationNameForCode(_ code: String) -> String {
        let lineCode = code.prefix(2)
        let stationCode = code.suffix(2)
        
        for line in stationCodeLines {
            let componets = line.components(separatedBy: ",")
            if (componets[0] == lineCode && componets[1] == stationCode) {
                return componets[4]
            }
        }
        return "その他"
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransactionCell", for: indexPath)
        let transaction: Transaction = cardInfo!.transactions[indexPath.row]
        
        let entry = cell.contentView.viewWithTag(2) as! UILabel
        entry.text = getStationNameForCode(transaction.entryCode)
        let exit = cell.contentView.viewWithTag(1) as! UILabel
        exit.text = getStationNameForCode(transaction.exitCode)
        let date = cell.contentView.viewWithTag(4) as! UILabel
        date.text = transaction.date
        let balance = cell.contentView.viewWithTag(3) as! UILabel
        balance.text = "\(transaction.balance)円"
        
        return cell
    }
    
    func getWinnerCard() -> CardInfo {
        if (firstCard!.balance > secondCard!.balance) {
            cardNumber.text = "１つ目のカード"
            primaryColor = UIColor.init(hexString: "#F4C06D")
            return firstCard!
        } else {
            cardNumber.text = "２つ目のカード"
            primaryColor = UIColor.init(hexString: "#63C591")
            return secondCard!
        }
    }
    
    @IBAction func backButton() {
        self.dismiss(animated: false)
    }
}
