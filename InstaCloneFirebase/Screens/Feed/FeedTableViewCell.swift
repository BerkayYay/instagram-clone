//
//  FeedTableViewCell.swift
//  InstaCloneFirebase
//
//  Created by Berkay YAY on 8.12.2022.
//

import UIKit
import Firebase

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var docIdLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {
        let firestoreDb = Firestore.firestore()
        
        guard let likeCount = Int(likeLabel.text!) else {
            return
        }
        
        let likeStore = ["likes" : likeCount + 1] as [String : Any]
        firestoreDb.collection("Posts").document(docIdLabel.text!).setData(likeStore, merge: true)
        
    }
}
