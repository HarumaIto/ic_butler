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
    @IBOutlet var firstLable: UILabel!
    @IBOutlet var secondLable: UILabel!
    
    var isFarstCardReading: Bool = false;
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBattleResult" {
            let next = segue.destination as? BattleResultViewController
            next?.firstCard = self.firstCardInfo
            next?.secondCard = self.secondCardInfo
        }
    }
    
    @objc func firstCardTap(_ sender: UITapGestureRecognizer) {
        // タップ終了時
        if sender.state == .ended {
            isFarstCardReading = true
            self.reader.get(itemTypes: [.balance, .entryExitInformations, .transactions])
        }
    }

    @objc func secondCardTap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            isFarstCardReading = false
            self.reader.get(itemTypes: [.balance, .entryExitInformations, .transactions])
        }
    }
    
    func feliCaReaderSession(didRead feliCaCardData: TRETJapanNFCReader_FeliCa.FeliCaCardData, pollingErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : Error?]?, readErrors: [TRETJapanNFCReader_FeliCa.FeliCaSystemCode : [TRETJapanNFCReader_FeliCa.FeliCaServiceCode : Error]]?) {
        let card = feliCaCardData as! TransitICCardData
        
        DispatchQueue.main.async {
            if (self.isFarstCardReading) {
                self.firstCardInfo = CardInfo().fromCardData(cardData: card)
                self.firstLable.text = "１つ目のカードを追加しました！！"
            } else {
                self.secondCardInfo = CardInfo().fromCardData(cardData: card)
                self.secondLable.text = "２つ目のカードを追加しました！！"
            }
            
            if (self.firstCardInfo != nil && self.secondCardInfo != nil) {
                self.startButton.backgroundColor = UIColor(hexString: "#9165F5")
                self.startButton.setTitle("Ready Fight", for: .normal)
                self.startButton.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    @IBAction func onStartGame() {
        if (firstCardInfo == nil && secondCardInfo == nil) {
            // Toastかなんかで表示したい
            print("カードを登録してください")
            return
        }
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "toBattleResult", sender: nil)
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
