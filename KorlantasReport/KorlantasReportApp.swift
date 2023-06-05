//
//  KorlantasReportApp.swift
//  KorlantasReport
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

@main
struct KorlantasReportApp: App {
    @StateObject private var submitReportViewModel = SubmitReportViewModel()
    var body: some Scene {
        WindowGroup {
            SubmitReportView().environmentObject(submitReportViewModel)
        }
    }
}
