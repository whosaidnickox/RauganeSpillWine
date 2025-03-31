//
//  EvhuisemcsView.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import SwiftUI
import Lottie


struct EvhuisemcsView: View {
    @State var ijukseti: Bool = false
    var body: some View {
        ZStack {
            Image("greyushkacol")
                .resizable()
                .ignoresSafeArea()
            
            if !self.ijukseti {
                LottieView(animation: .named("wpolskw"))
                    .playing(loopMode: .loop)
                 
                    .resizable()
                    .frame(width: 200, height: 150)
            }
            
            WKWebViewRepresentable(url: URL(string: "https://freepolicyourgheim.xyz/red/game/spill-wine/")!) {
                self.ijukseti = true
                let strakg = UIImpactFeedbackGenerator(style: .heavy)
                strakg.impactOccurred()
            }
            .mask {
                Rectangle()
                    .padding(20)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: ParagLeg())
    }
}
