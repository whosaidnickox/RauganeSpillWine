//
//  ParagLeg.swift
//  RauganeSpillWine
//
//  Created by Nicolae Chivriga on 31/03/2025.
//

import SwiftUI


struct ParagLeg: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button {
            self.dismiss()
        } label: {
            Image("mnilg")
        }

    }
}
