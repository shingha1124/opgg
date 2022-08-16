//
//  SwiftUIPositionView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct PositionView: View {
    
    @ObservedObject private var viewModel: PositionViewModel
    
    init(_ viewModel: PositionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Position".localized())
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 10)
            HStack(spacing: 16) {
                ForEach(viewModel.state.viewModels, id: \.index) { model in
                    PositionItemView(model)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct SwiftUIPositionView_Previews: PreviewProvider {
    static var previews: some View {
        PositionView(PositionViewModel())
    }
}
