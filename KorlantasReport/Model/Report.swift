//
//  Report.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

import Foundation


struct Report: Codable {
    var title: String
    var location: String
    var datetime: String
    var description: String
    var image: String
    var status: String
    var user: User
    
    init(title: String, location: String, datetime: String, description: String, image: String, status: String, user: User) {
        self.title = title
        self.location = location
        self.datetime = datetime
        self.description = description
        self.image = image
        self.status = status
        self.user = user
    }
}

extension Report{
    static var emptyReport: Report {
        Report(title: "", location: "",datetime: "",description: "",image: "",status: "",user: User(username: "", name: "", tanggallahir: "", no_ktp: "", telp: "", profile_pic: "", password: "", role: "", status: ""))
    }
}

extension Report{
    static let sampleReport: [Report] = [
        Report(
            title: "Pencurian Sepeda Motor / Begal",
            location: "Jalan Mulyosari 1 No 147, Surabaya, Indonesia",
            datetime: "Senin, 22 Mei 2023 ",
            description: "Pembegal bertato",
            image: "defaultreport",
            status: "Pending",
            user: User(username: "Marsha", name: "", tanggallahir: "", no_ktp: "", telp: "", profile_pic: "", password: "", role: "", status: "")
        ),
        Report(
            title: "Pembunuhan",
            location: "Jalan Mulyosari 1 No 147, Surabaya, Indonesia",
            datetime: "Senin, 22 Mei 2023 ",
            description: "Pembegal bertato",
            image: "defaultreport",
            status: "Pending",
            user: User(username: "Marsha", name: "", tanggallahir: "", no_ktp: "", telp: "", profile_pic: "", password: "", role: "", status: "")
        ),
        Report(
            title: "Penganiayaan",
            location: "Jalan Mulyosari 1 No 147, Surabaya, Indonesia",
            datetime: "Senin, 22 Mei 2023 ",
            description: "Pembegal bertato",
            image: "defaultreport",
            status: "Pending",
            user: User(username: "Marsha", name: "", tanggallahir: "", no_ktp: "", telp: "", profile_pic: "", password: "", role: "", status: "")
        )
    ]
    
}

