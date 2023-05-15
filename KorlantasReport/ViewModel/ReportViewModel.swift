//
//  ReportViewModel.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

import Foundation

class ReportViewModel: ObservableObject{
    @Published var reports: [Report] = []
    
    private static func fileURL() throws -> URL{
        try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("reports.data")
    }
    
    func load() async throws{
        let report = Task<[Report], Error>{
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else{
                return []
            }
            let reports = try JSONDecoder().decode([Report].self, from: data)
            return reports
        }
        let reports = try await report.value
        self.reports = reports
    }
    
    func save(reports: [Report]) async throws{
        let report = Task{
            let data = try JSONEncoder().encode(reports)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        
        _ = try await report.value
    }
    
    func submitReport(title: String, location: String, datetime: String, description: String, image: String){
        reports.append(Report(title: title,location: location,datetime: datetime, description: description, image: image, status: "Pending", user: User.sampleUser))
        
    }
}


