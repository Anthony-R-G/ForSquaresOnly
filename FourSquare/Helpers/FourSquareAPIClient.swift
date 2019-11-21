//
//  FourSquareAPIClient.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/18/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import Foundation

class FourSquareAPIClient {
    static let manager = FourSquareAPIClient()
    
    let clientSecret = "3OOKRE2BKKVWC0NITLQA2YXNDSCI0UXG4UMGV4ZHGOKVKRB0"
    
    let clientID = "UQB5TPYOAZLSRHOV2FJZWDKSPK3SBUPFHLHOOIGOSCKEZJBF"
    
    
    func getVenueData(query:String,lat: Double, long: Double,completionHandler:@escaping(Result<[Venue],AppError>)-> Void) {
        
        let url = "https://api.foursquare.com/v2/venues/search?client_id=\(clientID)&client_secret=\(clientSecret)&ll=\(lat),\(long)&query=\(query.lowercased())&v=20191118"
        
        guard let urlStr = URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        print(url)
        
        NetworkHelper.manager.performDataTask(withUrl: urlStr, andMethod: .get) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let venuesFromJSON = try JSONDecoder().decode(FourSquareVenues.self, from: data)
                    completionHandler(.success(venuesFromJSON.response.venues))
                } catch {
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}

