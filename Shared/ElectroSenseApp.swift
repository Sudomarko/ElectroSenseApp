//
//  ElectroSenseApp.swift
//  Shared
//
//  Created by Marko Vukasinovic on 9/14/22.
//

import SwiftUI

@main
struct ElectroSenseApp: App {
    let some_val = CoreBluetoothWrap();
    init() {
            some_val.set_manager();
            sleep(2);
            some_val.get_message();
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
