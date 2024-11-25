//
//  KartenspielApp.swift
//  Kartenspiel
//
//  Created by Thomas Funke on 24.11.24.
//

import SwiftUI

@main
struct KartenspielApp: App {
    @AppStorage("colorScheme") private var colorScheme: Int = 0  // 0 = System, 1 = Hell, 2 = Dunkel
    @State private var isShowingSplash = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainTabView()
                    .opacity(isShowingSplash ? 0 : 1)
                
                if isShowingSplash {
                    SplashScreenView(isShowingSplash: $isShowingSplash)
                }
            }
            .animation(.easeInOut, value: isShowingSplash)
            .preferredColorScheme(colorScheme == 0 ? .none : colorScheme == 1 ? .light : .dark)
        }
    }
}
