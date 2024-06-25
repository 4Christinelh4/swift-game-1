//
//  AspectVGrid.swift
//  Memorize Game
//
//  Created by yuweiL on 25/6/2024.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var aspectRatio_: CGFloat
    var allitems: [Item]
    @ViewBuilder var content: (Item) -> ItemView
    
    init(aspectRatio_: CGFloat, _ allitems: [Item], content: @escaping (Item) -> ItemView) {
        self.aspectRatio_ = aspectRatio_
        self.allitems = allitems
        self.content = content
    }
    
    func gridItemWidthThatFits(count: Int, 
                               size: CGSize,
                               atAspectRatio aspectRatio: CGFloat
                                ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            let gridItemSize = gridItemWidthThatFits(count: allitems.count, size: geometry.size, atAspectRatio: aspectRatio_)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(allitems) {
                    itemSingle_ in
                    content(itemSingle_)
                        .aspectRatio(aspectRatio_, contentMode: .fit)
                }
            }
        }
    }
}
