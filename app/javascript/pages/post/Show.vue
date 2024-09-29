<template>
  <div
    class="relative flex min-h-screen flex-col justify-center overflow-hidden bg-gray-50 py-6 sm:py-12"
  >
    <div
    >
      <span
        class="absolute top-10 z-0 h-20 w-20 rounded-full bg-sky-500 transition-all duration-300"
      ></span>
      <div class="relative z-10 mx-auto max-w-md">
        <span
          class="grid h-20 w-20 place-items-center rounded-full bg-sky-500 transition-all duration-300"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            fill="none"
            viewBox="0 0 24 24"
            stroke-width="1.5"
            stroke="currentColor"
            class="h-10 w-10 text-white transition-all"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M8.625 9.75a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H8.25m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0H12m4.125 0a.375.375 0 11-.75 0 .375.375 0 01.75 0zm0 0h-.375m-13.5 3.01c0 1.6 1.123 2.994 2.707 3.227 1.087.16 2.185.283 3.293.369V21l4.184-4.183a1.14 1.14 0 01.778-.332 48.294 48.294 0 005.83-.498c1.585-.233 2.708-1.626 2.708-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z"
            />
          </svg>
        </span>
        <div
          class="space-y-6 pt-5 text-base leading-7 text-gray-600 transition-all duration-300 group-hover:text-white/90"
        >
          <p>Title : {{ post.title }}</p>
          <p>Title : {{ post.body }}</p>
          <div v-if="post.multiple_file_urls && post.multiple_file_urls.length">
      <ul>
        <li v-for="(file, index) in post.multiple_file_urls" :key="index">
          <template v-if="isImage(file)">
            <img :src="file" alt="Uploaded Image" class="uploaded-image" />
          </template>
          <template v-else>
            <p>File: <a :href="file" target="_blank">show file</a>, Ekstensi: {{ getFileExtension(file) }}</p>
          </template>
        </li>
      </ul>
    </div>
    <div v-else>
      <p>Tidak ada file yang diunggah.</p>
    </div>
          <!-- Tampilkan pesan jika tidak ada file -->
          <div v-else>
            <p>Tidak ada file yang diunggah.</p>
          </div>
        </div>
        <div class="pt-5 text-base font-semibold leading-7">
          <p>
            <Link
              :href="`/posts`"
              class="text-sky-500 transition-all duration-300 group-hover:text-white"
              >Back to index
            </Link>
          </p>
        </div>
      </div>
    </div>
  </div>
  <!-- https://play.tailwindcss.com/eCfibrSI2X -->
</template>

<script setup>
import { reactive, toRefs } from "vue";
import { Link } from "@inertiajs/vue3";

const props = defineProps({
  post: Object,
});

const isImage = (fileUrl) => {
  const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff'];
  const extension = fileUrl.split('.').pop().toLowerCase();
  return imageExtensions.includes(`.${extension}`);
};

const getFileExtension = (fileUrl) => {
  return fileUrl.split('.').pop().toLowerCase();
};


console.log(JSON.stringify(props.post, null, 2));
</script>
