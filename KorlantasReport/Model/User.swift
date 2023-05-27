//
//  User.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

import Foundation

struct User : Identifiable, Codable {
    let id: Int
    var username: String
    var name: String
    var tanggallahir: String
    var no_ktp: String
    var telp: String
    var profile_pic: String
    var password: String
    var role: String
    var status: String
    
    init(username: String, name: String, tanggallahir: String, no_ktp: String, telp: String, profile_pic: String, password: String, role: String, status: String) {
        id = 1
        self.username = username
        self.name = name
        self.tanggallahir = tanggallahir
        self.no_ktp = no_ktp
        self.telp = telp
        self.profile_pic = profile_pic
        self.password = password
        self.role = role
        self.status = status
    }
}

extension User {
    static let sampleUser: User =
    User(
        username: "testuser",
        name: "Test User",
        tanggallahir: "2000-08-17",
        no_ktp: "0123456789123123",
        telp: "081212341234",
        profile_pic: "",
        password: "asassa",
        role: "User",
        status: "1")
}

