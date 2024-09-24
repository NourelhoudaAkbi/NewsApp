//
//  ArticleDetailView.swift
//  News
//
//  Created by Nour el houda Akbi on 24/9/2024.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let imageUrl = article.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .frame(height: 200)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                            .clipped()
                    }
                }
                Text(article.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(article.pubDate ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                Text(article.description ?? "No description available.")
                    .font(.body)
                    .lineLimit(nil) // Allow for multi-line content
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Article Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ArticleDetailView(article: .init(id: "", title: "aa", description: "aa", content: "aa", pubDate: "aa", imageUrl: "aa", sourceName: "aa", sentiment: "", keywords: ["aa"], category: ["aa"], aiTag: []))
}
