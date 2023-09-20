//
//  LightControlApp.swift
//  LightControl
//
//  Created by rryu on 2023/1/12.
//

import SwiftUI


extension String
{
    var localized: String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }


    func localizedWithComment(comment:String) -> String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
}


@main
struct LightControlApp: App {
    var body: some Scene {
        MenuBarExtra("LightControl", systemImage: "lightbulb.led") {
            MainView()
        }.menuBarExtraStyle(.window)
    }
        
}
