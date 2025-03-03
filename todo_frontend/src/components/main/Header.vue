<script setup>
import IconAdd from '../icons/IconAdd.vue';

defineProps({
    groupName: {
        type: String,
        required: true,
    }
})
</script>

<template>
    <header class="w-full flex items-center h-14 px-4 py-3  border-b-2 border-gray-400">
        <h1 class="text-2xl text-gray-900 font-bold">{{ groupName }}</h1>

        <button
            class="ml-auto px-3 py-1 flex items-center gap-1 text-orange-300 font-semibold rounded-md border-2 border-orange-300
            transition duration-75 cursor-pointer hover:bg-orange-300 hover:text-white"
        >
            <IconAdd class="w-3"/>
            Add task
        </button>
    </header>
</template>