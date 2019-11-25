//
//  AppDelegate.swift
//  Magic Translator
//
//  Created by Arestolus Wang on 25/11/2019.
//  Copyright © 2019 Magic Done. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    // let defines a constant
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    // lazy property's initial value is not calculated until the first time it is used
    lazy var mainWindowController: NSWindowController? = NSStoryboard(name: "Main", bundle: nil)
        .instantiateController(withIdentifier: "MainWindowController") as? NSWindowController
    let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // The button that is displayed in the status bar.
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarImage"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = getMenuViewController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func getMenuViewController() -> MenuViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("MenuViewController")
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? MenuViewController else {
            fatalError("Why cant i find MenuViewController? - Check Main.storyboard")
        }
        return viewController
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
    
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }


}

