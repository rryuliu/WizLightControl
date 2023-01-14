//
//  LightControlApp.swift
//  LightControl
//
//  Created by rryu on 2023/1/12.
//

import SwiftUI

@main
struct LightControlApp: App {
    var body: some Scene {
        MenuBarExtra("LightControl", systemImage: "lightbulb.led") {
            MainView()
        }.menuBarExtraStyle(.window)
    }
        
}
