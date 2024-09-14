//
//  SplashScreenView.swift
//  MealDetailsApp
//
//  Created by Sumit on 14/09/24.
//

import Foundation
import SwiftUI

struct SplashScreenView: View {
    @State private var isActive: Bool = false
    @State private var imageOpacity: Double = 1.0

    var body: some View {
        Group {
            if isActive {
                MealListView() // Main content view
            } else {
                VStack {
                    Image("SplashImage") // Add your splash screen image here
                        .resizable()
                        //.scaledToFit()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.0)) {
                                imageOpacity = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation {
                                    isActive = true
                                }
                            }
                        }
                }
                .background(Color.white) // Set background color if needed
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

