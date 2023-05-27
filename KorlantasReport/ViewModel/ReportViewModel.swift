//
//  ReportViewModel.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

import Foundation

let postURL = "http://127.0.0.1:8000/api/submit-report"

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
//        guard let url =  URL(string: postURL) else { return }
//        print(url)
        
        let encoder = JSONEncoder()
        
        let newReport = Report(title: title,location: location,datetime: datetime, description: description, image: image, status: "Pending", user: User.sampleUser)
print(newReport)
        // create post request
        let url = URL(string: postURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String: Any] = ["title": title, "location":location, "time":"2023-05-27 15:59:19","description": "2023-05-27 15:59:19", "picture":image,"user_id": User.sampleUser.id]
        print(json)
        do {
        var jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print(request)
//            print(jsonData!)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
                print(response)
            }

            task.resume()
        } catch {
            
            print(error.localizedDescription)
        }
//         jsonData = try! encoder.encode(jsonData)
//        var request = URLRequest(url: url)
  
//            reports.append(Report(title: title,location: location,datetime: datetime, description: description, image: image, status: "Pending", user: User.sampleUser))
    }
}


