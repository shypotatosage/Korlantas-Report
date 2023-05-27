//
//  KorlantasReportApp.swift
//  KorlantasReport
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

@main
struct KorlantasReportApp: App {
    @StateObject private var reportViewModel = ReportViewModel()
    var body: some Scene {
        WindowGroup {
            SubmitReportView().environmentObject(reportViewModel)
        }
    }
}
