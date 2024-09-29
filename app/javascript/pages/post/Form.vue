<template>
   <h1>{{ props.post ? 'Edit Post' : 'Create New Post' }}</h1>
   
    <form @submit.prevent="submit" class="max-w-lg mx-auto p-4 bg-white rounded shadow-md">
      <div class="mb-4">
        <label for="title" class="block text-gray-700 text-sm font-bold mb-2">Title</label>
        <input
          type="text"
          v-model="form.title"
          id="title"
          
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        />
      </div>
  
      <div class="mb-4">
        <label for="body" class="block text-gray-700 text-sm font-bold mb-2">Body</label>
        <textarea
          v-model="form.body"
          id="body"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        ></textarea>
      </div>

      <div class="mb-4">
        <label for="title" class="block text-gray-700 text-sm font-bold mb-2">Cover post (only image extension)</label>
        <input
          type="file"
          @change="handleFileChange"
          id="file"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        />
        <div v-if="props.post">
          <img :src="post.post_cover_url" class="object-cover h-48 w-96" />
        </div>
      </div>


      <div class="mb-4">
        <label for="title" class="block text-gray-700 text-sm font-bold mb-2">File post (only file extension)</label>
        <input
          type="file"
          @change="handleFileCoverChange"
          id="file"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        />
      </div>

      <div class="mb-4">
        <label for="title" class="block text-gray-700 text-sm font-bold mb-2">Multiple file (can multiple file)</label>
        <input
          multiple
          type="file"
          @change="handleMultipleFilesChange"
          id="file"
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
        />
      </div>

  
      <div class="flex items-center justify-between">
        <button
          type="submit"
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
        >
        {{ props.post ? 'Update' : 'Create' }}
        </button>
      </div>

      
    </form>

  
    <div v-if="errors && Object.keys(errors).length" class="text-red-500">
      <h2>Kesalahan:</h2>
      <ul>
        <li v-for="(error, index) in errors" :key="index">{{ error[0] }}</li>
      </ul>
    </div>

  </template>


<script setup>
import { reactive, toRefs, computed } from 'vue'
import { router } from '@inertiajs/vue3'
import Vue3Datatable from '@bhplugin/vue3-datatable'

// Accepting props, including errors
const props = defineProps({
  post: Object,
  recent: Object,
  errors: {
    type: Object,
    default: () => ({}), // Ensure a default empty object for errors
  },
})

console.log(JSON.stringify(props.post, null, 2)); 
// Reactive form state
const form = reactive({
  title: props.post ? props.post.title : props.recent ? props.recent.title : '',
  body: props.post ? props.post.body : props.recent ? props.recent.body : '',
  slug: '',
  post_cover: props.post ? props.post.post_cover : props.recent ? props.recent.post_cover : '',
  file_cover: '',
  multiple_files: '',
})

const handleFileChange = (event) => {
  const file = event.target.files[0]; // Ambil file pertama yang diunggah
  form.post_cover = file; // Set file ke form
  console.log(file); // Debugging: cek file yang diunggah
};


const handleFileCoverChange = (event) => {
  form.file_cover = event.target.files[0] || null;
};

// Handler untuk multiple file input ketiga
const handleMultipleFilesChange = (event) => {
  form.multiple_files = Array.from(event.target.files); // Mengubah FileList menjadi array
};



const submit = () => {
  const formData = new FormData();

  // Masukkan semua field form ke FormData
  formData.append('post[title]', form.title);
  formData.append('post[body]', form.body);
  formData.append('post[file_cover]', form.file_cover);
  form.multiple_files.forEach((file, index) => {
    formData.append(`post[multiple_files][]`, file); // Gunakan [] untuk mengindikasikan array
  });

  if (form.post_cover) {
    formData.append('post[post_cover]', form.post_cover);
  }
  

  if (props.post) {
    // Mengirim permintaan PUT untuk update
    router.put(`/posts/${props.post.id}`, formData, {
      forceFormData: true // Pastikan menggunakan multipart/form-data
    });
  } else {
    // Mengirim permintaan POST untuk create
    router.post('/posts', formData, {
      forceFormData: true // Pastikan menggunakan multipart/form-data
    });
  }
};


const isEditing = toRefs(!!props.post); 


function createSlug() {
  form.slug = form.title.replace(/\s+/g, '-');
}



</script>