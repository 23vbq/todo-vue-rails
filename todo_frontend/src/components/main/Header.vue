<script setup>
defineProps({
    groupName: {
        type: String,
        required: true,
    }
})
</script>

<template>
    <header class="w-full h-14 px-4 py-3 text-2xl text-gray-900 font-semibold border-b-2 border-gray-400">
        {{ groupName }}
    </header>
</template>