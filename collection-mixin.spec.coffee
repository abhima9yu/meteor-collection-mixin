{ resetDatabase } = require 'meteor/xolvio:cleaner'
{ expect } = require 'chai'

{ Mongo } = require 'meteor/mongo'
SimpleSchema = require 'simpl-schema'

require './collection-mixin.coffee'

# Test mixin
testMixin = {
  schema: (collection)->
    new SimpleSchema
      "sample":
        type: String
        optional: true

  helpers:
    mixinHelperMethod: -> true

  collectionHelpers:
    mixinCollectionHelperMethod: -> true
}

otherTestMixin = {
  helpers:
    mixinHelperMethod: -> false
  collectionHelpers:
    mixinCollectionHelperMethod: -> false
}

exports.testMixin = testMixin

# Test schema
TestSchema = new Mongo.Collection('test')
TestSchema.includeCollectionMixins(testMixin)

describe 'mongoCollectionExtension', ->
  beforeEach ->
    resetDatabase()
    TestSchema.insert({"sample": 'Gurgaon' })

  describe 'includeCollectionMixins', ->
    it 'should include mixins fields in the schema', ->
      testSchema = TestSchema.findOne({})
      expect(testSchema.hasOwnProperty('sample')).to.eq(true)

    it 'should include mixins helpers', ->
      testSchema = TestSchema.findOne({})
      expect(typeof testSchema.mixinHelperMethod == 'function').to.eq(true)

    it 'should add collection helpers', ->
      expect(TestSchema.hasOwnProperty('mixinCollectionHelperMethod')).to.eq(true)

    it 'should override helper method which returns collection of the document', ->
      testSchema = TestSchema.findOne()
      expect(testSchema.collection()).to.eql(TestSchema)

    it 'should register collection with the mixin', ->
      expect(testMixin.registeredCollections).to.include(TestSchema)

  describe 'includeMixinSchema', ->
    it 'should add the field from mixin to the collection schema', ->
      testSchema = TestSchema.findOne({})
      expect(testSchema.hasOwnProperty('sample')).to.eq(true)

  describe 'includeMixinHelpers', ->
    it 'should add the helpers to the document helpers', ->
      testSchema = TestSchema.findOne({})
      expect(typeof testSchema.mixinHelperMethod == 'function').to.eq(true)

    context 'when the helper is already defined', ->
      it 'should override that helper method', ->
        testSchema = TestSchema.findOne({})
        expect(testSchema.mixinHelperMethod()).to.eq(true)
        TestSchema.includeMixinHelpers(otherTestMixin)
        testSchema = TestSchema.findOne({})
        expect(testSchema.mixinHelperMethod()).to.eq(false)

  describe 'includeMixinCollectionHelpers', ->
    it 'should add the collection helpers to the collection helpers', ->
      expect(TestSchema.hasOwnProperty('mixinCollectionHelperMethod')).to.eq(true)

  describe 'registerCollectionWithMixin', ->
    it 'should add collection to the mixins registered collection list', ->
      expect(testMixin.registeredCollections).to.include(TestSchema)

    context 'when collection helper is already defined', ->
      it 'should override that helper method', ->
        expect(TestSchema.mixinCollectionHelperMethod()).to.eq(true)
        TestSchema.includeMixinCollectionHelpers(otherTestMixin)
        expect(TestSchema.mixinCollectionHelperMethod()).to.eq(false)

