//
//  InsetLayout.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct InsetSpec<Content> where Content: LayoutElement {

    public var layoutElement: ASLayoutElement

    public init(
        insets: UIEdgeInsets,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASInsetLayoutSpec(
            insets: insets,
            child: content().layoutElement
        )
    }

    public init(
        content: Content,
        insets: UIEdgeInsets
    ) {
        self.layoutElement = ASInsetLayoutSpec(
            insets: insets,
            child: content.layoutElement
        )
    }
}

extension InsetSpec: LayoutElement {
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
