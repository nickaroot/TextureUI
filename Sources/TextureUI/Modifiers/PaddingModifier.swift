//
//  PaddingModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct PaddingModifier<Content>: LayoutModifier where Content: LayoutElement {

    public var insets: UIEdgeInsets

    init(
        _ insets: UIEdgeInsets
    ) {
        self.insets = insets
    }

    init(
        _ edges: Edge.Set = .all,
        _ length: CGFloat? = nil
    ) {
        let computedLength = length ?? 0

        self.insets = UIEdgeInsets(
            top: edges.contains(.top) ? computedLength : 0,
            left: edges.contains(.left) ? computedLength : 0,
            bottom: edges.contains(.bottom) ? computedLength : 0,
            right: edges.contains(.right) ? computedLength : 0
        )
    }

    init(
        _ length: CGFloat
    ) {
        self.insets = UIEdgeInsets(top: length, left: length, bottom: length, right: length)
    }

    public func modify(content: Content) -> LayoutElement {
        InsetSpec(content: content, insets: insets)
    }
}

extension LayoutElement {
    public func padding(_ insets: UIEdgeInsets) -> some LayoutElement {
        modifier(PaddingModifier<Self>(insets))
    }

    public func padding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some LayoutElement {
        modifier(PaddingModifier<Self>(edges, length))
    }

    public func padding(_ length: CGFloat) -> some LayoutElement {
        modifier(PaddingModifier<Self>(length))
    }
}
