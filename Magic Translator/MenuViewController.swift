//
//  MenuViewController.swift
//  Magic Translator
//
//  Created by Arestolus Wang on 25/11/2019.
//  Copyright © 2019 Magic Done. All rights reserved.
//

import Cocoa
import Promises
import SwiftyJSON

class MenuViewController: NSViewController {

    @IBOutlet var fromTextView: NSTextView!
    @IBOutlet var toTextView: NSTextView!

    @IBOutlet var fromLanguageButton: NSPopUpButton!
    @IBOutlet var toLanguageButton: NSPopUpButton!
    
    @IBOutlet var translateButton: NSButton!
    
    let avaliableLanguages = ["auto", "en", "zh-CN"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func translate(fromText: String, fromLanguage: String, toLanguage: String) {
        
        let request = HttpRequest()
        request.get(url: "https://translate.googleapis.com/translate_a/single", params: [
            "client": "gtx",
            "sl": fromLanguage,
            "tl": toLanguage,
            "dt": "t",
            "q": fromText])
            .then { httpResponse in
                let data = httpResponse.data
                do {
                    let json = try JSON(data: data)
                    if let result = json[0][0][0].string {
                        self.toTextView.string = result
                    }
                }
                catch {
                    
                }
        }
    }

    @IBAction func translateButtonClicked(_ sender: NSButton) {
        let fromText = fromTextView.string
        let fromLanguage = avaliableLanguages[fromLanguageButton.selectedItem!.tag]
        let toLanguage = avaliableLanguages[toLanguageButton.selectedItem!.tag]
        if (fromText.count > 0) {
            translate(fromText: fromText, fromLanguage: fromLanguage, toLanguage: toLanguage)
        } else {
            toTextView.string = ""
        }
    }
    
}
