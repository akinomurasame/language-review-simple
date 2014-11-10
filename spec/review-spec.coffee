describe "ReVIEW grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-review")

    runs ->
      grammar = atom.syntax.grammarForScopeName("source.review")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.review"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["source.review"]

  it "tokenizes @<b>{bold} text", ->
    {tokens} = grammar.tokenizeLine("@<b>{bold}")
    expect(tokens[0]).toEqual value: "@<b>{", scopes: ["source.review", "markup.bold.review"]
    expect(tokens[1]).toEqual value: "bold", scopes: ["source.review", "markup.bold.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.bold.review"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is @<b>{bo\nld}!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.review"]
    expect(firstLineTokens[1]).toEqual value: "@<b>{", scopes: ["source.review", "markup.bold.review"]
    expect(firstLineTokens[2]).toEqual value: "bo", scopes: ["source.review", "markup.bold.review"]
    expect(secondLineTokens[0]).toEqual value: "ld", scopes: ["source.review", "markup.bold.review"]
    expect(secondLineTokens[1]).toEqual value: "}", scopes: ["source.review", "markup.bold.review"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.review"]

  it "tokenizes @<i>{italic} text", ->
    {tokens} = grammar.tokenizeLine("this is @<i>{italic} text")
    expect(tokens[0]).toEqual value: "this is ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "@<i>{", scopes: ["source.review", "markup.italic.review"]
    expect(tokens[2]).toEqual value: "italic", scopes: ["source.review", "markup.italic.review"]
    expect(tokens[3]).toEqual value: "}", scopes: ["source.review", "markup.italic.review"]
    expect(tokens[4]).toEqual value: " text", scopes: ["source.review"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is @<i>{ita\nlic}!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.review"]
    expect(firstLineTokens[1]).toEqual value: "@<i>{", scopes: ["source.review", "markup.italic.review"]
    expect(firstLineTokens[2]).toEqual value: "ita", scopes: ["source.review", "markup.italic.review"]
    expect(secondLineTokens[0]).toEqual value: "lic", scopes: ["source.review", "markup.italic.review"]
    expect(secondLineTokens[1]).toEqual value: "}", scopes: ["source.review", "markup.italic.review"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.review"]

  it "tokenizes @<strong>{strong} text", ->
    {tokens} = grammar.tokenizeLine("@<strong>{strong}")
    expect(tokens[0]).toEqual value: "@<strong>{", scopes: ["source.review", "markup.strong.review"]
    expect(tokens[1]).toEqual value: "strong", scopes: ["source.review", "markup.strong.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.strong.review"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is @<strong>{str\nong}!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.review"]
    expect(firstLineTokens[1]).toEqual value: "@<strong>{", scopes: ["source.review", "markup.strong.review"]
    expect(firstLineTokens[2]).toEqual value: "str", scopes: ["source.review", "markup.strong.review"]
    expect(secondLineTokens[0]).toEqual value: "ong", scopes: ["source.review", "markup.strong.review"]
    expect(secondLineTokens[1]).toEqual value: "}", scopes: ["source.review", "markup.strong.review"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.review"]

  it "tokenizes @<em>{em} text", ->
    {tokens} = grammar.tokenizeLine("@<em>{em}")
    expect(tokens[0]).toEqual value: "@<em>{", scopes: ["source.review", "markup.em.review"]
    expect(tokens[1]).toEqual value: "em", scopes: ["source.review", "markup.em.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.em.review"]

  it "tokenizes @<kw>{keyword} text", ->
    {tokens} = grammar.tokenizeLine("@<kw>{keyword}")
    expect(tokens[0]).toEqual value: "@<kw>{", scopes: ["source.review", "markup.keyword.review"]
    expect(tokens[1]).toEqual value: "keyword", scopes: ["source.review", "markup.keyword.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.keyword.review"]

    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("this is @<kw>{key\nword}!")
    expect(firstLineTokens[0]).toEqual value: "this is ", scopes: ["source.review"]
    expect(firstLineTokens[1]).toEqual value: "@<kw>{", scopes: ["source.review", "markup.keyword.review"]
    expect(firstLineTokens[2]).toEqual value: "key", scopes: ["source.review", "markup.keyword.review"]
    expect(secondLineTokens[0]).toEqual value: "word", scopes: ["source.review", "markup.keyword.review"]
    expect(secondLineTokens[1]).toEqual value: "}", scopes: ["source.review", "markup.keyword.review"]
    expect(secondLineTokens[2]).toEqual value: "!", scopes: ["source.review"]

  it "tokenizes @<chap>{filename} text", ->
    {tokens} = grammar.tokenizeLine("@<chap>{filename}")
    expect(tokens[0]).toEqual value: "@<chap>{", scopes: ["source.review", "markup.chapter.review"]
    expect(tokens[1]).toEqual value: "filename", scopes: ["source.review", "markup.chapter.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.chapter.review"]

  it "tokenizes @<title>{filename} text", ->
    {tokens} = grammar.tokenizeLine("@<title>{filename}")
    expect(tokens[0]).toEqual value: "@<title>{", scopes: ["source.review", "markup.title.review"]
    expect(tokens[1]).toEqual value: "filename", scopes: ["source.review", "markup.title.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.title.review"]

  it "tokenizes @<chapref>{filename} text", ->
    {tokens} = grammar.tokenizeLine("@<chapref>{filename}")
    expect(tokens[0]).toEqual value: "@<chapref>{", scopes: ["source.review", "markup.chapref.review"]
    expect(tokens[1]).toEqual value: "filename", scopes: ["source.review", "markup.chapref.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.chapref.review"]

  it "tokenizes @<ruby>{base, text}", ->
    {tokens} = grammar.tokenizeLine("@<ruby>{base, text}")
    expect(tokens[0]).toEqual value: "@<ruby>{", scopes: ["source.review", "ruby"]
    expect(tokens[1]).toEqual value: "base", scopes: ["source.review", "ruby", "markup.ruby.base.review"]
    expect(tokens[2]).toEqual value: ", ", scopes: ["source.review", "ruby"]
    expect(tokens[3]).toEqual value: "text", scopes: ["source.review", "ruby", "markup.ruby.text.review"]
    expect(tokens[4]).toEqual value: "}", scopes: ["source.review", "ruby"]

  it "tokenizes @<ami>{ami} text", ->
    {tokens} = grammar.tokenizeLine("@<ami>{ami}")
    expect(tokens[0]).toEqual value: "@<ami>{", scopes: ["source.review", "markup.ami.review"]
    expect(tokens[1]).toEqual value: "ami", scopes: ["source.review", "markup.ami.review"]
    expect(tokens[2]).toEqual value: "}", scopes: ["source.review", "markup.ami.review"]

  it "tokenizes headings", ->
    {tokens} = grammar.tokenizeLine("= Heading 1")
    expect(tokens[0]).toEqual value: "= ", scopes: ["source.review", "markup.heading.heading-1.review"]
    expect(tokens[1]).toEqual value: "Heading 1", scopes: ["source.review", "markup.heading.heading-1.review"]

    {tokens} = grammar.tokenizeLine("== Heading 2")
    expect(tokens[0]).toEqual value: "== ", scopes: ["source.review", "markup.heading.heading-2.review"]
    expect(tokens[1]).toEqual value: "Heading 2", scopes: ["source.review", "markup.heading.heading-2.review"]

    {tokens} = grammar.tokenizeLine("=== Heading 3")
    expect(tokens[0]).toEqual value: "=== ", scopes: ["source.review", "markup.heading.heading-3.review"]
    expect(tokens[1]).toEqual value: "Heading 3", scopes: ["source.review", "markup.heading.heading-3.review"]

    {tokens} = grammar.tokenizeLine("==== Heading 4")
    expect(tokens[0]).toEqual value: "==== ", scopes: ["source.review", "markup.heading.heading-4.review"]
    expect(tokens[1]).toEqual value: "Heading 4", scopes: ["source.review", "markup.heading.heading-4.review"]

    {tokens} = grammar.tokenizeLine("===== Heading 5")
    expect(tokens[0]).toEqual value: "===== ", scopes: ["source.review", "markup.heading.heading-5.review"]
    expect(tokens[1]).toEqual value: "Heading 5", scopes: ["source.review", "markup.heading.heading-5.review"]

  it "tokenizes column", ->
    {tokens, ruleStack} = grammar.tokenizeLine("===[column] title")
    expect(tokens[0]).toEqual value: "===[column] ", scopes: ["source.review", "column", "markup.column.tag.begin.review"]
    expect(tokens[1]).toEqual value: "title", scopes: ["source.review", "column", "markup.column.title.review"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.review", "column"]
    {tokens} = grammar.tokenizeLine("===[/column]", ruleStack)
    expect(tokens[0]).toEqual value: "===[/column]", scopes: ["source.review", "column", "markup.column.tag.end.review"]

  it "tokenizes emlist block", ->
    {tokens, ruleStack} = grammar.tokenizeLine("//emlist{")
    expect(tokens[0]).toEqual value: "//", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[1]).toEqual value: "emlist", scopes: ["source.review", "block", "markup.block.tag.begin.review", "tag-name"]
    expect(tokens[2]).toEqual value: "{", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.review", "block"]
    {tokens} = grammar.tokenizeLine("//}", ruleStack)
    expect(tokens[0]).toEqual value: "//}", scopes: ["source.review", "block", "markup.block.tag.end.review"]

  it "tokenizes source block", ->
    {tokens, ruleStack} = grammar.tokenizeLine("//source[/sample/sample.rb]{")
    expect(tokens[0]).toEqual value: "//", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[1]).toEqual value: "source", scopes: ["source.review", "block", "markup.block.tag.begin.review", "tag-name"]
    expect(tokens[2]).toEqual value: "[", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[3]).toEqual value: "/sample/sample.rb", scopes: ["source.review", "block", "markup.block.tag.begin.review", "identifier"]
    expect(tokens[4]).toEqual value: "]{", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.review", "block"]
    {tokens} = grammar.tokenizeLine("//}", ruleStack)
    expect(tokens[0]).toEqual value: "//}", scopes: ["source.review", "block", "markup.block.tag.end.review"]

  it "tokenizes listnum block", ->
    {tokens, ruleStack} = grammar.tokenizeLine("//listnum[identifier][caption]{")
    expect(tokens[0]).toEqual value: "//", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[1]).toEqual value: "listnum", scopes: ["source.review", "block", "markup.block.tag.begin.review", "tag-name"]
    expect(tokens[2]).toEqual value: "[", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[3]).toEqual value: "identifier", scopes: ["source.review", "block", "markup.block.tag.begin.review", "identifier"]
    expect(tokens[4]).toEqual value: "][", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    expect(tokens[5]).toEqual value: "caption", scopes: ["source.review", "block", "markup.block.tag.begin.review", "caption"]
    expect(tokens[6]).toEqual value: "]{", scopes: ["source.review", "block", "markup.block.tag.begin.review"]
    {tokens, ruleStack} = grammar.tokenizeLine("-> 'hello'", ruleStack)
    expect(tokens[0]).toEqual value: "-> 'hello'", scopes: ["source.review", "block"]
    {tokens} = grammar.tokenizeLine("//}", ruleStack)
    expect(tokens[0]).toEqual value: "//}", scopes: ["source.review", "block", "markup.block.tag.end.review"]

  it "tokenizes @<href>{links, links}", ->
    {tokens} = grammar.tokenizeLine("please click @<href>{website, this link}")
    expect(tokens[0]).toEqual value: "please click ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "@<href>{", scopes: ["source.review", "link"]
    expect(tokens[2]).toEqual value: "website", scopes: ["source.review", "link", "markup.underline.link.review"]
    expect(tokens[3]).toEqual value: ", ", scopes: ["source.review", "link"]
    expect(tokens[4]).toEqual value: "this link", scopes: ["source.review", "link", "entity.review"]
    expect(tokens[5]).toEqual value: "}", scopes: ["source.review", "link"]

  it "tokenizes unordered lists", ->
    {tokens} = grammar.tokenizeLine("*Item 1")
    expect(tokens[0]).not.toEqual value: "*Item 1", scopes: ["source.review", "variable.unordered.list.review"]

    {tokens} = grammar.tokenizeLine("  * Item 1")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "*", scopes: ["source.review", "variable.unordered.list.review"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[3]).toEqual value: "Item 1", scopes: ["source.review"]

  it "tokenizes ordered lists", ->
    {tokens} = grammar.tokenizeLine("1.First Item")
    expect(tokens[0]).toEqual value: "1.First Item", scopes: ["source.review"]

    {tokens} = grammar.tokenizeLine("  1. First Item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "1.", scopes: ["source.review", "variable.ordered.list.review"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[3]).toEqual value: "First Item", scopes: ["source.review"]

    {tokens} = grammar.tokenizeLine("  10. Tenth Item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "10.", scopes: ["source.review", "variable.ordered.list.review"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[3]).toEqual value: "Tenth Item", scopes: ["source.review"]

    {tokens} = grammar.tokenizeLine("  111. Hundred and eleventh item")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: "111.", scopes: ["source.review", "variable.ordered.list.review"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[3]).toEqual value: "Hundred and eleventh item", scopes: ["source.review"]

  it "tokenizes definition lists", ->
    {tokens, ruleStack} = grammar.tokenizeLine(": title")
    expect(tokens[0]).toEqual value: ":", scopes: ["source.review", "variable.definition.list.review"]
    expect(tokens[1]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[2]).toEqual value: "title", scopes: ["source.review", "variable.definition-title.list.review"]
    {tokens, ruleStack} = grammar.tokenizeLine(" : title")
    expect(tokens[0]).toEqual value: " ", scopes: ["source.review"]
    expect(tokens[1]).toEqual value: ":", scopes: ["source.review", "variable.definition.list.review"]
