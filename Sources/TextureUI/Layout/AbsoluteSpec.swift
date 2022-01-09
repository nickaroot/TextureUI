//
//  AbsoluteSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct AbsoluteSpec<Content> where Content: LayoutElement {

    public let sizing: ASAbsoluteLayoutSpecSizing

    public let content: Content

    public init(
        sizing: ASAbsoluteLayoutSpecSizing = .default,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.sizing = sizing
        self.content = content()
    }

    public init(
        content: Content,
        sizing: ASAbsoluteLayoutSpecSizing = .default
    ) {
        self.sizing = sizing
        self.content = content
    }
}

extension AbsoluteSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASAbsoluteLayoutSpec(sizing: sizing, children: content.layoutElements).node
    }
}
