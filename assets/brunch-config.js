exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js",

      // To use a separate vendor.js bundle, specify two files path
      // https://github.com/brunch/brunch/blob/master/docs/config.md#files
      // joinTo: {
      //  "js/app.js": /^(js)/,
      //  "js/vendor.js": /^(vendor)|(deps)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // https://github.com/brunch/brunch/tree/master/docs#concatenation
      order: {
        before: [
          "js/jquery.min.js",
          "js/bootstrap.min.js",
          "js/trumbowyg.min.js",
          "js/parsley.min.js"       
        ],
        after: [
          "js/script-parsley.js",
          "js/script-trumb.js",
          "js/script.js"
        ]
      }
    },
    stylesheets: {
      joinTo: "css/app.css",
      order: {
        before: [
          "css/normalize.css",
          "css/milligram.min.css",
          "css/pure.min.css",
          "css/ionicons.min.css",
          "css/pure-sans.css",
          "css/pure-sans-condensed.css"       
        ],
        after: [
          "css/parsley.css",
          "css/trumbowyg.min.css",
          "css/style.css"
        ]
      }
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true
  }
};
