//
//  SwiftUIMatchView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/16.
//

import SwiftUI

struct MatchView: View {
    
    @ObservedObject private var viewModel: MatchViewModel
    
    init(_ viewModel: MatchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(String(format: "SummaryTitle".localized(), viewModel.state.gamePlayCount))
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 8)
            
            let winRate = viewModel.state.winRate
            Text(String(format: "GameScore".localized(), winRate.wins, winRate.losses))
                .font(.appleSDGothicNeo(ofSize: 10))
                .foregroundColor(.coolGrey)
            Spacer(minLength: 2)
            
            let kda = viewModel.state.kda
            Group {
                Text(String(format: "%.1f", kda.kill))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.charcoalGrey) +
                
                Text(" / ")
                    .font(.appleSDGothicNeo(ofSize: 14))
                    .foregroundColor(.charcoalGrey) +
                
                Text(String(format: "%.1f", kda.death))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.darkishPink) +
                
                Text(" / ")
                    .font(.appleSDGothicNeo(ofSize: 14))
                    .foregroundColor(.charcoalGrey) +
                
                Text(String(format: "%.1f", kda.assist))
                    .font(.system(size: 14))
                    .bold()
                    .foregroundColor(.charcoalGrey)
            }
            Spacer(minLength: 2)
            
            Group {
                Text(String(format: "%.2f:1", kda.rate))
                    .font(.system(size: 10))
                    .foregroundColor(kda.rateColor) +
                
                Text(" (\(winRate.rate)%)")
                    .font(.system(size: 10))
                    .foregroundColor(winRate.rateColor)
            }
        }
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(MatchViewModel())
    }
}
