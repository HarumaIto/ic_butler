//
//  CardInfo.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import Foundation
import RealmSwift
import TRETJapanNFCReader_FeliCa_TransitIC

class CardInfo: Object {
    @Persisted var id: String
    @Persisted var name: String
    @Persisted var balance: Int
    @Persisted var transactions: List<Transaction>
    
    func fromCardData(cardData: TransitICCardData) -> CardInfo {
        var cardInfo = CardInfo()
        cardInfo.id = cardData.primaryIDm
        cardInfo.name = "unknown"
        cardInfo.balance = cardData.balance!
        
        print("入退場情報")
        for data in cardData.entryExitInformationsData! {
            print(data.hexString)
        }
        print("取引データ")
        let transactions: List<Transaction> = List()
        for data in cardData.transactionsData! {
            if data[0] == 0 {
                continue
            }
            
            transactions.append(Transaction().fromData(data: data))
        }
        cardInfo.transactions = transactions
        
        return cardInfo
    }
}
