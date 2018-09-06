//
//  WorkTimeViewController.swift
//  Origo
//
//  Created by Torsten Richter on 06.09.18.
//  Copyright © 2018 Torsten Richter. All rights reserved.
//

import UIKit
import IntentsUI
import os.log

extension WorkTimeViewController: INUIAddVoiceShortcutViewControllerDelegate {
    
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
class WorkTimeViewController: UIViewController {

    @IBOutlet weak var buttonBorderView: UIView!
    @IBOutlet weak var buttonBorderView2: UIView!
    @IBOutlet weak var buttonBorderView3: UIView!
    @IBOutlet weak var SiriContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonBorderView.layer.borderColor = UIColor.black.cgColor
        self.buttonBorderView.layer.borderWidth = 2.0
        self.buttonBorderView2.layer.borderColor = UIColor.black.cgColor
        self.buttonBorderView2.layer.borderWidth = 2.0
        self.buttonBorderView3.layer.borderColor = UIColor.black.cgColor
        self.buttonBorderView3.layer.borderWidth = 2.0
        self.addSiriButton(to: self.SiriContainerView)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func addSiriButton(to view: UIView) {
        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
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
        //timeBookingIntent.project = self.projectName.text
        if let shortcut = INShortcut(intent: timeBookingIntent) {
            let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
            viewController.modalPresentationStyle = .formSheet
            viewController.delegate = self // Object conforming to `INUIAddVoiceShortcutViewControllerDelegate`.
            present(viewController, animated: true, completion: nil)
        }
    }

}
