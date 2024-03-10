//
//  CardListViewController.swift
//  ICButler
//
//  Created by Haruma Ito on 2024/03/05.
//

import UIKit

class BattleReadyViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet var topCardView: UIView!
    @IBOutlet var bottomCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(BattleReadyViewController.topCardTap(_:))
        )
        let bottomGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(BattleReadyViewController.bottomCardTap(_:))
        )
        
        tapGesture.delegate = self
        bottomGesture.delegate = self
        
        topCardView.addGestureRecognizer(tapGesture)
        bottomCardView.addGestureRecognizer(bottomGesture)
    }
    
    @objc func topCardTap(_ sender: UITapGestureRecognizer) {
        // タップ終了時
        if sender.state == .ended {
            
        }
    }
            
    @objc func bottomCardTap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            
        }
    }
}
