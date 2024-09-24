//
//  ArticleRowView.swift
//  News
//
//  Created by Nour el houda Akbi on 23/9/2024.
//


import SwiftUI
struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
            
            HStack{
                if let imageUrl = article.imageUrl, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .cornerRadius(10)
                            .frame(height: 150)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .frame(height: 150)
                            .clipped()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(article.title)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.bottom, 2)
                        .lineLimit(3)
                    Text(article.description ?? "No description available.")
                        .lineLimit(2)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                    Text("Source: \(article.sourceName)")
                        .font(.footnote)
                        .foregroundColor(.blue)
                    
                }
                
            }
            
        }
    }

#Preview {
    ArticleRowView(article: Article(id: "1", title: "Sample Title", description: "Sample Description", content: "Sample Content", pubDate: "2024-09-23", imageUrl: "https://example.com/image.jpg", sourceName: "Sample Source", sentiment: "positive", keywords: ["sample", "keywords"], category: ["sample"], aiTag: ["tag1", "tag2"]))
}
