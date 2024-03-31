//
//  MenuView.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import Foundation
import SwiftUI

struct MenuView: View {
    let width = 200.0
    let height = 110.0
    
    var body: some View {
        ZStack {
            // HEADER Caption
            Text("tChime - No1")
                .frame(width: self.width, height: self.height, alignment: .topLeading)
                .padding(8)
            
            // Quit Button
            Button() {
                NSApplication.shared.terminate(nil)
//                NSApp.terminate(self)
            } label: {
                Label("Quit", systemImage: "clear")
            }
                .buttonStyle(MenuButtonStyle())
                .frame(width: self.width, height: self.height, alignment: .bottomTrailing)
                .padding(8)
                .keyboardShortcut("Q")
        }
    }
}

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(7)
            .background(BrandTheme.buttonBg)
            .foregroundColor(BrandTheme.buttonText)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 7, height: 7)))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
