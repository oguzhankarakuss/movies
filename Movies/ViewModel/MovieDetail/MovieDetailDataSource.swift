//
//  MovieDetailDataSource.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieDetailDataSource: GenericDataSource<BaseResponse<CustomMovieDetailModel>> {
    weak var viewController: MovieDetailViewController?
}

// MARK: - UITableViewDataSource
extension MovieDetailDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let result = data.value.first?.results?.first, result.movieDetail != nil {
            if let similarMovies = result.similarMovies, !similarMovies.isEmpty {
                return 2
            }
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailTableViewCell.identifier, for: indexPath) as? MovieDetailTableViewCell, let movieDetail = data.value.first?.results?.first?.movieDetail {
                cell.movieDetail = movieDetail
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailSimilarMoviesTVCell.identifier, for: indexPath) as? MovieDetailSimilarMoviesTVCell {
                cell.dataSource = self
                return cell
            }
        default: break
        }
        return BaseTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let imageUrl = data.value.first?.results?.first?.headerImageUrl {
            return MovieListHeaderView(nowPlaying: [NowPlaying(posterPath: imageUrl, id: nil, title: nil)], isDataExist: true)
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.width / 1.46

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 180
        }
        return UITableView.automaticDimension
    }
}

//MARK: - UITableViewDelegate
extension MovieDetailDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension MovieDetailDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let similarMovies = data.value.first?.results?.first?.similarMovies {
            return similarMovies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let similarMovies = data.value.first?.results?.first?.similarMovies,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailCollectionViewCell.reuseIdentifier, for: indexPath) as? MovieDetailCollectionViewCell {
            cell.similarMovies = similarMovies[indexPath.row]
            return cell
        }
        return BaseCollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate
extension MovieDetailDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.viewController,
            let similarMovies = data.value.first?.results?.first?.similarMovies else { return }
        viewController.movieId = similarMovies[indexPath.row].id
    }
}
