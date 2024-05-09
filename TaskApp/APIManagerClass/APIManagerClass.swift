//
//  APIManagerClass.swift
//  TaskApp
//
//  Created by MOHD SALEEM on 08/05/24.
//

import Foundation

class APIManagerClass{
    
    
    func callAPI() {
        // Create URL
        guard let url = URL(string: "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=100") else {
            print("Error: Invalid URL")
            return
        }
        
        // Create URLRequest
        var request = URLRequest(url: url)
        
        // Configure request
        request.httpMethod = "GET" // HTTP method
        // Add headers if needed
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Create URLSession
        let session = URLSession.shared
        
        // Create data task
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Handle response and errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error: Invalid status code: \(httpResponse.statusCode)")
                return
            }
            
            // Check if data is nil
            guard let responseData = data else {
                print("Error: No data received")
                return
            }
            
            // Parse JSON response if needed
            do {
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response: \(json)")
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        
        // Resume data task to initiate the API call
        dataTask.resume()
    }
}
