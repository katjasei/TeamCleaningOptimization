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
    private let getReportString = "/reports"
    private let putStartCleaningString = "/startcleaning"
    private let putStopCleaningString = "/stopcleaning"
    private let API_KEY = "zL43mXgXk5xa7YFRBVZscbLnGFaqVh24q5G6fhGjmAv532FAVBRtnuCJpwXWXnhw"
    
    func getRoom(roomID: String, completion: @escaping (Result<Room,Error>) -> Void) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID) else { return }
        print("URL: \(url)")
        doRequest(url: url, type: .getRoom, completion: completion)
    }
    
    func getRooms() throws {
        guard let url = URL(string: endpoint+getRoomsString) else { return }
        print("URL: \(url)")
        //doRequest(url: url, type: .getRooms)
    }
    
    func getReport() throws {
        guard let url = URL(string: endpoint+getReportString) else { return }
        print("URL: \(url)")
        //doRequest(url: url, type: .getReport)
    }
    
    func putStartCleaning(roomID: String) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID+putStartCleaningString) else { return }
        print("URL: \(url)")
       // doRequest(url: url, type: .put)
    }
    
    func putStopCleaning(roomID: String) throws {
        guard let url = URL(string: endpoint+getRoomString+roomID+putStopCleaningString) else { return }
        print("URL: \(url)")
      //  doRequest(url: url, type: .put)
    }
    
    // For all empty body requests (GET & PUT)
    private func doRequest<T:Decodable>(url: URL, type: APIType, completion: @escaping (Result<T,Error>) -> Void) {
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
                print("Response status code: \(response.statusCode)")
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
    
}

enum APIType {
    // For different kinds of response parsing (no response in either PUT)
    case getRooms, getRoom, getReport, put
}
