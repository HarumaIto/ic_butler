//
//  Transaction.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import Foundation
import RealmSwift

class Transaction: Object {
    @Persisted var date: String
    @Persisted var entryCode: String
    @Persisted var exitCode: String
    @Persisted var balance: Int
    
    func fromData(data: Data) -> Transaction {
        let year = Int(data[4] >> 1) + 2000
        let month = ((data[4] & 1) == 1 ? 8 : 0) + Int(data[5] >> 5)
        let day = Int(data[5] & 0x1f)
        
        let transaction = Transaction()
        transaction.date = "\(year)-\(month)-\(day)"
        transaction.balance = Int(data[10]) + Int(data[11]) << 8
        transaction.entryCode = data[6...7].map { String(format: "%02x", $0) }.joined()
        transaction.exitCode = data[8...9].map { String(format: "%02x", $0) }.joined()
        
        return transaction
    }
}
