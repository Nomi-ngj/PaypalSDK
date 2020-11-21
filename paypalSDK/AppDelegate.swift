//
//  AppDelegate.swift
//  paypalSDK
//
//  Created by Nouman Gul on 21/11/2020.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //TODO: - Enter your credentials
        PayPalMobile.initializeWithClientIds(forEnvironments:[PayPalEnvironmentProduction: "AdSW4wsNixGTglfAncqG1ysIacgQmNJl5RsMUA9NbSEh24VjUA7Seu8yTfwqZ9g7pOHA14m4AEWV741m",PayPalEnvironmentSandbox: "AdSW4wsNixGTglfAncqG1ysIacgQmNJl5RsMUA9NbSEh24VjUA7Seu8yTfwqZ9g7pOHA14m4AEWV741m"])
        
        return true
    }


}

