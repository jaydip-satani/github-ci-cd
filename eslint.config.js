// eslint.config.cjs
const js = require("@eslint/js");

module.exports = [
  js.configs.recommended,
  {
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "commonjs",
      globals: {
        // enable Node + ES2021 globals
        ...require("globals").node,
        ...require("globals").es2021,
      },
    },
    rules: {
      // custom rules here
    },
  },
];
