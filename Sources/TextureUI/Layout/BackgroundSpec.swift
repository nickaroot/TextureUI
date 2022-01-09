//
//  BackgroundSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct BackgroundSpec<Content, BackgroundContent>
where Content: LayoutElement, BackgroundContent: LayoutElement {

    public let background: BackgroundContent

    public let content: Content

    public init(
        background: BackgroundContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.background = background
        self.content = content()
    }

    public init(
        content: Content,
        background: BackgroundContent
    ) {
        self.background = background
        self.content = content
    }
}

extension BackgroundSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASBackgroundLayoutSpec(
            child: content.layoutElement,
            background: background.layoutElement
        )
        .node
    }
}
