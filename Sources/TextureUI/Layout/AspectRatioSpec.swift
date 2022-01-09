//
//  AspectRatioSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct AspectRatioSpec<Content> where Content: LayoutElement {

    public let ratio: CGFloat

    public let content: Content

    public init(
        ratio: CGFloat,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.ratio = ratio
        self.content = content()
    }

    public init(
        content: Content,
        ratio: CGFloat
    ) {
        self.ratio = ratio
        self.content = content
    }
}

extension AspectRatioSpec: LayoutElement {
    public var node: LazySequence<[ASLayoutElement]> {
        ASRatioLayoutSpec(ratio: ratio, child: content.layoutElement).node
    }
}
