//
//  APIService.swift
//  Mixology
//
//  Created by Shashi Dev Shrestha on 2024-02-12.
//

import Foundation
import Combine

class ApiClient {
    static let shared = ApiClient()
    
    private let baseUrl = URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    private let session = URLSession.shared
    
    
    private enum Endpoint: String {
        case categoryList = "list.php?c=list"
        case filterByCategory = "filter.php?c="
        case idLookup = "lookup.php?i="

     }
    
    private enum ApiError: Error {
        case invalidData(description: String)
     }
     
    
    private func makeRequest<T: Decodable>(endpoint: Endpoint, filter: String?=nil, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlString = baseUrl.absoluteString + "/" + endpoint.rawValue
        
        if let filter = filter {
              urlString += filter
          }
        
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }

        session.dataTask(with: url) { data, response, error in
              guard let data = data, error == nil else {
                  if let error = error {
                      completion(.failure(error))
                  } else {
                      completion(.failure(ApiError.invalidData(description: "Invalid Data")))
                  }
                  return
              }
              
              do {
                  let decodedData = try JSONDecoder().decode(T.self, from: data)
                  completion(.success(decodedData))
              } catch {
                  completion(.failure(error))
              }
          }.resume()
      }
    
    func fetchCategoryListData<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) {
        makeRequest(endpoint: .categoryList) { result in
            completion(result)
        }
    }
    
    func filterByCateogry<T: Decodable>(filter : String, completion: @escaping (Result<T, Error>) -> Void) {
        makeRequest(endpoint: .filterByCategory, filter: filter) { result in
            completion(result)
        }
    }
    
    func fetchDrinkById<T: Decodable>(filter : String, completion: @escaping (Result<T, Error>) -> Void) {
        makeRequest(endpoint: .idLookup, filter: filter) { result in
            completion(result)
        }
    }

    
    
    
    
}
