//
//  CommentViewControllerDelegate.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension CommentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Editar") { [unowned self] (action, view, completion) in
            
//            var cell = tableView.cellForRow(at: indexPath) as? CommentViewCellTableViewCell
//            if var unwrapComment = cell?.comment{
//                unwrapComment.content = commentTextField.text ?? ""
//                self.commentService?.update(unwrapComment, complete: {  [unowned self] result in
//                switch result {
//                    case .success(let comment):
//                        self.showAlert(title: "Comentario actualizado", message: "\(comment?.content ?? "")")
//                        self.reloadComments()
//                        completion(true)
//                    case .failure(let err):
//                        self.errorAlert(err)
//                        completion(false)
//                    }
//                })
//              }
            
            
            
            let cell = tableView.cellForRow(at: indexPath) as? CommentViewCellTableViewCell
            if let unwrapComment = cell?.comment{
                commentTextField.text = unwrapComment.content
                commentTextField.becomeFirstResponder()
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            completion(true)
        }
        editAction.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [unowned self](action, view, completion) in
            
            let cell = tableView.cellForRow(at: indexPath) as? CommentViewCellTableViewCell
            if let unwrapComment = cell?.comment{
                print(unwrapComment)
                self.commentService?.delete(unwrapComment, complete: {  [unowned self] result in
                    switch result {
                    case .success(let comment):
                        self.showAlert(title: "Comentario Eliminado", message: "\(comment?.id ?? 0)")
                        tableView.beginUpdates()
                        self.comments?.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .none)
                        tableView.endUpdates()
                        completion(true)
                    case .failure(let err):
                        self.errorAlert(err)
                        completion(false)
                    }
                })
          }
          completion(true)
        }
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.commentTextField.endEditing(true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
}
