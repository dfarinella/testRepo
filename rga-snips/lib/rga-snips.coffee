RgaSnipsView = require './rga-snips-view'
{CompositeDisposable} = require 'atom'

module.exports = RgaSnips =
  rgaSnipsView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @rgaSnipsView = new RgaSnipsView(state.rgaSnipsViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @rgaSnipsView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'rga-snips:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @rgaSnipsView.destroy()

  serialize: ->
    rgaSnipsViewState: @rgaSnipsView.serialize()

  toggle: ->
    console.log 'RgaSnips was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
