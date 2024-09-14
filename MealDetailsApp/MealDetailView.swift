//
//  MealDetailView.swift
//  MealDetailsApp
//
//  Created by Sumit on 14/09/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealListViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                if let mealDetail = viewModel.selectedMealDetail {
                    // Meal Image
                    AsyncImage(url: URL(string: mealDetail.thumbnail!)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Tags (Categories)
                    HStack {
                        Text("Dessert")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(UIColor.systemYellow).opacity(0.3))
                            .cornerRadius(15)

                        Text("Malaysian")
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color(UIColor.systemYellow).opacity(0.3))
                            .cornerRadius(15)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    // Ingredients
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.top, 20)

                    ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(measurement)
                        }
                        .font(.body)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                    }

                    Spacer()
                } else {
                    ProgressView("Loading...")
                }
            }
            .navigationTitle(viewModel.selectedMealDetail?.name ?? "Meal")
            .task {
                await viewModel.fetchMealDetail(by: mealID)
            }
        }
    }
}
