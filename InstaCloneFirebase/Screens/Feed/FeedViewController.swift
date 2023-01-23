//
//  FeedViewController.swift
//  InstaCloneFirebase
//
//  Created by Berkay YAY on 7.12.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    
    func getDataFromFirestore(){
        let firestoreDb = Firestore.firestore()
        
        firestoreDb.collection("Posts")
            .order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error!")
            } else {
                
                if snapshot?.isEmpty != true {
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentId = document.documentID
                        self.documentIdArray.append(documentId)
                        guard let userEmail = document.get("postedBy") as? String,
                              let comment = document.get("postComment") as? String,
                              let likes = document.get("likes") as? Int,
                              let imageUrl = document.get("imageUrl") as? String else {
                            return
                        }
                        self.userEmailArray.append(userEmail)
                        self.userImageArray.append(imageUrl)
                        self.userCommentArray.append(comment)
                        self.likeArray.append(likes)
                        
                    }
                    self.tableView.reloadData()
                }
                
                
            }
        }
    }
    
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        cell.useremailLabel.text = userEmailArray[indexPath.row]
        cell.likeLabel.text = "\(likeArray[indexPath.row])"
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: userImageArray[indexPath.row]))
        cell.docIdLabel.text = documentIdArray[indexPath.row]
        
        return cell
    }

    

}
