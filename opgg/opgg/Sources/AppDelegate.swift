//
//  AppDelegate.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = RootWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        return true
    }
}
