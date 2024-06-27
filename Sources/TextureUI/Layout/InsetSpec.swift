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
        if let insetSpec = content() as? InsetSpec,
           let insetLayoutSpec = insetSpec.layoutElement as? ASInsetLayoutSpec {
            insetLayoutSpec.insets.top += insets.top
            insetLayoutSpec.insets.left += insets.left
            insetLayoutSpec.insets.bottom += insets.bottom
            insetLayoutSpec.insets.right += insets.right
            
            self = insetSpec
        }
        
        self.layoutElement = ASInsetLayoutSpec(
            insets: insets,
            child: content().layoutElement
        )
    }

    public init(
        content: Content,
        insets: UIEdgeInsets
    ) {
        if let insetSpec = content as? InsetSpec,
           let insetLayoutSpec = insetSpec.layoutElement as? ASInsetLayoutSpec {
            insetLayoutSpec.insets.top += insets.top
            insetLayoutSpec.insets.left += insets.left
            insetLayoutSpec.insets.bottom += insets.bottom
            insetLayoutSpec.insets.right += insets.right
            
            self = insetSpec
        }
        
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
        let insets = UIEdgeInsets(
            top: length,
            left: length,
            bottom: length,
            right: length
        )
        
        return InsetSpec(content: self, insets: insets)
    }
}
