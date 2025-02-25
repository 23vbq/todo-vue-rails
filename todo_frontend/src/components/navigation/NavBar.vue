<script setup>
import IconSettings from '../icons/IconSettings.vue';

import Group from './Group.vue';
</script>

<template>
  <div class="flex flex-col w-3xs min-h-screen border-r-2 border-gray-400">
    <header class="px-4 py-2 bg-orange-300 text-white text-2xl font-bold">
      ToDo
    </header>

    <div class="flex flex-col flex-1 px-3 py-2">
      <h1 class="text-gray-900 font-semibold px-2 pb-2 border-b border-gray-400">Groups</h1>
      <ul>
        <Group name="Group 1" color="red" active="true"></Group>
        <Group name="Group 2" color="#13ad75"></Group>
        <Group name="Group 3"></Group>
      </ul>

      <button class="flex items-center mt-auto w-full gap-3 px-3 py-2 font-semibold rounded cursor-pointer transition duration-75 hover:bg-gray-300 hover:text-black">
        <div class="w-4"><IconSettings></IconSettings></div>
        Settings
      </button>
    </div>

  </div>
</template>