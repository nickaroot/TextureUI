//
//  LayoutSpecBuilder.swift
//
//
//  Created by Nikita Arutyunov on 22.12.2021.
//

import AsyncDisplayKit

@resultBuilder
public struct LayoutSpecBuilder {

    // MARK: - Empty

    /// Builds an empty view from a block containing no statements.
    public static func buildBlock() -> Layout { .empty }

    // MARK: - Single

    /// Passes a single node written as a child node through unmodified.
    ///
    /// - Parameter content: Layout Content
    ///
    /// - Returns: Layout
    ///
    /// An example of a single node written as a child node is
    /// `{ ASDisplayNode() }`.
    public static func buildBlock<Content>(_ content: Content) -> Layout
    where Content: LayoutElement {
        .single(content)
    }

    public static func buildOptional<Content>(_ content: Content?) -> Layout
    where Content: LayoutElement {
        content.map { .single($0) } ?? .empty
    }

    /// Provides support for “if” statements in multi-statement closures,
    /// producing an optional view that is visible only when the condition
    /// evaluates to `true`.
    public static func buildIf<Content>(_ content: Content?) -> Layout?
    where Content: LayoutElement {
        content.map { .single($0) }
    }

    /// Provides support for "if" statements in multi-statement closures,
    /// producing conditional content for the "then" branch.
    public static func buildEither<TrueContent, FalseContent>(
        first: TrueContent
    ) -> ConditionalContent<TrueContent, FalseContent>
    where TrueContent: LayoutElement, FalseContent: LayoutElement {
        ConditionalContent<TrueContent, FalseContent>(.trueContent(first))
    }

    public static func buildEither(first component: Layout) -> Layout {
        component
    }

    /// Provides support for "if-else" statements in multi-statement closures,
    /// producing conditional content for the "else" branch.
    public static func buildEither<TrueContent, FalseContent>(
        second: FalseContent
    ) -> ConditionalContent<TrueContent, FalseContent>
    where TrueContent: LayoutElement, FalseContent: LayoutElement {
        ConditionalContent<TrueContent, FalseContent>(.falseContent(second))
    }

    public static func buildEither(second component: Layout) -> Layout {
        component
    }

    public static func buildExpression<Content>(_ expression: Content) -> Layout
    where Content: LayoutElement {
        .single(expression)
    }

    public static func buildExpression<Content>(_ expression: Content?) -> Layout
    where Content: LayoutElement {
        expression.map { .single($0) } ?? .empty
    }

    // MARK: - Composite

    @_disfavoredOverload
    public static func buildBlock<Content>(_ contents: Content...) -> Layout
    where Content: LayoutElement {
        .composite(contents)
    }

    @_disfavoredOverload
    public static func buildBlock<Content>(_ contents: Content?...) -> Layout
    where Content: LayoutElement {
        .composite(contents.compactMap { $0 })
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension LayoutSpecBuilder {
    /// Provides support for "if" statements with `#available()` clauses in
    /// multi-statement closures, producing conditional content for the "then"
    /// branch, i.e. the conditionally-available branch.
    public static func buildLimitedAvailability<Content>(_ content: Content) -> Layout
    where Content: LayoutElement {
        .single(content)
    }
}
