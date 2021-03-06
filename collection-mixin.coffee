{ Mongo } = require 'meteor/mongo'

_.extend(Mongo.Collection.prototype, {
  includeCollectionMixins: (mixins...) ->
    @addHelperToReturnCollection()
    @includeCollectionMixin(mixin) for mixin in mixins

  includeCollectionMixin: (mixin) ->
    @includeMixinSchema(mixin)
    @includeMixinHelpers(mixin)
    @includeMixinCollectionHelpers(mixin)
    @registerCollectionWithMixin(mixin)

  addHelperToReturnCollection: ->
    self = @
    @helpers({collection: -> self})

  includeMixinSchema: (mixin) ->
    @attachSchema(mixin.schema(@)) if mixin.schema

  includeMixinHelpers: (mixin) ->
    @helpers(mixin.helpers) if mixin.helpers

  includeMixinCollectionHelpers: (mixin) ->
    Object.assign(@, mixin.collectionHelpers) if mixin.collectionHelpers

  registerCollectionWithMixin: (mixin) ->
    mixin.registeredCollections ||= []
    unless @ in mixin.registeredCollections
      mixin.registeredCollections.push(@)
})
