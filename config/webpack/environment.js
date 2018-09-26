const { environment } = require('@rails/webpacker')
const { resolve } = require("path")
const eyeglass = require("eyeglass")
const erb =  require('./loaders/erb')
const coffee =  require('./loaders/coffee')

environment.loaders.append('coffee', coffee)
environment.loaders.append('erb', erb)

const sassLoader = environment.loaders.get('sass')
	.use.find(item => item.loader === 'sass-loader')

sassLoader.options = eyeglass(Object.assign({}, sassLoader.options, {
	sourceMap: false,
	sourceComments: true,
	includePaths: [resolve("app", "javascript", "styles")]
}))

module.exports = environment
