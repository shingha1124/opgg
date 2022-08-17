//
//  GameSummonerView2.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

struct GameSummonerView2: View {
    @State var game: Game
    
    var body: some View {
        HStack {
            let general = game.stats.general
            ZStack {
                AsyncImage(url: game.champion.imageUrl) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 40, height: 40)
                .clipShape(Capsule())
                                
                Text(general.opScoreBadge.name)
                    .font(.system(size: 10))
                    .bold()
                    .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                    .foregroundColor(.white)
                    .background(general.opScoreBadge.color)
                    .clipShape(Capsule())
                    .visibility(general.opScoreBadge.name.isEmpty ? .gone : .visible)
                    .overlay(
                        Capsule()
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .offset(x: 0, y: 18)
            }
            
            Spacer().frame(width: 4)
            VStack(spacing: 2) {
                AsyncImage(url: game.spells[0].imageUrl) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 19, height: 19)
                .clipShape(RoundedRectangle(cornerRadius: 4))
                
                AsyncImage(url: game.spells[1].imageUrl) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 19, height: 19)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            Spacer().frame(width: 2)
            VStack(spacing: 2) {
                AsyncImage(url: game.peak[0]) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 19, height: 19)
                .clipShape(Capsule())
                
                AsyncImage(url: game.peak[1]) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 19, height: 19)
                .clipShape(Capsule())
            }
            
            let kda = GameKDA(general)
            Spacer().frame(width: 8)
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 0) {
                    Text("\(kda.kill)")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.darkgrey)
                    
                    Text(" / ")
                        .font(.system(size: 16))
                        .foregroundColor(.darkgrey)
                    
                    Text("\(kda.death)")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.darkishPink)
                    
                    Text(" / ")
                        .font(.system(size: 16))
                        .foregroundColor(.darkgrey)
                    
                    Text("\(kda.assist)")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(.darkgrey)
                    Spacer()
                }
                
                Text(String(format: "KillParticipate".localized(), general.contributionForKillRate))
                    .font(.system(size: 12))
                    .foregroundColor(.gunmetal)
            }
        }
    }
}

//struct GameSummonerView2_Previews: PreviewProvider {
//    static var previews: some View {
//        GameSummonerView2()
//    }
//}
