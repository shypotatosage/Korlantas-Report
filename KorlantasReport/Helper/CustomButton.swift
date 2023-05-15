//
//  CustomButton.swift
//  KorlantasReportIOS
//
//  Created by MacBook Pro on 01/05/23.
//

import SwiftUI

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .foregroundColor(.white)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .cornerRadius(25)
            .frame(width: 300, height: 100)
    }
}
