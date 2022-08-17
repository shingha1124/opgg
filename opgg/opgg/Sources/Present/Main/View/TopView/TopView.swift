//
//  SwiftUIMatchView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/14.
//

import SwiftUI

struct TopView: View {
    
    @ObservedObject private var viewModel: TopViewModel
    
    init(_ viewModel: TopViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 16 ) {
            AsyncImage(url: viewModel.state.profileImageURL) { $0.resizable() } placeholder: { Color.paleGrey2 }
            .frame(width: 88, height: 88, alignment: .topLeading)
            .clipShape(Capsule())
            .overlay(
                Text("\(viewModel.state.level)")
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                    .background(Color.darkgrey)
                    .foregroundColor(.white)
                    .clipShape(Capsule()), alignment: .bottomTrailing
            )
            
            VStack(alignment: .leading) {
                Text("OPGG")
                    .font(.system(size: 24))
                    .bold()
                Spacer()
                Button(action: {
                    viewModel.action.update.accept(())
                }, label: {
                    Text("Update".localized())
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 11, leading: 20, bottom: 11, trailing: 20))
                })
                .background(Color.softBlue)
                .clipShape(Capsule())
            }
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 0))
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView(TopViewModel())
            .frame(width: nil, height: 88 + 48)
    }
}
