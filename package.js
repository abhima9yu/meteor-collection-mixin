Package.describe({
  name: 'abhima9yu:collection-mixin',
  version: '0.0.4_6',
  // Brief, one-line summary of the package.
  summary: "Move collections common code into a separate module which we call collection mixin.",
  // URL to the Git repository containing the source code for this package
  git: 'https://github.com/abhima9yu/meteor-collection-mixin.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function (api) {
  api.versionsFrom('1.5.2.2');
  api.use('ecmascript');
  api.use('dburles:collection-helpers@1.1.0');
  api.use('aldeed:collection2@3.0.0');
  api.use('coffeescript@2.0.0');
  api.use('erasaur:meteor-lodash@4.0.0');
  api.use('mongo@1.9.0');
  api.use('tmeasday:check-npm-versions@0.3.2');
  api.mainModule('collection-mixin.coffee');
});

Package.onTest(function (api) {
  api.versionsFrom('1.5.2.2');
  api.use('ecmascript');
  api.use('dburles:collection-helpers@1.1.0');
  api.use('xolvio:cleaner@0.3.1');
  api.use('aldeed:collection2@3.0.0');
  api.use('coffeescript@2.0.0');
  api.use('erasaur:meteor-lodash@4.0.0');
  api.use('meteortesting:mocha');
  api.use('mongo@1.9.0');
  api.use('tinytest');
  api.use('tmeasday:check-npm-versions');
  api.mainModule('collection-mixin.spec.coffee');
});
