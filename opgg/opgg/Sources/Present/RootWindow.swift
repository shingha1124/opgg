//
//  RootWindow.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import RxAppState
import SwiftUI
import Then

final class RootWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.do {
            let mainView = MainView()
            let viewController = UIHostingController(rootView: mainView)
            $0.rootViewController = viewController
            $0.overrideUserInterfaceStyle = .light
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
