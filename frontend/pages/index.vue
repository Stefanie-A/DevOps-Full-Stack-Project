<template>
    <div class="min-h-screen bg-gray-50 ">
        <!-- Header -->
        <header class="bg-white shadow-sm">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <!-- Logo -->
                    <div class="flex items-center space-x-2">
                        <div class="w-8 h-8 bg-blue-500 rounded-md flex items-center justify-center">
                            <span class="text-white font-bold text-sm">R</span>
                        </div>
                        <span class="text-xl font-semibold text-gray-900">ReceiptTracker</span>
                    </div>

                    <!-- Navigation -->
                    <nav class="hidden md:flex space-x-8">
                        <a href="#" class="text-gray-600 hover:text-gray-900 transition-colors">Features</a>
                        <a href="#" class="text-gray-600 hover:text-gray-900 transition-colors">Pricing</a>
                        <a href="#" class="text-gray-600 hover:text-gray-900 transition-colors">About</a>
                    </nav>

                    <!-- Auth Buttons -->
                    <div class="flex items-center space-x-4">
                        <button @click="sendTo('/auth/login')" class="text-gray-600 hover:text-gray-900 transition-colors" >Sign In</button>
                        <button @click="sendTo('/auth/signup')" class="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-colors">
                            Sign Up
                        </button>
                    </div>
                </div>
            </div>
        </header>

        <!-- Hero Section -->
        <main class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 pt-20 pb-16">
            <!-- Background Decorative Elements -->
            <div class="absolute inset-0 overflow-hidden pointer-events-none">
                <div class="absolute top-32 left-20 w-6 h-6 text-blue-200">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path
                            d="M9 11H7v2h2v-2zm4 0h-2v2h2v-2zm4 0h-2v2h2v-2zm2-7h-1V2h-2v2H8V2H6v2H5c-1.1 0-1.99.9-1.99 2L3 20c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 16H5V9h14v11z" />
                    </svg>
                </div>
                <div class="absolute top-40 right-32 w-4 h-4 text-blue-300">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path
                            d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
                    </svg>
                </div>
                <div class="absolute bottom-32 left-32 w-5 h-5 text-purple-200">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path
                            d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z" />
                    </svg>
                </div>
                <div class="absolute top-20 right-20 w-3 h-3 bg-blue-300 rounded-full"></div>
                <div class="absolute bottom-20 right-40 w-2 h-2 bg-purple-300 rounded-full"></div>
            </div>

            <div class="text-center relative">
                <!-- Main Headline -->
                <h1 class="text-4xl md:text-6xl lg:text-7xl font-bold text-gray-900 leading-tight mb-8">
                    Turn Your Receipts Into
                    <br>
                    <span class=" ">
                        Organized,
                        <br>
                        Searchable Data
                    </span>
                </h1>

                <!-- Subtitle -->
                <p class="text-lg md:text-xl text-gray-600 max-w-4xl mx-auto mb-12 leading-relaxed">
                    Effortlessly track expenses, manage budgets, and prepare for taxes. Transform paper
                    receipts into digital insights with AI-powered scanning and categorization.
                </p>

                <!-- CTA Buttons -->
                <div class="flex flex-col sm:flex-row gap-4 justify-center items-center mb-6">
                    <button @click="sendTo('/auth/signup')"
                        class="bg-blue-600 cursor-pointer text-white px-8 py-4 rounded-lg text-lg font-semibold hover:bg-blue-700 transition-colors shadow-lg">
                        Get Started Free
                    </button>
                    <button
                        class="text-gray-700 px-8 py-4 rounded-lg text-lg font-semibold hover:bg-gray-100 transition-colors">
                        Watch Demo
                    </button>
                </div>

                <!-- Trial Info -->
                <p class="text-gray-500 text-sm">
                    No credit card required • 14-day free trial
                </p>

                <!-- Trending Icon -->
                <div class="absolute left-1/2 transform -translate-x-1/2 -translate-y-32 text-blue-400">
                    <svg class="w-8 h-8" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <polyline points="22,7 13.5,15.5 8.5,10.5 2,17"></polyline>
                        <polyline points="16,7 22,7 22,13"></polyline>
                    </svg>
                </div>
            </div>
        </main>
    </div>
</template>

<script setup lang="ts">
definePageMeta({
    layout: 'empty'
});


const sendTo = (route: string) => {
    navigateTo(route)
}
</script>

<style scoped>
/* Additional custom styles if needed */
</style>