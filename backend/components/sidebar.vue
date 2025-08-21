<template>
    <!-- Mobile Overlay -->
    <div v-if="sidebarOpen" class="fixed inset-0 bg-gray-50 bg-opacity-50 z-10 lg:hidden" @click="toggleSidebar"></div>
    <div class="fixed inset-y-0 left-0 z-50 w-64 bg-white shadow-lg transform transition-transform duration-300 ease-in-out lg:translate-x-0 lg:static lg:inset-0"
        :class="sidebarOpen ? 'translate-x-0' : '-translate-x-full'">
        <!-- Logo -->
        <div  class="flex items-center space-x-3 p-6 border-b border-gray-200 cursor-pointer" @click="sendToHomepage">
            <div class="w-8 h-8 bg-blue-600 rounded-md flex items-center justify-center">
                <span class="text-white font-bold text-sm">R</span>
            </div>
            <span class="text-xl font-semibold text-gray-900">ReceiptTracker</span>
        </div>

        <!-- Navigation -->
        <nav class="mt-6">
            <div class="px-3">
                <NuxtLink to="/dashboard" class="flex items-center space-x-3  px-3 py-2 rounded-lg mb-1" :class="{
                    'text-blue-600 bg-blue-50 ': currentRoute === '/dashboard'
                }">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="7" height="7"></rect>
                        <rect x="14" y="3" width="7" height="7"></rect>
                        <rect x="14" y="14" width="7" height="7"></rect>
                        <rect x="3" y="14" width="7" height="7"></rect>
                    </svg>
                    <span :class="{
                        'font-medium': currentRoute === '/dashboard'
                    }">Dashboard</span>
                </NuxtLink>

                <NuxtLink to="/receipts"
                    class="flex items-center space-x-3 px-3 py-2 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg mb-1"
                    :class="{
                        '!text-blue-600 !bg-blue-50 ': currentRoute === '/receipts'
                    }">
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14,2 14,8 20,8"></polyline>
                        <line x1="16" y1="13" x2="8" y2="13"></line>
                        <line x1="16" y1="17" x2="8" y2="17"></line>
                    </svg>
                    <span class="font-medium">Receipts</span>
                </NuxtLink>

                <NuxtLink to="#"
                    class="flex items-center space-x-3 px-3 py-2 text-gray-600 hover:text-gray-900 hover:bg-gray-50 rounded-lg"
                    :class="{
                        '!text-blue-600 !bg-blue-50 ': currentRoute === '/settings'
                    }"
                    >
                    <svg class="w-5 h-5" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="12" cy="12" r="3"></circle>
                        <path
                            d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1 1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
                        </path>
                    </svg>
                    <span class="font-medium">Settings</span>
                </NuxtLink>
            </div>
        </nav>
    </div>
</template>

<script setup lang="ts">
const props = defineProps({
    sidebarOpen: {
        type: Boolean,
        default: false
    }
});

const emit = defineEmits(['closeSidebar']);

const toggleSidebar = () => {
    emit('closeSidebar');
}
const route = useRoute();

const currentRoute = ref(route.path);

watch(route, () => {
    currentRoute.value = route.path;
});

const sendToHomepage = () => {
    navigateTo('/')
}

</script>