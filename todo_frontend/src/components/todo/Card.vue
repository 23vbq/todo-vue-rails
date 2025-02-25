<script setup>
defineProps({
    title: {
        type: String,
        required: true,
    },
    date: {
        type: Date,
        required: true,
    },
})
</script>

<template>
    <div class="w-100 h-40 flex flex-col border-2 border-gray-600 rounded-lg shadow-lg">
        <h1>{{ title }}</h1>
        <span>{{ date }}</span>
        <hr>
        <div class="h-full text-sm truncate whitespace-normal">
            <slot></slot>
        </div>
    </div>
</template>