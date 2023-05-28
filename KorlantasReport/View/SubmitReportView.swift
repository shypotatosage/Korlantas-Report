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
    @State var isError = false
        @State private var showToast = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @State private var dateHappen = Date.now
    var body: some View {
        VStack{
            NavigationStack {
                ScrollView {
                    Text("Add a Report")
                        .customFont(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .listRowSeparator(.hidden)
                        .padding([.top])
                        .foregroundColor(Color(hex: "002C5F"))
                    VStack() {
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
                        if newReport.title.count > 255 {
                            Text("Maks. 255 karakter")
                                .foregroundColor(.red)
                        } else if isError == true && newReport.title.isEmpty {
                            Text("Judul Laporan Harus Diisi")
                                .foregroundColor(.red)
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
                        }
                        if newReport.location.count > 255 {
                            Text("Maks. 255 karakter")
                                .foregroundColor(.red)
                        } else if isError == true && newReport.location.isEmpty {
                            Text("Lokasi Kejadian Harus Diisi")
                                .foregroundColor(.red)
                        }
                        Group {
                            Text("Tanggal Kejadian")
                                .customFont(.title).foregroundColor(Color(hex: "002C5F"))
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: .zero,
                                    alignment:  .topLeading)
                                .padding()
                            
                            DatePicker(selection: $dateHappen, in: ...Date.now, displayedComponents: .date) {
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
                        if newReport.description.count > 500 {
                            Text("Maks. 500 karakter")
                                .foregroundColor(.red)
                        } else if isError == true  && newReport.description.isEmpty {
                            Text("Laporan Kejadian Harus Diisi")
                                .foregroundColor(.red)
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
                            } else {
                                ZStack{
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width: 250, height: 150)
                                    VStack{
                                        Text("Add Image")
                                        Image(systemName: "plus.app")
                                    }
                                }
                            }
                        }
                        .padding(.bottom)
                        Group {
                            Button("Submit") {
                                if (newReport.title.isEmpty || newReport.location.isEmpty || newReport.description.isEmpty) {
                                    isError = true
                                } else {
                                    newReport.datetime = dateHappen.description
                                    
                                    var imageStr = ""
                                    
                                    if (selectedImageData != nil) {
                                        let uiImage = UIImage(data: selectedImageData!)
                                        let imageData = uiImage!.jpegData( compressionQuality: 0.1) ?? Data()
                                        imageStr = imageData.base64EncodedString()
                                    }
                                    
                                    isError = false
                                    reportViewModel.submitReport(title: newReport.title, location: newReport.location, datetime: newReport.datetime, description: newReport.description, image: selectedImageData ?? Data())
                                    showToast.toggle()
                                }
                            }
                            .buttonStyle(BlueButton())
                        }
                        
                    }
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    Spacer()
                }
            }.toast(isPresenting: $showToast) {
                AlertToast(type: .regular, title: "Laporan telah diterima dan akan segera diproses \(newReport.datetime)")
                            }
            .scrollContentBackground(.hidden)
            
            .listRowSeparator(.hidden)
        }
        
    }
}


struct SubmitReportView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitReportView()
    }
}
