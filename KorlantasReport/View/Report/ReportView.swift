//
//  ReportView.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

//import SwiftUI
//
//struct ReportView: View {
//    @Binding var movies : [Movie]
//    @State private var isAddMovie = false
//    @Environment(\.scenePhase) private var scenePhase
//    let saveAction: ()->Void
//    var body: some View {
//        NavigationStack{
//            List(movies) { movie in
//                MovieCardView(movie: movie)
//            }
//
//                .navigationTitle("Movie List")
//                .toolbar{
//                    Button(action: {
//                        isAddMovie = true
//                    }){
//                        Image(systemName: "plus")
//                    }
//                }
//                .sheet(isPresented: $isAddMovie){
//                    MovieAddView(movie: $movies, isAddViewMovie: $isAddMovie)
//                }
//                .onChange(of: scenePhase){phase in
//                    if phase == .inactive {
//                        saveAction()
//                    }
//
//                }
//        }
//    }
//}
//
//struct ReportView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReportView()
//    }
//}
