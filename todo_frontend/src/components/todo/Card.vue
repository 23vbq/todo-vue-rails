<script setup>
import IconClock from '../icons/IconClock.vue';

const props = defineProps({
    title: {
        type: String,
        required: true,
    },
    date: {
        type: Date,
        required: true,
    },
    status: {
        type: Number,
        required: true
    },
});

const getCardState = () => {
    if (props.status == 1) {
        return 'finished';
    }
    if (props.status == 0) {
        const currentDate = new Date();
        if (props.date < currentDate) {
            return 'overdue';
        }
        return 'normal';
    }
}

const cardState = getCardState();

const formatDate = (date) => {
    console.log(date);
    return `${String(date.getDate()).padStart(2, '0')}.${String(date.getMonth() + 1).padStart(2, '0')}.${date.getFullYear()} ${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`
}
</script>

<template>
    <div 
        class="
        w-100 h-50 px-3 py-2 flex flex-col border-2 rounded-lg shadow-lg
        transition duration-200
        cursor-pointer hover:scale-105 hover:shadow-gray-300 hover:outline-1 
        "
        :class="
        cardState == 'finished' ? 'border-lime-700 outline-lime-700 shadow-lime-100' :
        cardState == 'overdue' ? 'border-rose-600 outline-rose-600 bg-rose-50 shadow-rose-100' :
        'border-gray-600 outline-gray-600'"
    >
        <h1 class="text-xl font-bold text-gray-900">{{ title }}</h1>
        <div class="flex items-center gap-1" :class="cardState == 'overdue' && 'text-red-600'">
            <div class="w-4"><IconClock></IconClock></div>
            <span class="py-1" :class="cardState == 'overdue' ? 'font-bold' : 'font-medium'">{{ formatDate(date) }}</span>
        </div>
        <hr>
        <div class="py-2 h-full text-sm text-gray-800 truncate whitespace-normal">
            <slot/>
        </div>
    </div>
</template>