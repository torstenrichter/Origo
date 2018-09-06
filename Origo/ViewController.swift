//
//  ViewController.swift
//  Origo
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import UIKit
import IntentsUI

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController,
                                        didFinishWith voiceShortcut: INVoiceShortcut?,
                                        error: Error?) {
        if let error = error as NSError? {
            //os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var projectHours: UITextField!
    @IBAction func doBookTime(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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

