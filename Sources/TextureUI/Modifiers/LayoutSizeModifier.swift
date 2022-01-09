//
//  LayoutSizeModifier.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import Foundation

public struct LayoutSizeModifier<Content>: LayoutModifier where Content: LayoutElement {
    public enum Spec {
        case preferred
        case min
        case max
    }

    public let spec: Spec

    public let width: ASDimension?
    public let height: ASDimension?

    public init(
        spec: Spec,
        size: ASLayoutSize
    ) {
        self.spec = spec
        self.width = size.width
        self.height = size.height
    }

    public init(
        spec: Spec,
        width: ASDimension? = nil,
        height: ASDimension? = nil
    ) {
        self.spec = spec
        self.width = width
        self.height = height
    }

    public func modify(content: Content) -> LayoutElement {
        switch spec {

        case .preferred:
            width.map { content.style.preferredLayoutSize.width = $0 }
            height.map { content.style.preferredLayoutSize.height = $0 }

        case .min:
            width.map { content.style.minLayoutSize.width = $0 }
            height.map { content.style.minLayoutSize.height = $0 }

        case .max:
            width.map { content.style.maxLayoutSize.width = $0 }
            height.map { content.style.maxLayoutSize.height = $0 }

        }

        return content
    }
}

extension LayoutElement {

    // MARK: - Preferred

    public func preferredLayoutSize(_ value: ASLayoutSize) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .preferred, size: value))
    }
    public func preferredLayoutWidth(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .preferred, width: value))
    }
    public func preferredLayoutHeight(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .preferred, height: value))
    }

    // MARK: - Min

    public func minLayoutSize(_ value: ASLayoutSize) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .min, size: value))
    }
    public func minLayoutWidth(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .min, width: value))
    }
    public func minLayoutHeight(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .min, height: value))
    }

    // MARK: - Max

    public func maxLayoutSize(_ value: ASLayoutSize) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .max, size: value))
    }
    public func maxLayoutWidth(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .max, width: value))
    }
    public func maxLayoutHeight(_ value: ASDimension) -> some LayoutElement {
        modifier(LayoutSizeModifier<Self>(spec: .max, height: value))
    }
}
