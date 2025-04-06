<script setup>
import { ref } from 'vue';

import NavBar from './components/navigation/NavBar.vue';
import MainView from './components/main/MainView.vue';

let selectedGroup = ref({});

</script>

<template>
<nav>
    <NavBar :selected-group="selectedGroup"></NavBar>
</nav>
<main class="w-full">
    <MainView :selected-group="selectedGroup"></MainView>
</main>
</template>