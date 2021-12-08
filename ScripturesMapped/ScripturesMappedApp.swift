//
//  ScripturesMappedApp.swift
//  ScripturesMapped
//
//  Created by Katie Bankhead on 11/18/21.
//

import SwiftUI

@main
struct ScripturesMappedApp: App {
    var body: some Scene {
        WindowGroup {
            ScripturesMappedView().environmentObject(ViewModel())
        }
    }
}
