//
//  LeftViewController.swift
//  fir-mac
//
//  Created by isaced on 16/6/22.
//
//

import Cocoa
import Kingfisher

class LeftViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var uploadButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!

    var apps: [FIRAPP] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        
        HTTPManager.shared.fetchApps { (apps) in
            self.apps = apps
            self.tableView.reloadData()
        }
    }
    
    func reloadData() {
        
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return apps.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let  view = tableView.make(withIdentifier: "FIRAppTableCellView", owner: self) as! FIRAppTableCellView
        let app = apps[row]
        
        if app.iconURL != nil {
            view.iconImageView.kf.setImage(with: app.iconURL)
        }else{
            view.iconImageView.image = NSImage(named: NSImageNameApplicationIcon)
        }
        
        view.nameTextField.stringValue = app.name
        view.bundleIDTextField.stringValue = app.bundleID
        
        return view
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 60
    }
}
