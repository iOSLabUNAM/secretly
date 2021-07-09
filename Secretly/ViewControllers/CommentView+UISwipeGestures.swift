//
//  CommentView+UISwipeGestures.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-09.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension CommentViewController{
func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let editAction = UIContextualAction(style: .normal, title: "Editar") { [unowned self] (action, view, completion) in
        
            let cell = tableView.cellForRow(at: indexPath) as? CommentViewCellTableViewCell
            if var unwrapComment = cell?.comment{
                unwrapComment.content = commentTextField.text ?? ""
                self.commentService?.update(unwrapComment, complete: {  [unowned self] result in
                switch result {
                    case .success(let comment):
                        self.showAlert(title: "Comentario actualizado", message: "\(comment?.content ?? "")")
                        self.reloadComments()
                        completion(true)
                    case .failure(let err):
                        self.errorAlert(err)
                        completion(false)
                    }
                })
              }
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
}
