//
//  AppDelegate.swift
//  hana-bank-test
//
//  Created by Dion Lamilga on 02/08/25.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dashboard = DashboardRouter().showView()
        let rootVC = UINavigationController(rootViewController: dashboard)
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        return true
    }
}

