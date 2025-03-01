<script setup>
import IconDot from '../icons/IconDot.vue';
import IconEdit from '../icons/IconEdit.vue';

defineProps({
    group: {
        type: Object,
        required: true,
    },
    editGroup: {
        type: Function,
        required: true,
    },
})
</script>

<template>
    <li
        class="w-full mt-1 p-1 flex items-center text-sm rounded cursor-pointer transition duration-75 group"
        :class="group.active?.value ? 'bg-orange-300 text-white font-medium hover:bg-orange-400 hover:text-white' : 'text-gray-700 hover:bg-gray-200 hover:text-black'"
    >
        <div class="w-4 mr-2" :style="group.color ? {'color': group.color} : null"><IconDot></IconDot></div>
        {{ group.name }}
        <button
            @click="editGroup(group, $event)"
            class="ml-auto w-5 h-5 flex items-center justify-center opacity-0 rounded cursor-pointer
            transition duration-100 group-hover:opacity-100"
            :class="group.active?.value ? 'text-white hover:text-orange-200' : 'text-gray-700 hover:text-black'"
        ><IconEdit class="w-4"/></button>
    </li>
</template>