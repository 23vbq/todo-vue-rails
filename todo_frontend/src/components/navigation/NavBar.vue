<script setup>
import { ref } from 'vue';

import IconSettings from '../icons/IconSettings.vue';
import IconAdd from '../icons/IconAdd.vue';

import Group from './Group.vue';
import GroupModal from '../modals/GroupModal.vue';

const props = defineProps({
    selectedGroup: {
        type: Object,
        required: true,
    }
})

const groups = [
    {
        id: 1,
        name: 'Group 1',
        color: 'red',
        active: ref(false),
    },
    {
        id: 2,
        name: 'Group 2',
        color: '#13ad75',
        active: ref(false),
    },
    {
        id: 3,
        name: 'Group 3',
        active: ref(false),
    },
]

const selectGroup = (toSelect) => {
    groups.forEach(group => { group.active.value = false });

    toSelect.active.value = true;
    props.selectedGroup.value = toSelect;
}

let showGroupModal = ref(false);
</script>

<template>
  <div class="flex flex-col w-3xs min-h-screen border-r-2 border-gray-400">
    <header class="px-4 py-2 bg-orange-300 text-white text-2xl font-bold">
      ToDo
    </header>

    <div class="flex flex-col flex-1 px-3 py-2">
        <div class="flex items-center font-semibold px-2 pb-1 border-b border-gray-400">
            <h1 class="text-gray-900">Groups</h1>
            <button
                @click="showGroupModal = true"
                class="ml-auto w-3 text-gray-600 cursor-pointer transition duration-75 hover:text-black"
            ><IconAdd/></button>
        </div>
        <ul>
            <Group
                v-for="group in groups"
                :name="group.name"
                :color="group.color"
                :active="group?.active"
                @click="selectGroup(group)"
            />
        </ul>

        <button class="flex items-center mt-auto w-full gap-3 px-3 py-2 font-semibold rounded cursor-pointer transition duration-75 hover:bg-gray-300 hover:text-black">
            <div class="w-4"><IconSettings></IconSettings></div>
            Settings
        </button>
    </div>

  </div>
  <GroupModal v-if="showGroupModal" @close="showGroupModal = false"/>
</template>