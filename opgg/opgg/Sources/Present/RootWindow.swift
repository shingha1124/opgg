//
//  RootWindow.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import Then
import UIKit

final class RootWindow: UIWindow {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.do {
            let viewModel = MainViewModel()
            let viewController = MainViewController()
            viewController.viewModel = viewModel
            $0.rootViewController = viewController
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
