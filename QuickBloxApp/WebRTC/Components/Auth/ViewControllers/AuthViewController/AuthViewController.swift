//
//  AuthViewController.swift
//  QuickBloxApp
//
//  Created by Sierra on 2/27/17.
//  Copyright © 2017 Sierra. All rights reserved.
//

import UIKit

class AuthViewController: UITableViewController, UITextFieldDelegate, QBCoreDelegate {
    @IBOutlet weak var loginInfo: UILabel!
    @IBOutlet weak var userNameDescriptionLabel: UILabel!
    @IBOutlet weak var chatRoomDescritptionLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var chatRoomNameTextField: UITextField!
    @IBOutlet weak var loginButton: QBLoadingButton!
    
    var needReconnect: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        QBCore.instance().add(self as QBCoreDelegate)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        self.tableView.delaysContentTouches = false
        
        self.navigationItem.title = NSLocalizedString("Enter to Chat", comment: "")
        
        self.defaultConfiguration()
        //Update interface and start login if user exist
        if QBCore.instance().currentUser != nil {
            self.userNameTextField.text = QBCore.instance().currentUser.fullName
            self.chatRoomNameTextField.text = QBCore.instance().currentUser.tags.firstObject as! String?
            self.login()
        }
        
    }
    
    func defaultConfiguration() {
        self.loginButton.hideLoading()
        self.loginButton.setTitle(NSLocalizedString("Login", comment: ""), for: UIControlState.normal)
        
        self.loginButton.isEnabled = false
        self.userNameTextField.text = ""
        self.chatRoomNameTextField.text = ""
        
        self.setInputEnabled(enabled: true)
        // Reachability
        let updateLoginInfo: (QBNetworkStatus) -> Void = { (status: QBNetworkStatus) in
            let loginInfo = status == QBNetworkStatus.notReachable ? NSLocalizedString("Please check your Internet connection", comment: "") : NSLocalizedString("Please enter your username and chat room name. You can join existent chat room.", comment: "")
            self.setLoginInfoText(text: loginInfo)
        }
        
        QBCore.instance().networkStatusBlock = { (status: QBNetworkStatus) in
            if self.needReconnect && status != QBNetworkStatus.notReachable {
                self.needReconnect = false
                self.login()
            }
            else {
                updateLoginInfo(status)
            }
        }
        
        updateLoginInfo(QBCore.instance().networkStatus())
    }
    
    // pragma mark - Disable / Enable inputs
    func setInputEnabled(enabled: Bool) {
        self.chatRoomNameTextField.isEnabled = enabled
        self.userNameTextField.isEnabled = enabled
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // pragma mark - UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // pragma mark - UIControl Actions
    @IBAction func didPressLoginButton(_ sender: QBLoadingButton) {
        self.login()
    }
    
    // pragma mark - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.validateTextField(textField: textField)
    }
    
    @IBAction func editingChanged(_ sender:  UITextField) {
        self.validateTextField(textField: sender)
        self.loginButton.isEnabled = self.userNameIsValid() && self.chatRoomIsValid()
    }
    
    func validateTextField(textField: UITextField) {
        if textField == self.userNameTextField && !self.userNameIsValid() {
            self.chatRoomDescritptionLabel.text = ""
            self.userNameDescriptionLabel.text = NSLocalizedString("Field should contain alphanumeric characters only in a range 3 to 20. The first character must be a letter.", comment: "")
        }
        else if textField == self.chatRoomNameTextField && !self.chatRoomIsValid() {
            self.userNameDescriptionLabel.text = ""
            self.chatRoomDescritptionLabel.text = NSLocalizedString("Field should contain alphanumeric characters only in a range 3 to 15, without space. The first character must be a letter.", comment: "")
        }
        else {
            self.chatRoomDescritptionLabel.text = ""
            self.userNameDescriptionLabel.text = ""
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    func setLoginInfoText(text: String) {
        if text != self.loginInfo.text {
            self.loginInfo.text = text
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
    
    // pragma mark - Login
    func login() {
        self.isEditing = false
        self.beginConnect()
        
        if QBCore.instance().currentUser != nil {
            QBCore.instance().loginWithCurrentUser()
        }
        else {
            QBCore.instance().signUp(withFullName: self.userNameTextField.text!, roomName: self.chatRoomNameTextField.text!)
        }
    }
    
    func beginConnect() {
        self.setInputEnabled(enabled: false)
        self.loginButton.showLoading()
    }
    
    func endConnectError(error: NSError) {
        self.setInputEnabled(enabled: true)
        self.loginButton.hideLoading()
    }
    
    // pragma mark - QBCoreDelegate
    func coreDidLogin(_ core: QBCore) {
        self.performSegue(withIdentifier: "ShowUsersViewController", sender: nil)
    }
    
    func coreDidLogout(_ core: QBCore) {
        self.defaultConfiguration()
    }
    
    func core(_ core: QBCore, error: Error, domain: ErrorDomain) {
        var infoText = error.localizedDescription
        
        if (error as NSError).code == NSURLErrorNotConnectedToInternet {
            infoText = NSLocalizedString("Please check your Internet connection", comment: "")
            self.needReconnect = true
        }
        else if core.networkStatus() != QBNetworkStatus.notReachable {
            if domain == ErrorDomain.signUp || domain == ErrorDomain.logIn {
                self.login()
            }
        }
        
        self.setLoginInfoText(text: infoText)
    }

    func core(_ core: QBCore, loginStatus: String) {
        self.setLoginInfoText(text: loginStatus)
    }
    
    // pragma mark - Validation helpers
    func userNameIsValid() -> Bool {
        let characterSet = NSCharacterSet.whitespaces
        let userName = self.userNameTextField.text?.trimmingCharacters(in: characterSet)
        let userNameRegex = "^[^_][\\w\\u00C0-\\u1FFF\\u2C00-\\uD7FF\\s]{2,19}$"
        let userNamePredicate = NSPredicate(format: "SELF MATCHES %@", userNameRegex)
        let userNameIsValid = userNamePredicate.evaluate(with: userName)
        
        return userNameIsValid
    }
    
    func chatRoomIsValid() -> Bool {
        let characterSet = NSCharacterSet.whitespaces
        let tag = self.chatRoomNameTextField.text?.trimmingCharacters(in: characterSet)
        let tagRegex = "^[a-zA-Z][a-zA-Z0-9]{2,14}$"
        let tagPredicate = NSPredicate(format: "SELF MATCHES %@", tagRegex)
        let tagIsValid = tagPredicate.evaluate(with: tag)
        
        return tagIsValid
    }
}
