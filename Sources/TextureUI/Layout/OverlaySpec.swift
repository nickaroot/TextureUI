//
//  OverlaySpec.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

public struct OverlaySpec<Content, OverlayContent>
where Content: LayoutElement, OverlayContent: LayoutElement {
    
    public var layoutElement: ASLayoutElement
    
    public init(
        @LayoutSpecBuilder _ content: () -> Content,
        @LayoutSpecBuilder overlay: () -> OverlayContent
    ) {
        self.layoutElement = ASOverlayLayoutSpec(
            child: content().layoutElement,
            overlay: overlay().layoutElement
        )
    }

    public init(
        overlay: OverlayContent,
        @LayoutSpecBuilder _ content: () -> Content
    ) {
        self.layoutElement = ASOverlayLayoutSpec(
            child: content().layoutElement,
            overlay: overlay.layoutElement
        )
    }
    
    public init(
        content: Content,
        @LayoutSpecBuilder overlay: () -> OverlayContent
    ) {
        self.layoutElement = ASOverlayLayoutSpec(
            child: content.layoutElement,
            overlay: overlay().layoutElement
        )
    }

    public init(
        content: Content,
        overlay: OverlayContent
    ) {
        self.layoutElement = ASOverlayLayoutSpec(
            child: content.layoutElement,
            overlay: overlay.layoutElement
        )
    }
}

extension OverlaySpec: LayoutElement {
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
    public func overlay<Overlay>(_ overlay: Overlay?) -> LayoutElement
    where Overlay: LayoutElement {
        overlay.map { OverlaySpec(content: self, overlay: $0) } ?? self
    }
}
