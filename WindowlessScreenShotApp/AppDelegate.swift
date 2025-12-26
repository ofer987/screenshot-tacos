//
//  AppDelegate.swift
//  WindowlessScreenShotApp
//
//  Created by Dan Ofer on 2025-12-26.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem?

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
            title: "Select an Area",
            action: #selector(actionSelectArea),
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
            title: "Capture a Window",
            action: #selector(actionCaptureWindow),
            keyEquivalent: ""
        )
        itemCaptureWindow.image = NSImage(
            systemSymbolName: "macwindow",
            accessibilityDescription: "Capture a Window"
        )

        itemCaptureWindow.target = self
        mainMenu.addItem(itemCaptureWindow)

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
    }

    @objc private func actionSelectArea(_sender: Any?) {
        ScreenCaptureUtil.screenshot(type: .ScreenArea)
    }

    @objc private func actionCaptureWindow(_sender: Any?) {
        ScreenCaptureUtil.screenshot(type: .EntireWindow)
    }

    @objc private func captureEntireScreen(_sender: Any?) {
        ScreenCaptureUtil.screenshot(type: .Screen)
    }

    @objc private func actionQuitApp(_sender: Any?) {
        NSApp.terminate(self)
    }
}
