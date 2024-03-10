//
//  ViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/04.
//

import UIKit
import TRETJapanNFCReader_FeliCa
import TRETJapanNFCReader_FeliCa_TransitIC
import RealmSwift

class ScanViewController: UIViewController, FeliCaReaderSessionDelegate {
    
    var reader: TransitICReader!
    
    var cardInfo: CardInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.reader = TransitICReader(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.reader.get(itemTypes: [.balance, .entryExitInformations, .transactions])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScanResult" {
            let next = segue.destination as? ScanResultViewController
            next?.cardInfo = self.cardInfo
        }
    }
    
    func feliCaReaderSession(didRead feliCaCardData: TRETJapanNFCReader_FeliCa.FeliCaCardData, pollingErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : Error?]?, readErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : [TRETJapanNFCReader_FeliCa.FeliCaServiceCode : Error]]?) {
        let card = feliCaCardData as! TransitICCardData
        
        cardInfo = CardInfo().fromCardData(cardData: card)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toScanResult", sender: nil)
        }
    }
    
    // 読み取りエラー処理
    func feliCaReaderSession(didInvalidateWithError pollingErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : Error?]?, readErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : [TRETJapanNFCReader_FeliCa.FeliCaServiceCode : Error]]?) {
        
    }
    
    // 読み取りエラー処理
    func japanNFCReaderSession(didInvalidateWithError error: Error) {
        
    }
}

