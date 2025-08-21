<template>
    <!-- Header -->
    <header class="bg-white shadow-sm border-b border-gray-200">
        <div class="flex items-center justify-between px-4 py-4 sm:px-6 lg:px-8">
            <div class="flex items-center space-x-4">
                <!-- Mobile menu button -->
                <button @click="toggleSidebar()"
                    class="lg:hidden p-2 rounded-md text-gray-400 hover:text-gray-500 hover:bg-gray-100">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
                <h1 class="text-2xl font-bold text-gray-900">{{ layoutProps }}</h1>
            </div>
        </div>
    </header>
</template>

<script setup lang="ts">
const sidebarOpen = ref(false);

const emit = defineEmits(['sidebarOpen']);

const toggleSidebar = () => {
    sidebarOpen.value = !sidebarOpen.value;
    emit('sidebarOpen', sidebarOpen.value);
}

const route = useRoute();
let layoutProps = ref<any>(route.meta.name);


watch(route, (newValue: any) => {
    layoutProps.value = newValue.meta.name;

})

</script>