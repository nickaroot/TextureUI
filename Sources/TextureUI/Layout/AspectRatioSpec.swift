//
//  AspectRatioSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct AspectRatioSpec<Content> where Content: LayoutElement {
    
    public var layoutElement: ASLayoutElement

    public init(
        ratio: CGFloat,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASRatioLayoutSpec(
            ratio: ratio,
            child: content().layoutElement
        )
    }

    public init(
        content: Content,
        ratio: CGFloat
    ) {
        self.layoutElement = ASRatioLayoutSpec(
            ratio: ratio,
            child: content.layoutElement
        )
    }
}

extension AspectRatioSpec: LayoutElement {
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

extension LayoutElement {
    public func aspectRatio(_ ratio: CGFloat) -> some LayoutElement {
        AspectRatioSpec(content: self, ratio: ratio)
    }
}
