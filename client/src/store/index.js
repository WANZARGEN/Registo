import Vue from 'vue'
import Vuex from 'vuex'

import createLogger from '../../../src/plugins/logger'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  modules: {
  },
  strict: debug, //In strict mode, whenever Vuex state is mutated outside of mutation handlers, an error will be thrown. 
  plugins: debug ? [createLogger()] : []
})