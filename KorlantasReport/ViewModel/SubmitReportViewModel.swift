//
//  ReportViewModel.swift
//  KorlantasReport
//
//  Created by Marsha Likorawung  on 15/05/23.
//

import Foundation

let postURL = "http://127.0.0.1:8000/api/submit-report"

class SubmitReportViewModel: ObservableObject {
    @Published var reports: [Report] = []

    func submitReport(title: String, location: String, datetime: String, description: String, image: Data, imageExist: Bool) {
        if (!imageExist) {
            let url = URL(string: postURL)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let json: [String: Any] = ["title": title, "location":location, "datetime": datetime, "description": description, "user_id": User.sampleUser.id]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error?.localizedDescription ?? "No data")
                        return
                    }
                    
                    let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let responseJSON = responseJSON as? [String: Any] {
                        print(responseJSON)
                    }
                    print(response!)
                }
                task.resume()
            } catch {
                print(error.localizedDescription)
            }
        } else {
            var multipart = MultipartRequest()
            
            let json: [String: String] = ["title": title, "location":location, "datetime":datetime,"description": description, "user_id": String(User.sampleUser.id)]
            
            for field in json {
                multipart.add(key: field.key, value: field.value)
            }
            
            multipart.add(
                key: "picture",
                fileName: "pic.jpg",
                fileMimeType: "image/png",
                fileData: image
            )
            
            let url = URL(string: postURL)!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = multipart.httpBody
            request.setValue(multipart.httpContentTypeHeaderValue, forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
                
                let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                }
                print(response!)
            }
            task.resume()
        }
    }
}

public extension Data {
    
    mutating func append(
        _ string: String,
        encoding: String.Encoding = .utf8
    ) {
        guard let data = string.data(using: encoding) else {
            return
        }
        append(data)
    }
}

public struct MultipartRequest {
    
    public let boundary: String
    
    private let separator: String = "\r\n"
    private var data: Data
    
    public init(boundary: String = UUID().uuidString) {
        self.boundary = boundary
        self.data = .init()
    }
    
    private mutating func appendBoundarySeparator() {
        data.append("--\(boundary)\(separator)")
    }
    
    private mutating func appendSeparator() {
        data.append(separator)
    }
    
    private func disposition(_ key: String) -> String {
        "Content-Disposition: form-data; name=\"\(key)\""
    }
    
    public mutating func add(
        key: String,
        value: String
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + separator)
        appendSeparator()
        data.append(value + separator)
    }
    
    public mutating func add(
        key: String,
        fileName: String,
        fileMimeType: String,
        fileData: Data
    ) {
        appendBoundarySeparator()
        data.append(disposition(key) + "; filename=\"\(fileName)\"" + separator)
        data.append("Content-Type: \(fileMimeType)" + separator + separator)
        data.append(fileData)
        appendSeparator()
    }
    
    public var httpContentTypeHeaderValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }
    
    public var httpBody: Data {
        var bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData
    }
}
