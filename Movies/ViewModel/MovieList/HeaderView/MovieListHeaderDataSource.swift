//
//  MovieListHeaderDataSource.swift
//  Movies
//
//  Created by Oğuzhan Karakuş on 18.04.2020.
//  Copyright © 2020 Oğuzhan Karakuş. All rights reserved.
//

import UIKit

final class MovieListHeaderDataSource: GenericDataSource<NowPlaying> {
    weak var headerView: MovieListHeaderView?
    weak var viewController: MovieListViewController?
}

//MARK: - UICollectionViewDataSource
extension MovieListHeaderDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.reuseIdentifier, for: indexPath) as? HeaderCollectionViewCell {
            cell.nowPlayingContent = data.value[indexPath.row]
            return cell
        }
        return BaseCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

//MARK: - UICollectionViewDelegate
extension MovieListHeaderDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.viewController,
            let id = data.value[indexPath.row].id else { return }
        let detailViewController = MovieDetailViewController()
        detailViewController.movieId = id
        viewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

//MARK: - UIScrollViewDelegate
extension MovieListHeaderDataSource: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let headerView = headerView, let indexPath = headerView.collectionView.indexPathsForVisibleItems.first else { return }
        headerView.currentIndex = indexPath.item
    }
}
