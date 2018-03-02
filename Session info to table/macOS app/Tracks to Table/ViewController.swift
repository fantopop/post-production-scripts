//
//  ViewController.swift
//  Tracks to Table
//
//  Created by Fantopop on 19/01/2018.
//  Copyright © 2018 Ilya Putilin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        htmlButton.toolTip = "Ready to print"
        csvButton.toolTip = "Easy to edit"
        view.window?.makeKey()
    }
    
    /*
    // Make the app window always on top
    override func viewDidAppear() {
        super.viewDidAppear()
        view.window?.level = .floating
    }*/
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var htmlButton: NSButton!
    @IBOutlet weak var csvButton: NSButton!
    @IBAction func radioButtonChanged(_ sender: NSButton) {
    }
    @IBOutlet weak var donateButton: NSButton!
    
    @IBAction func clickDonateButton(_ sender: NSButton) {
        NSWorkspace.shared.open(NSURL(string: "http://paypal.me/fantopop/2usd")! as URL)
    }
}

class DropImageView: NSImageView {
    @IBOutlet weak var htmlButton: NSButton!
    @IBOutlet weak var csvButton: NSButton!
    
    var filePath: String?
    let expectedExt = ["txt"]  //file extensions allowed for Drag&Drop (example: "jpg","png","docx", etc..)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: kUTTypeFileURL as String), NSPasteboard.PasteboardType(rawValue: kUTTypeItem as String)])
    }
    
    override func awakeFromNib() {
        // self.image = NSImage(byReferencingFile: Bundle.main.path(forResource: "SidebarDownloadsFolder", ofType: "icns")!)
        // self.image = NSImage(named: NSImage.Name(rawValue: "SidebarDownloadsFolder.icns"))
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            // self.layer?.backgroundColor = NSColor.green.cgColor
            return .copy
        } else {
            return NSDragOperation()
        }
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = pasteboard[0] as? String
            else { return false }
        
        //GET YOUR FILE PATH !!!
        self.filePath = path
        
        var format = "html"
        if csvButton.state == NSControl.StateValue.on {
            format = "csv"
        }
        
        let (exitCode, out) = runScript(fileName: path, format: format)
        // Swift.print(exitCode)
        if (exitCode == 0) {
            Swift.print(out!)
            showNotification(title: "Tracks to Table", text: "File converted to \(format)")
        }
        
        return true
    }
}


func runScript(fileName: String, format: String) -> (Int, String?) {
    guard let scriptPath = Bundle.main.path(forResource: "tracks_to_table", ofType: "py") else {
        return (1, nil)
    }
    
    // Add path to the script.
    var arguments = [scriptPath]
    
    // Scpecify format: {csv, html}
    arguments.append("--to")
    arguments.append(format)
    
    // Add path to the input file.
    arguments.append(fileName)
    
    let outPipe = Pipe()
    let errPipe = Pipe()
    
    let task = Process()
    task.launchPath = "/usr/bin/python"
    task.arguments = arguments
    task.standardInput = Pipe()
    task.standardOutput = outPipe
    task.standardError = errPipe
    task.launch()
    
    let data = outPipe.fileHandleForReading.readDataToEndOfFile()
    task.waitUntilExit()
    
    let exitCode = task.terminationStatus
    if (exitCode != 0) {
        print("ERROR: \(exitCode)")
        print(String(data: errPipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8)!)
        return (Int(exitCode), nil)
    }
    
    return (Int(exitCode), String(data: data, encoding: String.Encoding.utf8))
}

func showNotification(title: String, text: String) {
    let notification = NSUserNotification()
    
    notification.title = title
    notification.informativeText = text
    notification.soundName = NSUserNotificationDefaultSoundName
    
    let notificationCenter = NSUserNotificationCenter.default
    
    notificationCenter.deliver(notification)
}
