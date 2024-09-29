<template>

  <h1 class="mb-8">ini dari halaman vue post</h1>
  <Link
    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
    href="/posts/new"
    >New data</Link
  >
  <table class="min-w-full bg-white border border-gray-300 mt-8">
    <thead>
      <tr class="bg-gray-200 text-gray-700">
        <th class="py-3 px-4 border-b">ID</th>
        <th class="py-3 px-4 border-b">Title</th>
        <th class="py-3 px-4 border-b">Body</th>
        <th class="py-3 px-4 border-b">Post Cover</th>
        <th class="py-3 px-4 border-b">File</th>
        
        <th class="py-3 px-4 border-b">Action</th>
      </tr>
    </thead>
    <tbody>
        <tr v-if="posts.length" class="text-center hover:bg-gray-100" v-for="post in posts" :key="post.id">
        <td class="py-2 px-4 border-b">{{ post.id }}</td>
        <td class="py-2 px-4 border-b">{{ post.title }}</td>
        <td class="py-2 px-4 border-b">{{ post.body }}</td>
        <td class="py-2 px-4 border-b">
          <img :src="post.post_cover_url" class="object-cover h-48 w-96" />
        </td>
        <td class="py-2 px-4 border-b">
          <a :href="post.file_url" target="_blank" rel="noopener noreferrer">
    Show File
  </a>
        </td>
        <td class="py-2 px-4 border-b">
          <Link :href="`/posts/${post.id}`"> Show </Link> |
          <Link :href="`/posts/${post.id}/edit`"> Edit </Link> |
          <button @click="deletePost(post.id)">Delete</button>
        </td>
      </tr>
      <tr v-else>
        <td colspan="4" class="text-center">NO DATA</td>
      </tr>
    </tbody>
  </table>
</template>

<script setup>
import { defineProps, ref } from 'vue';
import { Link, router} from '@inertiajs/vue3';

import '@bhplugin/vue3-datatable/dist/style.css'
import Vue3Datatable from "@bhplugin/vue3-datatable";

const props = defineProps({
  posts: Array,
});

console.log(JSON.stringify(props.posts));

// Fungsi untuk menghapus post
const deletePost = (id) => {
  if (confirm("Are you sure you want to delete this post?")) {
    try {
        router.delete(`/posts/${id}`);
        console.log("success");
    }
    catch(e) {
        console.log("error ".e);
    }
    
  }
};


// const cols =
//     ref([
//       { field: "id", title: "ID", width: "90px", filter: false },
//       { field: "title", title: "Title" },
//       { field: "body", title: "Body" },
//       { field: "actions", title: "Action" },
//     ]) || [];

//     const rows = ref([]);

// // Mengisi rows dengan data dari props.posts
// if (props.posts && props.posts.length) {
//   rows.value = props.posts.map(post => ({
//     id: post.id,
//     title: post.title,
//     body: post.body
//   }));
// }


</script>
