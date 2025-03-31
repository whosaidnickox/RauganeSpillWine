//
//  SettingsContainerView.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import SwiftUI
import StoreKit

struct SettingsContainerView: View {
    @Environment(\.requestReview) private var requestReview
    var body: some View {
        ZStack {
            Image("greyushkacol")
                .resizable()
                .ignoresSafeArea()
            
            Image("setisc")
                .overlay {
                    VStack {
                        Button {
                            self.requestReview()
                        } label: {
                            Image("reitus")
                        }

                        Button {
                            self.sendEmail()
                        } label: {
                            Image("cntas")
                        }
                        
                    }
                }
        }
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: ParagLeg())
    }
    
    func sendEmail() {
         let subject = "Feedback"
         let body = "Hello, I have some feedback..."
         let email = "ngocbaphan2@gmail.com"
         
         if let url = URL(string: "mailto:\(email)?subject=\(subject)&body=\(body)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
             UIApplication.shared.open(url)
         }
     }
 
}
extension View {
    func menfisdap() -> some View {
        self.modifier(Gauwiosas())
    }
}
