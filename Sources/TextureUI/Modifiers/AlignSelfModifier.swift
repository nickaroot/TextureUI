//
//  AlignSelfModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct AlignSelfModifier<Content>: LayoutModifier where Content: LayoutElement {
    public let alignSelf: ASStackLayoutAlignSelf

    public init(
        alignSelf: ASStackLayoutAlignSelf
    ) {
        self.alignSelf = alignSelf
    }

    public func modify(content: Content) -> LayoutElement {
        content.style.alignSelf = alignSelf

        return content
    }
}

extension LayoutElement {
    public func alignSelf(_ value: ASStackLayoutAlignSelf) -> some LayoutElement {
        modifier(AlignSelfModifier<Self>(alignSelf: value))
    }
}
