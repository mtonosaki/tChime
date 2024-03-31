//
//  MenuView.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/31.
//

import Foundation
import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("tChime - No1")
            Button() {
                NSApplication.shared.terminate(self)
            } label: {
                Image(systemName: "clear")
                Text("Quit")
            }
        }.frame(width: 200, height: 110)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
