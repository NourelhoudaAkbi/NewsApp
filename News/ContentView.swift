//
//  ContentView.swift
//  News
//
//  Created by Nour el houda Akbi on 23/9/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = NewsViewModel()
    
    // State to hold selected category
    @State private var selectedCategory: String = "All"
    
    // State to handle loading more articles
    @State private var isLoadingMore = false
    @State private var currentPage = 1
    
    // Categories for filtering
    let categories = ["All", "top", "business", "world", "sports", "entertainment", "technology", "other"]
    
    // Filter articles based on selected category
    var filteredArticles: [Article] {
        viewModel.articles.filter { article in
            // Check if the article's category matches the selected category
            selectedCategory == "All" || (article.category.contains(where: { $0.caseInsensitiveCompare(selectedCategory) == .orderedSame }) ?? false)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set the background color to white
                Color.white.ignoresSafeArea()
                VStack {
                    // Horizontal ScrollView for category filters
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(categories, id: \.self) { category in
                                Text(category)
                                    .font(.headline)
                                    .foregroundColor(selectedCategory == category ? .white : .black)
                                    .padding()
                                    .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedCategory = category
                                        // Reset to first page when category changes
                                        currentPage = 1
                                        fetchArticles() // Fetch articles for the new category
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // News List
                    List(filteredArticles.indices, id: \.self) { index in
                                            NavigationLink(destination: ArticleDetailView(article: filteredArticles[index])) {
                                                ArticleRowView(article: filteredArticles[index])
                                            }
                                            .onAppear {
                                                // Load more articles when reaching the last item
                                                if index == filteredArticles.count - 1 && !isLoadingMore {
                                                    loadMoreArticles()
                                                }
                                            }
                                        }
                                        .listStyle(PlainListStyle()) // Use plain list style to prevent background color
                                        .background(Color.white) // Set the background of the list to white
                                        .navigationTitle("News")
                                        .onAppear {
                                            // Fetch articles if the list is empty
                                            if viewModel.articles.isEmpty {
                                                fetchArticles()
                                            }
                                        }
                                    }
                                }
                            }
                        }

    private func fetchArticles() {
        viewModel.fetchNews(category: selectedCategory, page: currentPage) { articles in
            if let newArticles = articles {
                viewModel.articles = newArticles // Reset articles on new category selection
            }
        }
    }
    
    private func loadMoreArticles() {
        guard !isLoadingMore else { return } // Prevent multiple simultaneous fetches
        isLoadingMore = true
        currentPage += 1
        
        viewModel.fetchNews(category: selectedCategory, page: currentPage) { articles in
            // Check if articles were returned and append them to the existing list
            if let newArticles = articles {
                viewModel.articles.append(contentsOf: newArticles)
            }
            // Reset loading state
            isLoadingMore = false
        }
    }
}

#Preview {
    ContentView()
}
