//
//  ScrollView+Extension.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

extension ScrollView {
    func onScrolledToBottom(perform action: @escaping() -> Void) -> some View {
        return ScrollView<LazyVStack> {
            LazyVStack {
                self.content
                Rectangle().size(.zero).onAppear {
                    action()
                }
            }
        }
    }
    
}
