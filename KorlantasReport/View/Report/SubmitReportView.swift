//
//  SubmitReportView.swift
//  KorlantasReportIOS
//
//  Created by MacBook Pro on 24/04/23.
//

import AlertToast
import SwiftUI
import PhotosUI

struct SubmitReportView: View {
    @EnvironmentObject var reportViewModel: ReportViewModel
        @State private var showToast = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
//    @State var width: CGFloat
//    var user: User
    @State private var judul: String = ""
    @State private var isiLaporan: String = ""
    @State private var tanggalkejadian = Date.now
    var body: some View {
        VStack{
            NavigationStack {
                //                List {
                ScrollView{
                    Text("Add a Report")
                        .customFont(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                        .padding([.top])
                        .foregroundColor(Color(hex: "002C5F"))
                    VStack(){
                        Group {
                            Text("Report Title")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            TextField(
                                "Masukkan Judul Report",
                                text: $judul
                            )
                            .padding()
                            .disableAutocorrection(true)
                        }
                        Group {
                            Text("Tanggal dan Waktu Kejadian")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            
                            DatePicker(selection: $tanggalkejadian, in: ...Date.now, displayedComponents: .date){
                                Text("\(tanggalkejadian.formatted(date: .long, time: .omitted))")
                            }.padding()
                            
                        }
                        Group {
                            Text("Laporan /  Keluhan")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            TextField(
                                "Ceritakan Laporan / Keluhan Anda",
                                text: $isiLaporan
                            )
                            .padding()
                            .disableAutocorrection(true)
                        }
                        Group{
                            Text("Gambar")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()) {
                                    Text("Buka Galeri")
                                }
                                .onChange(of: selectedItem) { newItem in
                                    Task {
                                        // Retrieve selected asset in the form of Data
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                        }
                                    }
                                }
                            
                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                            }else{
                                Image("defaultprofile")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            }
                        }
                        .padding(.bottom)
                        Group {
                            Button("Submit"){
//                            NavigationLink(destination:  MainView()) {
//                                Text("Submit")
                                showToast.toggle()
                            }
                            .buttonStyle(BlueButton())
                        }
                        
                    }.padding()
                        .textFieldStyle(.roundedBorder
                        )
                    Spacer()        }
            }.toast(isPresenting: $showToast){
                                AlertToast(type: .regular, title: "added")
                            }
            //            }
            .scrollContentBackground(.hidden)
            
            .listRowSeparator(.hidden)
        }
        
    }
}


struct SubmitReportView_Previews: PreviewProvider {
    static var previews: some View {
//        SubmitReportView(isAddViewMovie: .constant(true))
        SubmitReportView()
    }
}
