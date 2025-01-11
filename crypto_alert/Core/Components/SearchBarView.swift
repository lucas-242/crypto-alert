//
//  SearchBarView.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 10/01/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.textSecondary : Color.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .autocorrectionDisabled()
                .foregroundStyle(Color.accentColor)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.accent)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.closeKeyboard()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(
                    color: Color.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
            )
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
