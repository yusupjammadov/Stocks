//
//  HorizontalWaterfallLayout.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 02.08.2025.
//

import UIKit

class HorizontalWaterfallLayout: UICollectionViewLayout {
    
    // MARK: - Public Properties
    
    /// Number of rows (tracks)
    var numberOfRows: Int = 2
    
    /// Horizontal spacing between items in the same row
    var interItemSpacing: CGFloat = 4
    
    /// Vertical spacing between rows
    var interRowSpacing: CGFloat = 8
    
    weak var delegate: HorizontalWaterfallLayoutDelegate?
    
    // MARK: - Private Properties
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentWidth: CGFloat = 0
    private var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.height
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }

        let rowHeight = (collectionView.bounds.height - CGFloat(numberOfRows - 1) * interRowSpacing) / CGFloat(numberOfRows)
        
        var xOffset = [CGFloat](repeating: 0, count: numberOfRows)
        let yOffset = (0..<numberOfRows).map {
            CGFloat($0) * (rowHeight + interRowSpacing)
        }

        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let itemWidth: CGFloat = delegate?.collectionView(collectionView, widthForItemAt: indexPath, withRowHeight: rowHeight) ?? 100
            
            // Find the shortest row (least total width so far)
            let shortestRow = xOffset.enumerated().min(by: { $0.element < $1.element })?.offset ?? 0
            
            let frame = CGRect(
                x: xOffset[shortestRow],
                y: yOffset[shortestRow],
                width: itemWidth,
                height: rowHeight
            )

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            // Update xOffset for the chosen row
            xOffset[shortestRow] = frame.maxX + interItemSpacing
        }

        contentWidth = (xOffset.max() ?? 0)
    }

    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { $0.indexPath == indexPath }
    }
}

protocol HorizontalWaterfallLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, widthForItemAt indexPath: IndexPath, withRowHeight height: CGFloat) -> CGFloat
}
