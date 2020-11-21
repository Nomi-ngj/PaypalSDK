//
//  ViewController.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import UIKit



class ViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        PaymentPaypal.shared.setupEnvironment(environment: .sandbox)
        PaymentPaypal.shared.paypalConfigSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: PaymentPaypal.shared.environment)
    }
    
    // MARK: Future Payments
    @IBAction func authorizeFuturePaymentsAction(_ sender: AnyObject) {
        PaymentPaypal.shared.delegateFuture = self
        PaymentPaypal.shared.futurePayment(nav: self.navigationController!)
    }
    
    // MARK: Single Payment
    @IBAction func buyClothingAction(_ sender: AnyObject) {
        let item = paymentItem.init(name: "Old Jeans with holes", quantity: 1, price: "27.99", currency: "USD", sku: "Hip-00067")
        let item2 = paymentItem.init(name: "Free rainbow patch", quantity: 2, price: "99.99", currency: "USD", sku: "Hip-00067")
        let item3 = paymentItem.init(name: "Long-sleeve plaid shirt (mustache not included)", quantity: 1, price: "84.99", currency: "USD", sku: "Hip-00067")
        PaymentPaypal.shared.items = [item, item2, item3]
        PaymentPaypal.shared.delegate = self
        PaymentPaypal.shared.processPayment(nav: self.navigationController!)
    }
}

extension ViewController: PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
          // send completed confirmaion to your server
          print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            do{
                    let documentData = try JSONSerialization.data(withJSONObject: completedPayment.confirmation, options: [])
                    let documentObject = try JSONDecoder().decode(PaymentSucessResponse.self, from: documentData)
                    debugPrint(documentObject)
            }catch{
                debugPrint(error)
            }
            
        })
    }
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        futurePaymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable : Any]) {
        
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
          
        })
        
    }
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        profileSharingViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]) {
        print("PayPal Profile Sharing Authorization Success!")
        // send authorization to your server
        profileSharingViewController.dismiss(animated: true, completion: { () -> Void in
          
        })
    }

}
