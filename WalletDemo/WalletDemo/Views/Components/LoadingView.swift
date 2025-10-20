//
//  LoadingView.swift
//  WalletDemo
//
//  Created by Jose Gomez on 10/20/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                    .scaleEffect(1.5)
                Text("Loading...")
                    .font(.headline)
            }
            .padding(32)
            .background(Color(.systemBackground))
            .cornerRadius(16)
        }
    }
}
