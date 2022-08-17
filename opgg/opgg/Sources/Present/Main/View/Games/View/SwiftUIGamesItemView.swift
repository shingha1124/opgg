//
//  SwiftUIGamesItemView.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

struct SwiftUIGamesItemView: View {
    
    @ObservedObject private var viewModel: SwiftUIGamesItemViewModel
    
    init(_ viewModel: SwiftUIGamesItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 0) {
            let game = viewModel.state.game
            VStack(alignment: .center, spacing: 6) {
                Spacer()
                Text(game.isWin ? "Wins".localized() : "Losses".localized())
                    .font(.appleSDGothicNeo(ofSize: 16))
                    .foregroundColor(.white)

                Rectangle()
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 16, height: 1)

                let playTimeMin = String(format: "%02d", game.gameLength / 60)
                let playTimeSec = String(format: "%02d", game.gameLength % 60)
                Text("\(playTimeMin):\(playTimeSec)")
                    .font(.appleSDGothicNeo(ofSize: 12))
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(width: 40)
            .background(game.isWin ? Color.softBlue : .darkishPink)

            VStack(alignment: .leading, spacing: 8) {
                GameSummonerView2(game: game)
                GameItemView2(items: viewModel.state.items, lastItem: viewModel.state.lastItem)
            }
            .padding(16)

            Spacer()
            VStack(alignment: .trailing) {
                Text(game.gameType.name)
                    .font(.appleSDGothicNeo(ofSize: 12))
                    .foregroundColor(.coolGrey)

                let (value, suffix) = game.createDateToValue
                HStack(spacing: 2) {
                    Text("\(value)")
                        .font(.appleSDGothicNeo(ofSize: 12))
                        .foregroundColor(.coolGrey)

                    Text("\(suffix)")
                        .font(.system(size: 12))
                        .foregroundColor(.coolGrey)
                }
                Spacer()

                let multiKill = game.stats.general.largestMultiKillString
                Text("\(multiKill.name)")
                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                    .font(.appleSDGothicNeo(ofSize: 10))
                    .foregroundColor(multiKill.color)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(multiKill.color, lineWidth: 1)
                    )
            }
            .padding(16)
        }
        .background(Color.white)
    }
}

//struct SwiftUIGamesItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        Game(
//        SwiftUIGamesItemView(SwiftUIGamesItemViewModel(0))
//    }
//}
