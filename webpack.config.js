var path = require("path");

module.exports = {
  mode: 'development',
  entry: {
    app: [
      './src/'
    ]
  },
  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: 'index.js',
  },
  module: {
    rules: [{
        test: /\.html$/,
        exclude: /node_modules/,
        use: {
          loader: "file-loader",
          options: {
            name: "[name].[ext]"
          }
        }
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        use: {
          loader: "elm-webpack-loader",
          options: {
            debug: false
          }
        }
      }
    ],

    noParse: /\.elm$/,
  },
  watch: true,
  devServer: {
    historyApiFallback: true,
    inline: true,
    stats: {
      colors: true
    },
  },
};