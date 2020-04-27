//
//  APIRequest.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 8.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import Foundation

class APIRequest {
    private let endpoint = "https://cleaner-app-api.azurewebsites.net/api/hospital0"
    private let getRoomsString = "/rooms"
    private let getRoomString = "/room/"
    private let getHeatmapString = "/heatmap"
    private let getReportString = "/reports"
    private let putStartCleaningString = "/startcleaning"
    private let putStopCleaningString = "/stopcleaning"
    private let postReportString = "/report"
    private let API_KEY = "zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw"
    
    func getRoom(roomID: String, completion: @escaping (Result<Room,Error>) -> Void) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID) else { return }
        doGETRequest(url: url, completion: completion)
    }
    
    func getRooms(completion: @escaping (Result<Rooms, Error>) -> Void) throws {
        guard let url = URL(string: endpoint+getRoomsString) else { return }
        doGETRequest(url: url, completion: completion)
    }
    
    func getReports(completion: @escaping (Result<Reports, Error>) -> Void) throws {
        guard let url = URL(string: endpoint+getReportString) else { return }
        doGETRequest(url: url, completion: completion)
    }
    
    func getHeatmap(roomID: String, completionHandler: @escaping (_ contentLength: UInt64?) -> ()) throws {
    guard let url = URL(string: endpoint+getRoomString+roomID+getHeatmapString) else { return }
    doGETRequestHeatMap(for: url, completionHandler: completionHandler)
    }
    
    func putStartCleaning(roomID: String) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID+putStartCleaningString) else { return }
        doPUTRequest(url: url)
    }
    
    func putStopCleaning(roomID: String) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID+putStopCleaningString) else { return }
        doPUTRequest(url: url)
    }
    
    func postReport(report: Report) throws {
        guard let url = URL(string: endpoint+postReportString) else { print("Error in postReport API");return }
        doPostRequest(url: url, report: report)
    }
    
    // For PUT requests
    private func doPUTRequest(url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        // Auth
        request.setValue(API_KEY, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            // Read status code
            if let response = response as? HTTPURLResponse {
                print("GET request response status code: \(response.statusCode)")
            }
        }
        task.resume()
    }
    
    // For POST requests
    private func doPostRequest(url: URL, report: Report) {
        do {
            var request = URLRequest(url: url)
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            // Auth
            request.setValue(API_KEY, forHTTPHeaderField: "Authorization")
            request.httpBody = try encoder.encode(report)
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                
                
                // Check for errors
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Read status code
                if let response = response as? HTTPURLResponse {
                    print("POST request response status code: \(response.statusCode)")
                }
            }
            task.resume()
        }
        catch {
            print("Error posting to API")
        }
    }
    
    // For GET requests
    private func doGETRequest<T:Decodable>(url: URL, completion: @escaping (Result<T,Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //with authorization
        request.setValue(API_KEY, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for errors
            if let error = error {
                print("Error: \(error)")
                completion(.failure(error))
                return
            }
            
            // Read status code
            if let response = response as? HTTPURLResponse {
                print("GET request response status code: \(response.statusCode)")
            }
            
            // Read data
            if let data = data {
                let decoder = JSONDecoder()
                do{
                    let nesData = try decoder.decode(T.self, from: data)
                    completion(.success(nesData))
               }catch {
                completion(.failure(error))}
                }
        }
        task.resume()
    }
    
    
        // For heatmap GET request
    
        private func doGETRequestHeatMap(for url: URL, completionHandler: @escaping (_ contentLength: UInt64?) -> ()) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            //with authorization
            request.setValue(API_KEY, forHTTPHeaderField: "Authorization")
            //content-type
            request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
          
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                // Check for errors
                if let error = error {
                    print("Error: \(error)")

                    return
                }
                
                // Read status code
                if let response = response as? HTTPURLResponse {
                    //print("GET request response status code: \(response.statusCode)")
                    let contentLength = response.allHeaderFields["Content-Length"] as? String
                    completionHandler(UInt64(contentLength!))
                }
                
                // Read data
                 // Convert HTTP Response Data to a simple String
                   if let data = data, let dataString = String(data: data, encoding: .utf8) {
                       print("Response data string:\n \(dataString)")
                   }
            }
            task.resume()
        }
    }





