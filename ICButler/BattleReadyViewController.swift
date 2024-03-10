//
//  CardListViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/05.
//

import UIKit
import TRETJapanNFCReader_FeliCa
import TRETJapanNFCReader_FeliCa_TransitIC

class BattleReadyViewController: UIViewController, UIGestureRecognizerDelegate, FeliCaReaderSessionDelegate {
    
    var reader: TransitICReader!
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var firstCardView: UIView!
    @IBOutlet var secondCardView: UIView!
    
    var isFrstCardReading: Bool = false;
    var firstCardInfo: CardInfo?
    var secondCardInfo: CardInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reader = TransitICReader(delegate: self)
        
        let firstGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(BattleReadyViewController.firstCardTap(_:))
        )
        let secondGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(BattleReadyViewController.secondCardTap(_:))
        )
        
        firstGesture.delegate = self
        secondGesture.delegate = self
        
        firstCardView.addGestureRecognizer(firstGesture)
        secondCardView.addGestureRecognizer(secondGesture)
    }
    
    @objc func firstCardTap(_ sender: UITapGestureRecognizer) {
        // タップ終了時
        if sender.state == .ended {
            isFrstCardReading = true
            self.reader.get(itemTypes: [.balance, .entryExitInformations, .transactions])
        }
    }

    @objc func secondCardTap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            isFrstCardReading = false
            self.reader.get(itemTypes: [.balance, .entryExitInformations, .transactions])
        }
    }
    
    func feliCaReaderSession(didRead feliCaCardData: TRETJapanNFCReader_FeliCa.FeliCaCardData, pollingErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : Error?]?, readErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : [TRETJapanNFCReader_FeliCa.FeliCaServiceCode : Error]]?) {
        let card = feliCaCardData as! TransitICCardData
        
        if (isFirstResponder) {
            firstCardInfo = CardInfo().fromCardData(cardData: card)
        } else {
            secondCardInfo = CardInfo().fromCardData(cardData: card)
        }
        
        if (firstCardInfo != nil && secondCardInfo != nil) {
            startButton.tintColor = UIColor(hexString: "#9165F5")
            startButton.setTitle("Ready Fight", for: .normal)
            startButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func onStartGame() {
        if (firstCardInfo == nil && secondCardInfo == nil) {
            // Toastかなんかで表示したい
            print("カードを登録してください")
            return
        }
        
    }
    
    // 読み取りエラー処理
    func feliCaReaderSession(didInvalidateWithError pollingErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : Error?]?, readErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : [TRETJapanNFCReader_FeliCa.FeliCaServiceCode : Error]]?) {
    }
    
    // 読み取りエラー処理
    func japanNFCReaderSession(didInvalidateWithError error: Error) {
        print(error)
    }
}
