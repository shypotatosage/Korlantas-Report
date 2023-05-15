//
//  Navigation.swift
//  KorlantasReportIOS
//
//  Created by Marsha Likorawung  on 23/04/23.
//

//import SwiftUI
//
//struct Mainview: View {
//    @StateObject private var reportList = ReportViewModel()
//
////    var body: some View {
////        TabView{
////            Mainview(reports: $reportList.reports){
////                Task{
////                    do{
////                        try await reportList.save(reports: reportList.reports)
////                    }
////                    catch{
////                        fatalError(error.localizedDescription)
////                    }
////                }
////            }
////            .tabItem{
////                Label("", systemImage: "list.dash")
////            }
//
////            ProfileView().tabItem{
////                Label("Profile", systemImage: "person.2.badge.gearshape")
////            }
////        }.task {
////            do{
////                try await reportList.load()
////            }catch{
////                fatalError(error.localizedDescription)
////            }
////        }
////    }
//
//
//}
//
//
//struct Navigation_Previews: PreviewProvider {
//    static var previews: some View {
//        Mainview()
//    }
//}
//
