//
//  IntrinsicTableView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

class IntrinsicTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        let number = numberOfRows(inSection: 0)
        var height: CGFloat = 0

        (0..<number).forEach {
            guard let cell = cellForRow(at: IndexPath(row: $0, section: 0)) else {
                return
            }
            height += cell.bounds.height
        }
        return CGSize(width: contentSize.width, height: height)
    }
}
