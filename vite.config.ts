// import vue from '@vitejs/plugin-vue'
// import { defineConfig } from 'vite'
// import RubyPlugin from 'vite-plugin-ruby'

// export default defineConfig({
//   plugins: [
//     vue(),
//     RubyPlugin(),
//   ],
// })

// vite.config.js
import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import FullReload from 'vite-plugin-full-reload'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [
    RubyPlugin(),
    FullReload(['config/routes.rb', 'app/views/*/**', 'app/frontend/*/**'], { delay: 200}),
    vue(),
  ],
})