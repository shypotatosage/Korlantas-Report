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
    @State private var newReport = Report.emptyReport
    @EnvironmentObject var reportViewModel: ReportViewModel
    
        @State private var showToast = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
//    @State var width: CGFloat
//    var user: User
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var reportContent: String = ""
    @State private var dateHappen = Date.now
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
                            Text("Judul Laporan")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            TextField(
                                "Masukkan Judul Report",
                                text: $newReport.title
                            )
                            .padding()
                            .disableAutocorrection(true)
                        }
                        Group {
                            Text("Lokasi Kejadian")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            TextField(
                                "Masukkan Lokasi Kejadian",
                                text: $newReport.location
                            )
                            .padding()
                            .disableAutocorrection(true)
                            Text("Lokasi Kejadian Tidak Boleh Kosong")
                        }
                        Group {
                            Text("Tanggal dan Waktu Kejadian")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            
                            DatePicker(selection: $dateHappen, in: ...Date.now, displayedComponents: .date){
                                Text("\(dateHappen.formatted(date: .long, time: .omitted))")
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
                                text: $newReport.description
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
//                          Add image from Galery
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
                                ZStack{
                                    Rectangle()
                                                   .fill(.gray)
                                                    .frame(width: 250, height: 150)
                                    VStack{
                                        Text("Add Image")
                                        Image(systemName: "plus.app")
                                    }
                                }
//                                Image("defaultprofile")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 150, height: 150)
                            }
                        }
                        .padding(.bottom)
                        Group {
                            Button("Submit"){
//                            NavigationLink(destination:  MainView()) {
//                                Text("Submit")
                                reportViewModel.submitReport(title: newReport.title, location: newReport.location, datetime: newReport.datetime, description: newReport.description, image: newReport.image)
                                showToast.toggle()
                            }
                            .buttonStyle(BlueButton())
//                            .disabled(title.isEmpty || location.isEmpty || reportContent.isEmpty)
                        }
                        
                    }.padding()
                        .textFieldStyle(.roundedBorder
                        )
                    Spacer()        }
//          Alert when report submitted
            }.toast(isPresenting: $showToast){
                AlertToast(type: .regular, title: "Laporan telah diterima dan akan segera diproses")
                            }
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
