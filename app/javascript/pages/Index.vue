<template>
    <div>
      <h1 class="font-bold">Halaman Home Vue</h1>
      <h2>{{ time_now }}</h2> <!-- Display the time passed from Rails -->
      <Link href="/inertia-example">other page</Link>
    </div>
  </template>
  
  <script>
  import { Link } from '@inertiajs/vue3';
  
  export default {
    components: {
      Link, // Register the Link component
    },
    props: {
      time_now: String, // Declare the prop to receive time
    },
    methods: {
      showTime() {
        // Optionally use this method if you want to get the current time client-side
        const datenow = new Date();
        return datenow.toLocaleTimeString();
      }
    }
  }
  </script>
  