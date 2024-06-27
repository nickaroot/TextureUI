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

extension LayoutElement {
    public func padding(_ insets: UIEdgeInsets) -> some LayoutElement {
        InsetSpec(content: self, insets: insets)
    }

    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some LayoutElement {
        let computedLength = length ?? 0

        let insets = UIEdgeInsets(
            top: edges.contains(.top) ? computedLength : 0,
            left: edges.contains(.left) ? computedLength : 0,
            bottom: edges.contains(.bottom) ? computedLength : 0,
            right: edges.contains(.right) ? computedLength : 0
        )
        
        return InsetSpec(content: self, insets: insets)
    }

    public func padding(_ length: CGFloat) -> some LayoutElement {
        let computedLength = length ?? 0

        let insets = UIEdgeInsets(
            top: computedLength,
            left: computedLength,
            bottom: computedLength,
            right: computedLength
        )
        
        return InsetSpec(content: self, insets: insets)
    }
}
