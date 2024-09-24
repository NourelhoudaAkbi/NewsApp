//
//  Article.swift
//  NewsApp
//
//  Created by Nour el houda Akbi on 23/9/2024.
//
import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let results: [Article]

}


// Define the Article struct
struct Article: Identifiable, Codable {
    var id: String // Ensure this is a unique identifier
    var title: String
    var description: String?
    var content: String?
    var pubDate: String // You might also want to use Date for better date handling
    var imageUrl: String?
    var sourceName: String
    var sentiment: String
    var keywords: [String]?
    var category: [String]
    var aiTag: [String]?

    // Optional: Use CodingKeys if JSON keys differ from property names
    enum CodingKeys: String, CodingKey {
        case id = "article_id"  // Assuming your JSON uses "article_id"
        case title
        case description
        case content
        case pubDate = "pubDate"
        case imageUrl = "image_url"
        case sourceName = "source_name"
        case sentiment
        case keywords
        case category// Change based on your JSON structure
    }
}

// Example usage of decoding JSON into Article instances
func decodeArticles(from jsonData: Data) {
    do {
        let articles = try JSONDecoder().decode([Article].self, from: jsonData)
        print(articles)
    } catch {
        print("Failed to decode JSON: \(error.localizedDescription)")
    }
}
