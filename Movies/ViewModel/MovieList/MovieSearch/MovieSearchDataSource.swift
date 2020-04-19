//
//  MovieSearchDataSource.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 19.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

protocol MovieSearchDelegate: class{
    func updateList()
    func selectedMovie(with id: Int)
}

final class MovieSearchDataSource: GenericDataSource<BaseResponse<MovieList>> {
    weak var viewController: MovieSearchViewController?
    weak var delegate: MovieSearchDelegate?
    var fetchingMore = false
}

// MARK: - UITableViewDataSource
extension MovieSearchDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let results = data.value.first?.results {
            return results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.reuseIdentifier, for: indexPath) as? MovieSearchTableViewCell, let results = data.value.first?.results {
            cell.movieList = results[indexPath.row]
            return cell
        }
        return BaseTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - UITableViewDelegate
extension MovieSearchDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let results = data.value.first?.results else { return }
        delegate?.selectedMovie(with: results[indexPath.row].id)
    }
}

//MARK: - UIScrollViewDelegate
extension MovieSearchDataSource: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)) {
            if !fetchingMore {
                delegate?.updateList()
            }
        }
    }
}
