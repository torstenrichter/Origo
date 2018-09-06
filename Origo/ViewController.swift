//
//  ViewController.swift
//  Origo
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import UIKit
import IntentsUI
import os.log

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? {
            os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeentries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell2 = tableView.dequeueReusableCell(withIdentifier: "LabelCell2", for: indexPath) as! TableViewCell2
        cell.projectName.text = self.timeentries[indexPath.row].projectRelation?.alias
        return cell
    }
    
    @IBOutlet weak var bookingListView: UITableView!
    let dataManager = DataManager()
    var timeentries:[TimeEntry] = [TimeEntry]()
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectHours: UITextField!
    @IBAction func doBookTime(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let timeEntry = TimeEntry(context: context)
        timeEntry.start = Date()
        timeEntry.end = timeEntry.start
        let project = Project(context: context)
        project.name = self.projectName.text
        project.alias = self.projectName.text
        timeEntry.projectRelation = project
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        self.timeentries = dataManager.getBookingList()
        os_log("%i %s",timeentries.count, timeEntry.projectRelation?.alias ?? "")
        self.bookingListView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingListView.delegate = self
        bookingListView.dataSource = self
        self.timeentries = dataManager.getBookingList()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func addSiriButton(to view: UIView) {
        let button = INUIAddVoiceShortcutButton(style: .black)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
        
        button.addTarget(self, action: #selector(addToSiri(_:)), for: .touchUpInside)
    }
    @objc
    func addToSiri(_ sender: Any) {
        let timeBookingIntent = TimeBookingIntent()
        timeBookingIntent.hours = 1
        timeBookingIntent.project = self.projectName.text
        if let shortcut = INShortcut(intent: timeBookingIntent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addSiriButton(to:self.view)
    }


}

