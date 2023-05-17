//
//  CreateValidator.swift
//  KorlantasReport
//
//  Created by MacBook Pro on 18/05/23.
//

import Foundation

struct CreateValidator{
    func validate(_ report: Report) throws{
        if report.title.isEmpty{
            throw CreateValidatorError.emptyReportTitle
        }
        if report.location.isEmpty{
            throw CreateValidatorError.emptyReportLocation
        }
        if report.description.isEmpty{
            throw CreateValidatorError.emptyReportDescription
        }
        if report.datetime.isEmpty{
            throw CreateValidatorError.emptyReportDate
        }
        if report.image.isEmpty{
            throw CreateValidatorError.emptyReportImage
        }
    }
}

extension CreateValidator{
    enum CreateValidatorError: LocalizedError{
        case emptyReportTitle
        case emptyReportLocation
        case emptyReportDescription
        case emptyReportDate
        case emptyReportImage
    }
}

extension CreateValidator.CreateValidatorError{
    var errorDescription: String?{
        switch self{
        case .emptyReportTitle:
            return "Judul Laporan Tidak Boleh Kosong"
        case .emptyReportLocation:
            return "Lokasi Kejadian Tidak Boleh Kosong"
        case .emptyReportDescription:
            return "Deskripsi Kejadian Tidak Boleh Kosong"
        case .emptyReportDate:
            return "Tanggal Kejadian Tidak Boleh Kosong"
        case .emptyReportImage:
            return "Gambar Kejadian Tidak Boleh Kosong"
        }
    }
}


