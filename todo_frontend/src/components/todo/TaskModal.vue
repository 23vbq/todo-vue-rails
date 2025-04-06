<script setup>
import { onMounted } from 'vue';

import { Calendar } from 'vanilla-calendar-pro';
import 'vanilla-calendar-pro/styles/index.css';

import IconAdd from '../icons/IconAdd.vue';
import IconClock from '../icons/IconClock.vue';
import IconEdit from '../icons/IconEdit.vue';

const props = defineProps({
    task: {
        type: Object,
        required: true,
    }
});

let taskDateCalendar;

onMounted(() => {
    taskDateCalendar = new Calendar('#task-modal-date', {
        inputMode: true,
        selectionTimeMode: 24,
        positionToInput: 'auto',
        styles: {
            calendar: 'vc z-30',
        },
        selectedTheme: 'light',
        onChangeToInput(self) {
            if (!self.context.inputElement) return;
            if (self.context.selectedDates[0]) {
                self.context.inputElement.value = self.context.selectedDates[0] + ' ' + self.context.selectedTime;
                self.hide();
            } else {
                self.context.inputElement.value = '';
            }
            saveTask();
        },
    });
    // taskDateCalendar.set();
    taskDateCalendar.init();
});

const formatDate = (date) => {
    return `${String(date.getDate()).padStart(2, '0')}.${String(date.getMonth() + 1).padStart(2, '0')}.${date.getFullYear()} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`
}

const saveTask = () => {
    const title = document.getElementById('task-modal-title').innerHTML;
    const date = document.getElementById('task-modal-date').value;
    const description = document.getElementById('task-modal-description').innerHTML;

    props.task.title = title;
    props.task.description = description;
    console.log(date);
}
</script>

<template>
    <div
        @keydown.esc="$emit('close')"
        tabindex="0"
        @vue:mounted="$event.el.focus()"
        class="z-20 fixed top-0 left-0 w-screen h-screen bg-black/60 flex items-center justify-center"
    >
        <div class="z-30 w-2/3 px-4 py-3 bg-white">
            <!-- Header -->
            <div class="flex items-center">
                <h1
                    id="task-modal-title"
                    class="text-2xl px-3 pb-1 font-semibold w-1/2 rounded-md border-b border-white
                    transition duration-75 hover:bg-gray-100 focus:outline-0 focus:text-black focus:border-gray-900" 
                    contenteditable="true" spellcheck="false"
                    @keyup="saveTask()"
                >{{ task?.title }}</h1>
                <button @click="$emit('close')" class="ml-auto p-1 rounded-md cursor-pointer transition duration-75 hover:text-black hover:bg-gray-200"><IconAdd class="w-4 rotate-45"/></button>
            </div>
            <!-- Date -->
            <div class="w-fit flex items-center gap-2 px-3 pb-1 text-lg rounded transition duration-75 hover:bg-gray-100 group" :class="cardState == 'overdue' && 'text-red-600'">
                <div class="w-4"><IconClock></IconClock></div>
                <span class="py-1" :class="cardState == 'overdue' ? 'font-bold' : 'font-medium'">{{ task?.date ? formatDate(task.date) : '' }}</span>
                <button
                    @click="taskDateCalendar.show()"
                    class="w-5 h-5 flex items-center justify-center opacity-0 rounded cursor-pointer
                    transition duration-100 group-hover:opacity-100 hover:text-black"
                ><IconEdit class="w-4"/></button>
                <input
                    id="task-modal-date"
                    type="text"
                    class="opacity-0 w-0 pointer-events-none"
                    :value="task?.date"
                />
            </div>
            <!-- Description -->
            <div
                id="task-modal-description"
                class="my-2 px-3 py-2 min-h-40 text-justify border-b border-gray-400 rounded-md
                transition duration-75 focus:outline-0 hover:bg-gray-100 focus:text-black focus:border-gray-900"
                contenteditable="true"
                spellcheck="false"
                @keyup="saveTask()"
            >
                {{ task?.description }}
            </div>
            <!-- Button -->
            <!-- <div class="py-1 flex items-center justify-end gap-4">
                    <button
                        @click="$emit('close')"
                        type="button"
                        class="px-3 py-1 text-orange-300 font-bold rounded cursor-pointer transition duration-75 hover:text-amber-500 hover:underline"
                    >Cancel</button>
                    <button
                        type="submit"
                        class="px-3 py-1 bg-orange-300 text-white font-bold rounded cursor-pointer transition duration-75 hover:bg-amber-500"
                    >Create</button>
                </div> -->
        </div>
    </div>

</template>