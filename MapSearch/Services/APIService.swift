//
//  APIService.swift
//  MapSearch
//
//  Created by Map04 on 2021-05-20.
//  Copyright © 2021 Apple. All rights reserved.
//
import Foundation

struct SearchResults: Codable {
    let total: Int
    let businesses: [Place]
}

public class APIService {
    static let shared = APIService()
    
    let urlString = "https://api.yelp.com/v3/businesses/search?"
    let apiKey = "a5MgdrNXC28IUY5bjsBxdCpXbfKbAqpEw4uAtqwzO5-DLpwUlbcr-I3Y9xsNX0T11YCqzXs8Mm3NnwvVM9PECjp_DicNKeigC9uhVIKsMpSZGrVU1fPAwGNIyLGnYHYx"
    
    func fetchBusinesses(matching query: [String: String], completion: @escaping([Place]?) -> Void) {
        let baseURL = URL(string: urlString)!
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries.")
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let searchResults = try? jsonDecoder.decode(SearchResults.self, from: data) {
                completion(searchResults.businesses)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                completion(nil)
            }
        }
        task.resume()
    }
}
