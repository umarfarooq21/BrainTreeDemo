//
//  ViewController.swift
//  DemoBrainTree
//
//  Created by UMARFAROOQTV on 10/17/19.
//  Copyright © 2019 Umar Farooq. All rights reserved.
//

import UIKit
import Braintree

class ViewController: UIViewController {

    @IBOutlet weak var cardView: BTUICardFormView!
    
    
    
    @IBAction func scanCardTapped(_ sender: Any) {
        scanCard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cardView.theme = BTUI.braintreeTheme()
        cardView.optionalFields = .cvv
        
        self.title = "Add Credit Card"
        
    }
    
    func scanCard() {
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.modalPresentationStyle = .formSheet
        present(cardIOVC!, animated: true, completion: nil)
    }


}

extension ViewController: CardIOPaymentViewControllerDelegate {
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        
        if let info = cardInfo {
            let str = NSString(format: "Received card info.\n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv )

            if info.cardholderName != nil{
                str.appending("\n Name: \(String(describing: info.cardholderName))")
            }
            
            print(str)
            
            //Assigning to brain tree ui fields
            self.cardView.cvv = info.cvv
            self.cardView.setExpirationMonth(Int(info.expiryMonth), year: Int(info.expiryYear))
            self.cardView.number = info.cardNumber

        }

        paymentViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

