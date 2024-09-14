//
//  MealListView.swift
//  MealDetailsApp
//
//  Created by Sumit on 14/09/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) { // No space between cells
                    Text("Select your meal")
                        .font(.largeTitle)
                        .bold()
                        .padding(.leading, 0)
                        .padding(.top, 20)
                    
                    ForEach(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                            HStack {
                                AsyncImage(url: URL(string: meal.thumbnail)) { phase in
                                    switch phase {
                                    case .empty:
                                        Color.gray
                                            .frame(width: 100, height: 100)
                                            .overlay(
                                                ProgressView()
                                                    .progressViewStyle(CircularProgressViewStyle())
                                                    .frame(width: 100, height: 100)
                                            )
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                        //.clipShape(RoundedRectangle(cornerRadius: 15))
                                    case .failure:
                                        Color.gray
                                            .frame(width: 100, height: 100)
                                        //.clipShape(RoundedRectangle(cornerRadius: 15))
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                                Text(meal.name)
                                    .font(.headline)
                                    .padding(.leading, 5)
                                    .foregroundColor(.black)
                                
                                Spacer()
                            }
                            .padding(0) // No padding inside cell
                            .frame(height: 100) // Set consistent cell height
                            .background(Color(UIColor.systemYellow).opacity(0.3))
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, 16) // No horizontal padding
            }
            .navigationTitle("Desserts")
            .task {
                await viewModel.fetchDessertMeals()
            }
        }
    }
}
