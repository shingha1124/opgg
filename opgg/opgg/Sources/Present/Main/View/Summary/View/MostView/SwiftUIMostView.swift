//
//  SwiftUIMostView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUIMostView: View {
    
    @ObservedObject private var viewModel: SwiftUIMostViewModel
    
    init(_ viewModel: SwiftUIMostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Most Champion".localized())
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 8)
            HStack(spacing: 16) {
                ForEach(viewModel.state.viewModels, id: \.index) { model in
                    SwiftUIMostChampionView(model)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct SwiftUIMostView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMostView(SwiftUIMostViewModel())
    }
}
