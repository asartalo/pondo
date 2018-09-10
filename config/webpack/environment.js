const { environment } = require('@rails/webpacker')
const erb =  require('./loaders/erb')
const coffee =  require('./loaders/coffee')

environment.loaders.append('coffee', coffee)
environment.loaders.append('erb', erb)
module.exports = environment
