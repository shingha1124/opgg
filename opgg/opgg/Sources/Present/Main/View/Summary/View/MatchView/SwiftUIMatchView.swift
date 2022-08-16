//
//  SwiftUIMatchView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct SwiftUIMatchView: View {
    
    @ObservedObject private var viewModel: SwiftUIMatchViewModel
    
    init(_ viewModel: SwiftUIMatchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("최근 \(viewModel.state.gamePlayCount)게임 분석")
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 8)
            
            let matchRecord = viewModel.state.matchRecord
            Text("\(matchRecord.wins)승 \(matchRecord.losses)패")
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 2)
            
            let kda = viewModel.state.matchKDA
            HStack(spacing: 5) {
                Text(String(format: "%.1f", kda.kills))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.charcoalGrey)
                
                Text("/")
                    .font(.appleSDGothicNeo(ofSize: 14))
                    .foregroundColor(.charcoalGrey)
                    .foregroundColor(.charcoalGrey)
                
                Text(String(format: "%.1f", kda.deaths))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.darkishPink)
                
                Text("/")
                    .font(.appleSDGothicNeo(ofSize: 14))
                    .foregroundColor(.charcoalGrey)
                    .foregroundColor(.charcoalGrey)
                
                Text(String(format: "%.1f", kda.assists))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.charcoalGrey)
            }
            Spacer(minLength: 2)
            
            HStack(spacing: 3) {
                Text(String(format: "%.2f:1", kda.kdaRate))
                    .font(.system(size: 10))
                    .foregroundColor(kda.kdaRateColor)
                
                Text("(\(matchRecord.winRate)%)")
                    .font(.system(size: 10))
                    .foregroundColor(matchRecord.winRateColor)
            }
        }
    }
}

struct SwiftUIMatchView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIMatchView(SwiftUIMatchViewModel())
    }
}
