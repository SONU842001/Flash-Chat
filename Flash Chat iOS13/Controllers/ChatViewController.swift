//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
//    database crreated
    let db = Firestore.firestore()
    
    var messages:[Message] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        //to hide back button of navigationController
        title = K.appName
        navigationItem.hidesBackButton = true
        
        
//        registering table view of messageCell.xib file
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
//        function call to retrieving data from firestore
        loadMessage()

    }
    
//    function for retrieving data
    
    func loadMessage()
    {
         messages = []
        db.collection(K.FStore.collectionName).getDocuments { querySnapshots, error in
            if let e = error{
                print("There is an error to retrieving data from firestore.,\(e)")
            }else{
                if let snapshotDocuments = querySnapshots?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        
//                        (as? String) is used to downcasting in string
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            
                            
//                            for showing message in ChatViewController
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
//        saving data to firestore
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField: messageSender,K.FStore.bodyField: messageBody]) { (error) in
                if let e = error{
                    print("There is an issue to save data to firestore, \(e)")
                }else{
                    print("Successfully saved data.")
                }
            }
        }
    }
    
    @IBAction func LogOutButtonPressed(_ sender: UIBarButtonItem) {
         
    do {
      try Auth.auth().signOut()
        
        // this will navigate to initial viewController
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
    }
    
}




extension ChatViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
    
}
    


