//
//  CommentViewControllerDataSource.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension CommentViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as! CommentViewCellTableViewCell
        cell.comment = comments?[indexPath.row]
        return cell
    }


}
