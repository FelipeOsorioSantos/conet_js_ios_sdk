const path = require('path')

module.exports = {
    mode: "production",
    entry: { Conet: "./index.js" },
    output: {
        path:  path.resolve(__dirname, "dist"),
        filename: "[name].bundle.js",
        library: "[name]",
        libraryTarget: "var"
    }
};