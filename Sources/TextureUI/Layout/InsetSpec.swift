//
//  InsetLayout.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct InsetSpec<Content> where Content: LayoutElement {

    public var insets: UIEdgeInsets

    public let content: Content

    public init(
        insets: UIEdgeInsets,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.insets = insets
        self.content = content()
    }

    public init(
        content: Content,
        insets: UIEdgeInsets
    ) {
        self.insets = insets
        self.content = content
    }
}

extension InsetSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASInsetLayoutSpec(insets: insets, child: content.layoutElement).node
    }
    
    public var layoutElement: ASLayoutElement {
        node.first ?? ASLayoutSpec()
    }
    
    public var style: ASLayoutElementStyle {
        layoutElement.style
    }
}
