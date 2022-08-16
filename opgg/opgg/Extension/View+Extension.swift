//
//  View+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

extension View {
    @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
        if visibility != .gone {
            if visibility == .visible {
                self
            } else {
                hidden()
            }
        }
    }
}

enum ViewVisibility: CaseIterable {
    case visible, invisible, gone
}
