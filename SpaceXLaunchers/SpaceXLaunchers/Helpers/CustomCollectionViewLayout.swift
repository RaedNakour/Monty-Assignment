//
//  CustomCollectionViewLayout.swift
//  SpaceXLaunchers
//
//  Created by Nicolas Akl on 2/11/22.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    public var spacingLeft: CGFloat = 8.0
    public var centerCellFlag: Bool = false
    
    private func pageWidth() -> CGFloat {
        return self.itemSize.width + self.minimumLineSpacing
    }
    
    private func flickVelocity() -> CGFloat {
        return 0.4
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let cvOffsetX = self.collectionView?.contentOffset.x ?? 0
        
        let rawPageValue = cvOffsetX / self.pageWidth()
        let currentPage = (velocity.x > 0.0) ? floor(rawPageValue) : ceil(rawPageValue)
        let nextPage = (velocity.x > 0.0) ? ceil(rawPageValue) : floor(rawPageValue)
        
        let pannedLessThanAPage = abs(1 + currentPage - rawPageValue) > 0.5
        let flicked = abs(velocity.x) > self.flickVelocity()
        
        var tempProposedContentOffset = proposedContentOffset
        
        if pannedLessThanAPage && flicked {
            tempProposedContentOffset.x = nextPage * self.pageWidth()
        } else {
            tempProposedContentOffset.x = round(rawPageValue) * self.pageWidth()
        }
        
        if centerCellFlag {
            let cvWidth = self.collectionView?.frame.width ?? 0
            
            let tempSpacingLeft = (cvWidth - self.itemSize.width - self.sectionInset.left - self.sectionInset.right) / 2
            if tempSpacingLeft > 0 {
                spacingLeft = tempSpacingLeft
            }
        }
        
        tempProposedContentOffset.x -= spacingLeft
        
        return tempProposedContentOffset
    }
    
}

