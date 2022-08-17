//
//  SwiftUIMostView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct MostView: View {
    
    @ObservedObject private var viewModel: MostViewModel
    
    init(_ viewModel: MostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Most Champion".localized())
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 8)
            HStack(spacing: 16) {
                ForEach(viewModel.state.cellViewModels, id: \.index) { model in
                    MostChampionView(model)
                }
            }
        }
        .padding(.horizontal, 10)
    }
}

struct MostView_Previews: PreviewProvider {
    static var previews: some View {
        MostView(MostViewModel())
    }
}
