//
//  ScreenCapture.swift
//  Kraven
//
//  Created by Dan Ofer on 2025-12-26.
//

import Foundation

enum ScreenshotType {
  case ScreenArea
  case EntireWindow
  case Screen
}

class ScreenCaptureUtil {
  static func screenshot(type: ScreenshotType) {
    let task = Process()
    task.launchPath = "/usr/sbin/screencapture"

    switch type {
    case .ScreenArea:
      task.arguments = ["-cs"]
    case .EntireWindow:
      task.arguments = ["-cm"]
    case .Screen:
      task.arguments = ["-cw"]
    }

    task.launch()
    task.waitUntilExit()
  }
}
