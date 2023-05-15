//
//  RedButton.swift
//  KorlantasReportIOS
//
//  Created by MacBook Pro on 01/05/23.
//

import SwiftUI

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all)
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.horizontal)
            .background(Color(hex: "800000"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .customFont(.headline)
    }
}
