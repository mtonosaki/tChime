//
//  tChimeApp.swift
//  tChime
//
//  Created by Manabu Tonosaki on 2024/03/30.
//

import SwiftUI

@main
struct tChimeApp: App {
    var body: some Scene {
        MenuBarExtra {
            MenuView()
        } label: {
            let image: NSImage = {
                let ratio = $0.size.height / $0.size.width
                $0.size.height = 18
                $0.size.width = 18 / ratio
                return $0
            }(NSImage(named: "MenuIcon")!)
            Image(nsImage: image)
        }
        .menuBarExtraStyle(.window)
    }
}
