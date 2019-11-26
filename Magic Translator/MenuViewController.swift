//
//  MenuViewController.swift
//  Magic Translator
//
//  Created by Arestolus Wang on 25/11/2019.
//  Copyright © 2019 Magic Done. All rights reserved.
//

import Cocoa

class MenuViewController: NSViewController {

    @IBOutlet var fromTextView: NSTextView!
    @IBOutlet var toTextView: NSTextView!

    @IBOutlet var fromLanguageButton: NSPopUpButton!
    @IBOutlet var toLanguageButton: NSPopUpButton!
    
    @IBOutlet var translateButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    @IBAction func translateButtonClicked(_ sender: NSButton) {
        print("Translate Button Clicked!")
    }
    
}
