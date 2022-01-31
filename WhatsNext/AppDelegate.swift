//
//  AppDelegate.swift
//  WhatsNext
//
//  Created by Philipp on 30.01.22.
//

import Foundation
import AppKit
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover = NSPopover()

    func applicationDidFinishLaunching(_ notification: Notification) {
        print(#function)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusItem?.button?.title = "What's Next?"
        statusItem?.button?.target = self
        statusItem?.button?.action = #selector(togglePopover)

        let contentView = ContentView()
        popover.contentSize = NSSize(width: 400, height: 400)
        popover.contentViewController = NSHostingController(rootView: contentView)

        // Monitor mouse down
        NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            guard let self = self else { return }
            print(event)
            if self.popover.isShown {
                self.hidePopover(event)
            }
        }
    }

    func showPopover() {
        guard let statusBarButton = statusItem?.button else { return }

        popover.show(relativeTo: statusBarButton.bounds, of: statusBarButton, preferredEdge: .maxY)
    }

    func hidePopover(_ sender: Any) {
        popover.performClose(sender)
    }

    @objc func togglePopover(_ sender: Any) {
        if popover.isShown {
            hidePopover(sender)
        } else {
            showPopover()
        }
    }
}
