import path from 'node:path';
import url from 'node:url';
import webpack from 'webpack';
import ESLintPlugin from 'eslint-webpack-plugin';

const __filename = url.fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default {
  mode: "development",
  devtool: "source-map",
  entry: {
    application: "./app/javascript/application.js",
  },
  module: {
    rules: [
      {
        test: /\.pug$/,
        loader: 'pug-loader'
      },
      {
        test: /\.[mc]?js$/,
        exclude: /\/node_modules\//,
        loader: 'babel-loader'
      }
    ],
  },
  output: {
    filename: "[name].js",
    sourceMapFilename: "[file].map",
    path: path.resolve(__dirname, "app/assets/builds"),
  },
  plugins: [
    new webpack.optimize.LimitChunkCountPlugin({
      maxChunks: 1
    }),
    new ESLintPlugin(),
  ],
};
