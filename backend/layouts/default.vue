<template>
    <div class="min-h-screen bg-gray-50 flex">
        <Sidebar :sidebar-open="sidebarOpen" @close-sidebar="closeSidebar" />
        <div class="flex-1 lg:ml-0">
            <NavBar @sidebar-open="toggleSidebar" />
            <slot />
        </div>

    </div>
</template>

<script setup lang="ts">
const sidebarOpen = ref(false);
const toggleSidebar = (newValue: boolean) => {
        sidebarOpen.value = newValue
}

const closeSidebar = () => {
    sidebarOpen.value = false;
}


</script>