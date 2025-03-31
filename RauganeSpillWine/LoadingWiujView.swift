//
//  LoadingWiujView.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import Foundation
import SwiftUI
import Lottie


struct LoadingWiujView: View {
    @State var oshiuk: Bool = false
    var body: some View {
        ZStack {
            Image("greyushkacol")
                .resizable()
                .ignoresSafeArea()
            
            NavigationLink("",
                           destination: Jiukmenu(),
                           isActive: $oshiuk)
            LottieView(animation: .named("culoadi"))
                .playing(loopMode: .playOnce)
                .animationDidFinish({ completed in
                    let agelvib = UIImpactFeedbackGenerator(style: .rigid)
                    agelvib.impactOccurred()
                    self.oshiuk = true
                })
                .resizable()
                .frame(width: 200, height: 125)
            
        }
        .menfisdap()
        .onAppear() {
            print("sw")
        }
    }
}


