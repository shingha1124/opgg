//
//  GameItemView2.swift
//  opgg
//
//  Created by seongha shin on 2022/08/17.
//

import SwiftUI

struct GameItemView: View {
    @State var items: [Item]
    @State var lastItem: Item?
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<6, id: \.self) { index in
                let item = items[optional: index]
                AsyncImage(url: item?.imageUrl) { $0.resizable() } placeholder: {
                    Color.paleGrey2
                }
                .frame(width: 24, height: 24)
                .background(
                    Rectangle()
                        .fill(Color.paleGrey2)
                )
                .clipShape(RoundedRectangle(cornerRadius: 4))
            }
            
            AsyncImage(url: lastItem?.imageUrl) { $0.resizable() } placeholder: {
                Color.paleGrey2
            }
            .frame(width: 24, height: 24)
            .clipShape(Capsule())
        }
    }
}

//struct GameItemView2_Previews: PreviewProvider {
//    static var previews: some View {
//        GameItemView2()
//    }
//}
