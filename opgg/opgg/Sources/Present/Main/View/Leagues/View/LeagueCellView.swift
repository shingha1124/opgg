//
//  SwiftUILeagueCellView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct LeagueCellView: View {
    
    @ObservedObject private var viewModel: LeagueCellViewModel
    
    init(_ viewModel: LeagueCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.state.tier.imageURL) { $0.resizable() } placeholder: { Color.paleGrey2 }
            .frame(width: 64, height: 64, alignment: .topLeading)
            .offset(x: 12, y: 0)
            
            VStack(alignment: .leading) {
                Text("\(viewModel.state.tier.rankType.text)")
                    .font(.appleSDGothicNeo(ofSize: 12))
                    .foregroundColor(.softBlue)
                
                Text("\(viewModel.state.tier.tier)")
                    .font(.system(size: 18))
                    .foregroundColor(.darkgrey)
                    .bold()
                
                let lp = viewModel.state.tier.lp.currency()
                Text("\(lp) LP")
                    .font(.appleSDGothicNeo(ofSize: 12))
                
                HStack(spacing: 3) {
                    let matchRecord = viewModel.state.matchRecord
                    Text("\(matchRecord.wins)승 \(matchRecord.losses)패")
                        .font(.system(size: 10))
                        .foregroundColor(.steelGrey)
                    
                    Text("(\(matchRecord.winRate)%)")
                        .font(.system(size: 10))
                        .foregroundColor(.steelGrey)
                }
            }
            .offset(x: 8, y: 0)
            Spacer()
        }
        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .shadow(color: .steelGrey.opacity(0.2), radius: 6, x: 0, y: 4)
        .visibility(viewModel.state.visibility)
    }
}

struct LeagueCellView_Previews: PreviewProvider {
    static var previews: some View {
        LeagueCellView(LeagueCellViewModel(0))
    }
}
