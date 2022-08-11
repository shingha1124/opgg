//
//  MainViewController.swift
//  opgg
//
//  Created by seongha shin on 2022/08/11.
//

import RxAppState
import RxSwift
import UIKit

final class MainViewController: BaseViewController, View {
    
    var disposeBag = DisposeBag()
    
    func bind(to viewModel: MainViewModel) {
        rx.viewDidLoad
            .bind(to: viewModel.action.tappedMatchs)
            .disposed(by: disposeBag)
    }
}
