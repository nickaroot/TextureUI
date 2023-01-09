//
//  BackgroundSpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct BackgroundSpec<Content, BackgroundContent>
where Content: LayoutElement, BackgroundContent: LayoutElement {
    
    public var layoutElement: ASLayoutElement
    
    public init(
        @LayoutSpecBuilder _ content: () -> Content,
        @LayoutSpecBuilder background: () -> BackgroundContent
    ) {
        self.layoutElement = ASBackgroundLayoutSpec(
            child: content().layoutElement,
            background: background().layoutElement
        )
    }

    public init(
        background: BackgroundContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASBackgroundLayoutSpec(
            child: content().layoutElement,
            background: background.layoutElement
        )
    }
    
    public init(
        content: Content,
        @LayoutSpecBuilder background: () -> BackgroundContent
    ) {
        self.layoutElement = ASBackgroundLayoutSpec(
            child: content.layoutElement,
            background: background().layoutElement
        )
    }

    public init(
        content: Content,
        background: BackgroundContent
    ) {
        self.layoutElement = ASBackgroundLayoutSpec(
            child: content.layoutElement,
            background: background.layoutElement
        )
    }
}

extension BackgroundSpec: LayoutElement {
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
