//
//  Spacer.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct Spacer {

    public let minLength: CGFloat
    public let flexGrow: CGFloat

    public init(
        minLength: CGFloat = 0,
        flexGrow: CGFloat = 1
    ) {
        self.minLength = minLength
        self.flexGrow = flexGrow
    }
}

extension Spacer: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASLayoutSpec()
            .styled { [minLength, flexGrow] style in
                style.spacingBefore = minLength
                style.flexGrow = flexGrow
            }
            .node
    }
    
    public var layoutElement: ASLayoutElement {
        node.first ?? ASLayoutSpec()
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
