<script setup>
import { ref } from 'vue';
import Header from './Header.vue';
import Card from '../todo/Card.vue';
import TaskModal from '../todo/TaskModal.vue';

defineProps({
    selectedGroup: {
        type: Object,
        required: true,
    }
})

const cards = [
    {
        title: 'Title',
        date: new Date(Date.parse('2025-02-25T20:48:00.000Z')),
        status: 0,
        description: `
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        `,
    },
    {
        title: 'Title 1',
        date: new Date(Date.parse('2025-02-28T20:48:00.000Z')),
        status: 0,
        description: `
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        `,
    },
    {
        title: 'Title 2',
        date: new Date(Date.parse('2025-02-25T20:48:00.000Z')),
        status: 1,
        description: `
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        `,
    },
    {
        title: 'Title 3',
        date: new Date(Date.parse('2025-02-25T20:48:00.000Z')),
        status: 0,
        description: `
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        `,
    },
    {
        title: 'Title 4',
        date: new Date(Date.parse('2025-02-25T20:48:00.000Z')),
        status: 0,
        description: `
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras elementum leo sit amet magna fermentum tempor. Maecenas luctus augue sit amet dolor molestie, nec ullamcorper lacus viverra. Nunc ac tempus ipsum, ut consectetur tellus. Aenean lacus tortor, hendrerit vel ante sed, tempor porta mi.
        `,
    },
]

let taskModal = ref({
    task: null,
    isVisible: false
});

const newTask = () => {
    taskModal.value.task = null;
    taskModal.value.isVisible = true;
}

const editTask = (task) => {
    taskModal.value.task = task;
    taskModal.value.isVisible = true;
}
</script>
<template>
    <div class="flex flex-col w-full h-full px-6">
        <Header :group-name="selectedGroup.value?.name" :new-task-callback="newTask"></Header>

        <div class="flex flex-wrap content-start gap-4 w-full flex-1 py-4">
            <Card
                v-for="card in cards"
                :title="card.title"
                :date="card.date"
                :status="card.status"
                @click="editTask(card)"
            >
                {{ card.description }}
            </Card>
        </div>
    </div>
    <TaskModal
        v-if="taskModal.isVisible"
        :task="taskModal.task"
        @close="taskModal.isVisible = false"
    />
</template>