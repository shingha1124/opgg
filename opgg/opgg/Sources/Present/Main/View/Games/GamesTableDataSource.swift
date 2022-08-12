//
//  GamesTableDataSource.swift
//  opgg
//
//  Created by seongha shin on 2022/08/13.
//

import UIKit

final class GamesTableDataSource: NSObject, UITableViewDataSource {
    private var viewModels = [GamesTableViewCellModel]()
    
    func updateViewModels(_ viewModels: [GamesTableViewCellModel]) {
        self.viewModels = viewModels
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GamesTableViewCell.identifier, for: indexPath) as? GamesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModels[indexPath.item]
        return cell
    }
}
