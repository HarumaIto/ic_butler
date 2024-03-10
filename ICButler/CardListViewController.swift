//
//  CardListViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/05.
//

import UIKit
import RealmSwift

class CardListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let realm = try! Realm()
    var cards: [CardInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cards = readCards()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CardInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "CardInfoCell")
    }
    
    func readCards() -> [CardInfo] {
        return Array(realm.objects(CardInfo.self))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardInfoCell", for: indexPath) as! CardInfoTableViewCell
        let cardInfo: CardInfo = cards[indexPath.row]
        cell.setCell(cardInfo: cardInfo)
        
        return cell
    }
}
