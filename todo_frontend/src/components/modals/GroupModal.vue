<script setup>
import IconAdd from '../icons/IconAdd.vue';

defineProps({
    title: {
        type: String,
        required: true,
    },
    group: {
        type: Object,
        required: false,
    },
});
</script>

<template>
    <div
        @keydown.esc="$emit('close')"
        tabindex="0"
        @vue:mounted="$event.el.focus()"
        class="z-20 fixed top-0 left-0 w-screen h-screen bg-black/60 flex items-center justify-center"
    >
        <div class="z-30 w-128 px-4 py-3 bg-white">
            <!-- Header -->
            <div class="flex items-center px-3 pb-2 border-b border-gray-300">
                <h1 class="text-xl font-semibold">{{ title }}</h1>
                <button @click="$emit('close')" class="ml-auto p-1 rounded-md cursor-pointer transition duration-75 hover:text-black hover:bg-gray-200"><IconAdd class="w-4 rotate-45"/></button>
            </div>
            <!-- Content -->
            <form class="px-1">
                <div class="py-2">
                    <label for="group-name" class="block px-3 py-1 text-xs text-gray-900 font-medium">Name</label>
                    <input
                        id="group-name"
                        type="text"
                        name="name"
                        :value="group?.name"
                        class="w-full border border-gray-400 rounded-md px-2 py-1 text-sm text-gray-700 focus:outline-orange-300"
                        required
                    />
                </div>
                <div class="py-1 flex items-center justify-end gap-4">
                    <button
                        @click="$emit('close')"
                        type="button"
                        class="px-3 py-1 text-orange-300 font-bold rounded cursor-pointer transition duration-75 hover:text-amber-500 hover:underline"
                    >Cancel</button>
                    <button
                        type="submit"
                        class="px-3 py-1 bg-orange-300 text-white font-bold rounded cursor-pointer transition duration-75 hover:bg-amber-500"
                    >Create</button>
                </div>
            </form>
        </div>
    </div>
</template>