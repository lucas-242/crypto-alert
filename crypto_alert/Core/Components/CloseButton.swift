//
//  CloseButton.swift
//  crypto_alert
//
//  Created by Lucas Matheus Guimarães on 20/01/25.
//

import SwiftUI

struct CloseButton: View {
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(
          action: {
            presentationMode.wrappedValue.dismiss()
          },
          label: {
            Image(systemName: "xmark")
                  .font(.headline)
                  .foregroundStyle(Color.text)
          }
        )
    }
}

#Preview {
    CloseButton()
}
