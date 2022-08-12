//
//  IntrinsicTableView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

final class IntrinsicTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
      let height = self.contentSize.height + self.contentInset.top + self.contentInset.bottom
      return CGSize(width: self.contentSize.width, height: height)
    }
    
    override func layoutSubviews() {
      self.invalidateIntrinsicContentSize()
      super.layoutSubviews()
    }
}
