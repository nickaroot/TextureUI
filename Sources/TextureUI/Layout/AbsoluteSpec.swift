//
//  AbsoluteSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct AbsoluteSpec<Content> where Content: LayoutElement {
    
    public var layoutElement: ASLayoutElement

    public init(
        sizing: ASAbsoluteLayoutSpecSizing = .default,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASAbsoluteLayoutSpec(
            sizing: sizing,
            children: content().node.elements
        )
    }

    public init(
        content: Content,
        sizing: ASAbsoluteLayoutSpecSizing = .default
    ) {
        self.layoutElement = ASAbsoluteLayoutSpec(
            sizing: sizing,
            children: content.node.elements
        )
    }
}

extension AbsoluteSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        [
            layoutElement
        ]
            .lazy
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
