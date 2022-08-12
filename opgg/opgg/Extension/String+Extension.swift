//
//  String+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        NSLocalizedString(self, comment: comment)
    }
}
