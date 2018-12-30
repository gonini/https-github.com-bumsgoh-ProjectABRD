//
//  StretchableHeaderFlowLayout.swift
//  AbroadApp
//
//  Created by bumslap on 30/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class StretchableHeaderFlowLayout: UICollectionViewFlowLayout {
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return true
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.forEach {
            if $0.representedElementKind == UICollectionView.elementKindSectionHeader && $0.indexPath.section == 0 { //첫번째 헤더에만 적용한다.
                guard let collectionView = collectionView else {
                    return
                }
                
                let contentOffSetY = collectionView.contentOffset.y
                
                if contentOffSetY > 0 {
                    return
                }
                let width = collectionView.frame.width
                let height = $0.frame.height - contentOffSetY // 스크롤을 내릴수록 offset은 증가함
                $0.frame = CGRect(x: 0, y: contentOffSetY, width: width, height: height)
            }
            
        }
        return attributes
    }
    
   

}
