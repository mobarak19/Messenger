//
//  ChatVC.swift
//  Messenger
//
//  Created by Genusys Inc on 8/7/22.
//

import UIKit

import MessageKit

struct Message:MessageType{
    
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
}

struct Sender:SenderType{
    var photoUrl : String
    var senderId: String
    
    var displayName: String
    
    
}

class ChatVC: MessagesViewController {

    private var messages = [Message]()
    private let selfSender = Sender(photoUrl: "", senderId: "1", displayName: "Joe Smith")
    override func viewDidLoad() {
        super.viewDidLoad()

        messages.append(Message(sender: selfSender, messageId: "1", sentDate: Date(), kind: .text("Hellow")))
        messages.append(Message(sender: selfSender, messageId: "2", sentDate: Date(), kind: .text("afasfasfasdfasdfasd dfasdfasdf")))
        messages.append(Message(sender: selfSender, messageId: "3", sentDate: Date(), kind: .text("dffdffdfdffd")))
        view.backgroundColor = .systemBackground
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
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
