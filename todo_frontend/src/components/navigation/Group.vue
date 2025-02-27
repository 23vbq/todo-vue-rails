<script setup>
import IconDot from '../icons/IconDot.vue';

defineProps({
    name: {
        type: String,
        required: true,
    },
    color: {
        type: String,
        required: false,
    },
    active: {
        type: Object,
        required: false,
    },
})
</script>

<template>
    <li
        class="w-full mt-1 p-1 flex items-center text-sm rounded cursor-pointer transition duration-75 hover:bg-gray-200 hover:text-black"
        :class="active?.value ? 'bg-orange-300 text-white font-medium hover:bg-orange-400 hover:text-white' : null"
    >
        <div class="w-4 mr-2" :style="color ? {'color': color} : null"><IconDot></IconDot></div>
        {{ name }}
    </li>
</template>