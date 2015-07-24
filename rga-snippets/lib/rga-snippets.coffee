RgaSnippetsView = require './rga-snippets-view'
{CompositeDisposable} = require 'atom'

module.exports = RgaSnippets =
  rgaSnippetsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rgaSnippetsView = new RgaSnippetsView(state.rgaSnippetsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rgaSnippetsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rga-snippets:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rgaSnippetsView.destroy()

  serialize: ->
    rgaSnippetsViewState: @rgaSnippetsView.serialize()

  toggle: ->
    console.log 'RgaSnippets was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
