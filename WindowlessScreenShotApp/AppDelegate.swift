//
//  AppDelegate.swift
//  WindowlessScreenShotApp
//
//  Created by Dan Ofer on 2025-12-26.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
  var statusBarItem: NSStatusItem?
  @State var eventMonitor: Any?

  func applicationDidFinishLaunching(_ notification: Notification) {
    statusBarItem = NSStatusBar.system
      .statusItem(withLength: NSStatusItem.squareLength)

    if let statusBarButton = statusBarItem?.button {
      statusBarButton.image = NSImage(
        systemSymbolName: "cursorarrow.rays", accessibilityDescription: "Take a screenshot")
    }

    let mainMenu = NSMenu()

    // Create menu item: Capture an Area
    let itemSelectArea = NSMenuItem(
      title: "Move Tab to the Left",
      action: #selector(moveTabToTheLeft),
      keyEquivalent: "")

    itemSelectArea.image = NSImage(
      systemSymbolName: "rectangle.dashed",
      accessibilityDescription: "Select an Area"
    )

    itemSelectArea.target = self
    mainMenu.addItem(itemSelectArea)

    // Creating menu item: Capture the Entire Screen
    let itemCaptureEntireScreen = NSMenuItem(
      title: "Capture the Entire Screen",
      action: #selector(captureEntireScreen),
      keyEquivalent: ""
    )
    itemCaptureEntireScreen.image = NSImage(
      systemSymbolName: "macwindow.on.rectangle",
      accessibilityDescription: "Capture the Entire Screen"
    )

    itemCaptureEntireScreen.target = self
    mainMenu.addItem(itemCaptureEntireScreen)

    // Creating menu item: Capture a Window
    let itemCaptureWindow = NSMenuItem(
      title: "Move Tab to the Right",
      action: #selector(moveTabToTheRight),
      keyEquivalent: ""
    )
    itemCaptureWindow.image = NSImage(
      systemSymbolName: "macwindow",
      accessibilityDescription: "Capture a Window"
    )

    itemCaptureWindow.target = self
    mainMenu.addItem(itemCaptureWindow)

    // Creating menu item: Pin/Unpin Tab
    let itemPinTab = NSMenuItem(
      title: "Pin/Unpin Current Tab",
      action: #selector(togglePinTab),
      keyEquivalent: ""
    )
    itemPinTab.image = NSImage(
      systemSymbolName: "pin",
      accessibilityDescription: "Pin/Unpin Tab"
    )
    itemPinTab.target = self
    mainMenu.addItem(itemPinTab)

    // Creating menu item: Create a Divider
    mainMenu.addItem(.separator())

    // Creating menu item: Quit
    let itemQuit = NSMenuItem(
      title: "Quit",
      action: #selector(actionQuitApp),
      keyEquivalent: ""
    )

    itemQuit.target = self
    mainMenu.addItem(itemQuit)

    statusBarItem?.menu = mainMenu

    // Setup global keyboard monitoring
    setupKeyboardMonitoring()
  }

  func setupKeyboardMonitoring() {
    // Monitor for global keyboard events
    self.eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [self] event in
      print("key is \(event.keyCode)")
      if event.modifierFlags.contains([.option, .shift]) && event.keyCode == 35 {
        runAutomatorWorkflow(
          at: #"Pin Tab"#)
      }

      if event.modifierFlags.contains([.option, .shift]) && event.keyCode == 4 {
        runAutomatorWorkflow(
          at: #"Move Safari Tab to the Left"#)
      }

      // Check for Cmd+Shift+Right Arrow (Move tab right)
      if event.modifierFlags.contains([.option, .shift]) && event.keyCode == 37 {
        runAutomatorWorkflow(
          at: #"Move Safari Tab to the Right"#)
      }
    }
  }

  func runAutomatorWorkflow(at path: String, withInput input: Any? = nil) {
    guard let url = Bundle.main.url(forResource: path, withExtension: "workflow") else {
      print("Failed to find '\(path).workflow'")
      return
    }

    let task = Process()
    task.launchPath = "/usr/bin/automator"
    task.arguments = [url.path]

    // If you need to pass input
    if let inputString = input as? String {
      let pipe = Pipe()
      task.standardInput = pipe
      pipe.fileHandleForWriting.write(inputString.data(using: .utf8)!)
      pipe.fileHandleForWriting.closeFile()
    }

    task.launch()
    task.waitUntilExit()
  }

  func executeAppleScript(_ script: String) -> Bool {
    guard let appleScript = NSAppleScript(source: script) else {
      print("Failed to create AppleScript")
      return false
    }

    var error: NSDictionary?
    appleScript.executeAndReturnError(&error)

    if let error = error {
      print("AppleScript Error: \(error)")
      return false
    }

    return true
  }

  @objc private func moveTabToTheLeft(_sender: Any?) {
    runAutomatorWorkflow(
      at: #"Move Safari Tab to the Left"#)
  }

  @objc private func moveTabToTheRight(_sender: Any?) {
    runAutomatorWorkflow(
      at: #"Move Safari Tab to the Right"#)
  }

  @objc private func captureEntireScreen(_sender: Any?) {
    ScreenCaptureUtil.screenshot(type: .Screen)
  }

  @objc private func togglePinTab(_sender: Any?) {
    runAutomatorWorkflow(
      at: #"Pin Tab"#)
  }

  @objc private func actionQuitApp(_sender: Any?) {
    NSApp.terminate(self)
  }

  deinit {
    if let monitor = eventMonitor {
      NSEvent.removeMonitor(monitor)
    }
  }

}
