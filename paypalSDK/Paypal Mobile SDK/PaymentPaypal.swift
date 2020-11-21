//
//  paymentPaypal.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import Foundation

enum PaymentEnvironment:String{
    case mockup
    case sandbox
    case live
}

class PaymentPaypal{
    
    static let shared = PaymentPaypal()
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    var items:[paymentItem] = []
    var delegate:PayPalPaymentDelegate!
    var delegateFuture:PayPalFuturePaymentDelegate!
    
    var environment:String = PayPalEnvironmentNoNetwork {
      willSet(newEnvironment) {
        if (newEnvironment != environment) {
          PayPalMobile.preconnect(withEnvironment: newEnvironment)
        }
      }
    }
    
    func setupEnvironment(environment:PaymentEnvironment){
        self.environment = environment.rawValue
    }
    
    func paypalConfigSetting(){
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        
        payPalConfig.payPalShippingAddressOption = .payPal;
        
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
    }
    
    func preconnectingEnvironment(){
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    func settingProductDetails()->PayPalPayment{
        // Optional: include multiple items
        let currencyCode = "USD"
        var paypalItems:[PayPalItem] = []
        self.items.forEach { (singleItem) in
            let item = paypalItem(name: singleItem.name, quantity: singleItem.quantity, price: singleItem.price, currency: singleItem.currency, sku: singleItem.sku)
            paypalItems.append(item)
        }
        let subtotal = PayPalItem.totalPrice(forItems: paypalItems)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "5.99")
        let tax = NSDecimalNumber(string: "2.50")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: currencyCode, shortDescription: "Hipster Clothing", intent: .order)
        
        payment.items = paypalItems
        payment.paymentDetails = paymentDetails
        return payment
    }
    
    func paypalItem(name:String,quantity:UInt,price:String,currency:String,sku:String) -> PayPalItem{
        return PayPalItem(name: name, withQuantity: quantity, withPrice: NSDecimalNumber(string: price), withCurrency: currency, withSku: currency)
    }
    func processPayment(nav:UINavigationController){
        
        debugPrint("item")
        let payment = settingProductDetails()
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: delegate)
            nav.present(paymentViewController!, animated: true, completion: nil)
//          present(paymentViewController!, animated: true, completion: nil)
        }
        else {
          // This particular payment will always be processable. If, for
          // example, the amount was negative or the shortDescription was
          // empty, this payment wouldn't be processable, and you'd want
          // to handle that here.
          print("Payment not processalbe: \(payment)")
        }
    }
    
    func futurePayment(nav:UINavigationController){
        let futurePaymentViewController = PayPalFuturePaymentViewController(configuration: payPalConfig, delegate: delegateFuture)
        nav.present(futurePaymentViewController!, animated: true, completion: nil)
    }
    
}

struct paymentItem{
    
    var name:String
    var quantity:UInt
    var price:String
    var currency:String
    var sku:String
    init(name:String,quantity:UInt,price:String,currency:String,sku:String){
        self.name = name
        self.quantity = quantity
        self.price = price
        self.currency = currency
        self.sku = sku
    }
}
