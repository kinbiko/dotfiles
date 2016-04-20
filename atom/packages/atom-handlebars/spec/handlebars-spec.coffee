describe 'Handlebars grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('atom-handlebars')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.html.handlebars')

  it 'parses the grammar', ->
    expect(grammar).toBeTruthy()
    expect(grammar.scopeName).toBe 'text.html.handlebars'

  it 'parses helpers', ->
    {tokens} = grammar.tokenizeLine("{{my-helper }}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: 'my-helper ', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'entity.name.function.handlebars']
    expect(tokens[2]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

    {tokens} = grammar.tokenizeLine("{{my-helper class='test'}}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: 'my-helper ', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'entity.name.function.handlebars']
    expect(tokens[2]).toEqual value: 'class', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.other.attribute-name.handlebars', 'meta.tag.template.handlebars', 'entity.other.attribute-name.handlebars']
    expect(tokens[3]).toEqual value: '=', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.other.attribute-name.handlebars', 'meta.tag.template.handlebars']
    expect(tokens[4]).toEqual value: "'", scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'string.quoted.single.handlebars', 'punctuation.definition.string.begin.handlebars']
    expect(tokens[5]).toEqual value: 'test', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'string.quoted.single.handlebars']
    expect(tokens[6]).toEqual value: "'", scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'string.quoted.single.handlebars', 'punctuation.definition.string.end.handlebars']
    expect(tokens[7]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

    {tokens} = grammar.tokenizeLine("{{else}}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: 'else', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'entity.name.function.handlebars']
    expect(tokens[2]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

  it 'parses variables', ->
    {tokens} = grammar.tokenizeLine("{{name}}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: 'name', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars']
    expect(tokens[2]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

    {tokens} = grammar.tokenizeLine("{{> name}}")

    expect(tokens[0]).toEqual value: '{{>', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: ' name', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars']
    expect(tokens[2]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

  it 'parses comments', ->
    {tokens} = grammar.tokenizeLine("{{!-- comment --}}")

    expect(tokens[0]).toEqual value: '{{!--', scopes: ['text.html.handlebars', 'comment.block.handlebars']
    expect(tokens[1]).toEqual value: ' comment ', scopes: ['text.html.handlebars', 'comment.block.handlebars']
    expect(tokens[2]).toEqual value: '--}}', scopes: ['text.html.handlebars', 'comment.block.handlebars']

    {tokens} = grammar.tokenizeLine("{{! comment }}")

    expect(tokens[0]).toEqual value: '{{!', scopes: ['text.html.handlebars', 'comment.block.handlebars']
    expect(tokens[1]).toEqual value: ' comment ', scopes: ['text.html.handlebars', 'comment.block.handlebars']
    expect(tokens[2]).toEqual value: '}}', scopes: ['text.html.handlebars', 'comment.block.handlebars']

  it 'parses block expression', ->
    {tokens} = grammar.tokenizeLine("{{#each person in people}}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: '#', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'punctuation.definition.block.begin.handlebars']
    expect(tokens[2]).toEqual value: 'each', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'entity.name.function.handlebars']
    expect(tokens[3]).toEqual value: ' person', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars']
    expect(tokens[4]).toEqual value: ' in ', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.function.handlebars']
    expect(tokens[5]).toEqual value: 'people', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars']
    expect(tokens[6]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

    {tokens} = grammar.tokenizeLine("{{/if}}")

    expect(tokens[0]).toEqual value: '{{', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: '/', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'punctuation.definition.block.end.handlebars']
    expect(tokens[2]).toEqual value: 'if', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars', 'entity.name.function.handlebars']
    expect(tokens[3]).toEqual value: '}}', scopes: ['text.html.handlebars', 'meta.tag.template.handlebars', 'entity.name.tag.handlebars']

  it 'parses unescaped expressions', ->
    {tokens} = grammar.tokenizeLine("{{{do not escape me}}}")

    expect(tokens[0]).toEqual value: '{{{', scopes: ['text.html.handlebars', 'meta.tag.template.raw.handlebars', 'entity.name.tag.handlebars']
    expect(tokens[1]).toEqual value: 'do not escape me', scopes: ['text.html.handlebars', 'meta.tag.template.raw.handlebars']
    expect(tokens[2]).toEqual value: '}}}', scopes: ['text.html.handlebars', 'meta.tag.template.raw.handlebars', 'entity.name.tag.handlebars']
