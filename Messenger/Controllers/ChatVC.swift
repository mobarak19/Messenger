//
//  ChatVC.swift
//  Messenger
//
//  Created by Genusys Inc on 8/7/22.
//

import UIKit

import MessageKit
import InputBarAccessoryView

class ChatVC: MessagesViewController {

    
    var otherUserEmail :String
    
    var isNewConversation = false
    
    private var messages = [Message]()
    
    private let selfSender = Sender(photoUrl: MessengerDefaults.shared.profilePicture, senderId: MessengerDefaults.shared.userEmail, displayName: MessengerDefaults.shared.userName)
    
    private var otherSender : Sender?

    init(with email:String){
        self.otherUserEmail = email
        
        otherSender = Sender(photoUrl: "", senderId: email, displayName: "Joe")

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
    }

}
extension ChatVC:InputBarAccessoryViewDelegate{
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard !text.replacingOccurrences(of: " ", with: "").isEmpty else{
            return
        }
        
        print(text)
        //send message
        if isNewConversation{
            //create a new conversation in database
            
            let message = Message(sender: selfSender, messageId: createMessageId(), sentDate: Date(), kind: .text(text))
            print(message)
            DatabaseManager.shared.createNewConversation(with: otherUserEmail, firstMessage: message) { success in
               
                print(success)
                
            }
            
            
        }else{
            //append to exsisting conversation data
        }
    }
    
    private func createMessageId()->String{
        
        let currentUserEmail = MessengerDefaults.shared.userEmail
        let dateString = Helper.dateFormatter.string(from: Date())
        let newIdentifire = "\(otherUserEmail)_\(currentUserEmail)_\(dateString)"
        print("newIdentifire==>",newIdentifire)
        return newIdentifire
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        messageInputBar.inputTextView.becomeFirstResponder()
    }
}




extension ChatVC:MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate{
    func currentSender() -> SenderType {
    
        return selfSender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
     return   messages.count
    }
    
    
}



