//
//  Parser.swift
//  JPMC_Pratik
//
//  Created by Pratik Patil on 20/05/23.
//

import Foundation

struct Parser {
    static let shared = Parser()
    
//    Parsing the data from server
    func parseData(completion : @escaping (()->Void)) {
        guard let apiURL = URL(string: "https://swapi.dev/api/planets/") else {return}
        
        var urlRequest = URLRequest(url: apiURL)
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: apiURL, completionHandler: { data, response, error -> Void in
            debugPrint("Response from server is: \(response)")
            
            guard let receivedData = data else {return}
            do {
                let model = try JSONDecoder().decode(APIResponse<[PlanetServerModel]>.self, from: receivedData)
                model.results.forEach{$0.store()}
                completion()
            }
            catch {
                print(error)
                completion()
            }
        })
        task.resume()
    }
}

// Struct to convert api model into core data model with codable automization
public struct APIResponse<T: Codable> : Codable {
    public let count: Int
    public let next : String
    public let results : T
}
