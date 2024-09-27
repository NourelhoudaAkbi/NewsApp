//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Nour el houda Akbi on 23/9/2024.
//

import SwiftUI
import Combine
import Alamofire

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    

    func fetchNews(category: String, page: Int, completion: @escaping ([Article]?) -> Void) {
        let url = "https://newsdata.io/api/1/latest?country=dz&apikey=pub_5419540f31c800e98d983ea8f8f8b895b4c79"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                // Print raw response data
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                do {
                    let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    completion(newsResponse.results)
                } catch {
                    print("Decoding error: \(error.localizedDescription)")
                    completion(nil)
                }
                
            case .failure(let error):
                print("API error: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }


}
