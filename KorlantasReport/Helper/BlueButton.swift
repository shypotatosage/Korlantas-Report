//
//  BlueButton.swift
//  KorlantasReportIOS
//
//  Created by Marsha Likorawung  on 23/04/23.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.all)
            .padding(.horizontal)
            .padding(.horizontal)
            .padding(.horizontal)
            .background(Color(hex: "002C5F"))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .customFont(.headline)
    }
}

