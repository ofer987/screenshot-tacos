//
//  KravenApp.swift
//  Kraven
//
//  Created by Dan Ofer on 2025-12-26.
//

import SwiftUI

@main
struct KravenApp: App {
  @NSApplicationDelegateAdaptor(AppDelegate.self)
  private var appDelegate

  var body: some Scene {
    Settings {
      EmptyView()
    }
  }
}
