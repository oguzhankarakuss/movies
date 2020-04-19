//
//  MovieListDataSource.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 17.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

protocol MovieListDelegate: class {
    func updateList()
    func searchMovie(with text: String)
    func resetSearchMovie()
}

final class MovieListDataSource: GenericDataSource<BaseResponse<MovieList>> {
    weak var viewController: MovieListViewController?
    weak var delegate: MovieListDelegate?
    var fetchingMore = false
}

// MARK: - UITableViewDataSource
extension MovieListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = data.value.first?.results {
            return results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.reuseIdentifier, for: indexPath) as? MovieListTableViewCell, let results = data.value.first?.results {
            cell.upcomingContent = results[indexPath.row]
            return cell
        }
        return BaseTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return MovieListHeaderView(isDataExist: false,
                                   viewController: viewController)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.width / 1.46
    }
}

//MARK: - UITableViewDelegate
extension MovieListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.viewController,
            let results = data.value.first?.results else { return }
        let detailViewController = MovieDetailViewController()
        detailViewController.movieId = results[indexPath.row].id
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension MovieListDataSource: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
            if !fetchingMore {
                delegate?.updateList()
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension MovieListDataSource: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count >= 3 else {
            delegate?.resetSearchMovie()
            return }
        delegate?.searchMovie(with: text)        
    }
}

extension MovieListDataSource: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.resetSearchMovie()
    }
}
