//
//  AspectVGrid.swift
//  Memorize Game
//
//  Created by yuweiL on 25/6/2024.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var aspectRatio_: CGFloat = 1
    var allitems: [Item]
    var content: (Item) -> ItemView
    
    func gridItemWidthThatFits(count: Int, size: CGSize
                               , atAspectRatio aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return width.rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        return 80
    }
    
    var body: some View {
        GeometryReader {
            geometry in
            let gridItemSize = gridItemWidthThatFits(count: allitems.count, size: geometry.size, atAspectRatio: aspectRatio_)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(allitems) {
                    itemSingle_ in
                }
            }
        }
    }
}
