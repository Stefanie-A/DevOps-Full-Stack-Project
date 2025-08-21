<template>
  <div class="min-h-screen bg-gray-50 flex flex-col justify-center py-12 px-6 sm:px-6 lg:px-8">
    <!-- Header with Logo -->
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <div class="flex justify-center">
        <div class="flex items-center space-x-3 cursor-pointer" @click="sendTo('/')">
          <div class="w-10 h-10 bg-blue-600 rounded-md flex items-center justify-center">
            <span class="text-white font-bold text-lg">R</span>
          </div>
          <span class="text-2xl font-semibold text-gray-900">ReceiptTracker</span>
        </div>
      </div>
    </div>

    <!-- Sign In Form -->
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <div class="bg-white py-8 px-4 shadow-sm rounded-lg sm:px-10 border border-gray-200">
        <div class="mb-6">
          <h2 class="text-2xl font-bold text-gray-900 text-center">Sign In</h2>
        </div>

        <form @submit.prevent="handleSignIn" class="space-y-6">
          <!-- Email Field -->
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
              Email
            </label>
            <input id="email" v-model="form.email" type="email" required placeholder="you@email.com"
              class="w-full px-3 py-3 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
          </div>

          <!-- Password Field -->
          <div>
            <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
              Password
            </label>
            <input id="password" v-model="form.password" type="password" required placeholder="Your password"
              class="w-full px-3 py-3 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
          </div>

          <!-- Remember Me & Forgot Password -->
          <div class="flex items-center justify-between">
            <div class="flex items-center">
              <input id="remember-me" v-model="form.rememberMe" type="checkbox"
                class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded" />
              <label for="remember-me" class="ml-2 block text-sm text-gray-700">
                Remember me
              </label>
            </div>
            <a href="#" class="text-sm text-blue-600 hover:text-blue-500">
              Forgot password?
            </a>
          </div>

          <!-- Sign In Button -->
          <button type="submit" :disabled="isLoading"
            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-gray-800 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500 disabled:opacity-50 disabled:cursor-not-allowed">
            <span v-if="isLoading" class="flex items-center">
              <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none"
                viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                </path>
              </svg>
              Signing in...
            </span>
            <span v-else>Sign In</span>
          </button>
        </form>

        <!-- Sign Up Link -->
        <div class="mt-6 text-center">
          <p class="text-sm text-gray-600">
            Don't have an account?
            <NuxtLink to="/auth/signup" @click="$emit('switch-to-signup')"
              class="font-medium text-blue-600 hover:text-blue-500">
              Sign up
            </NuxtLink>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { NuxtLink } from '#components'
import { ref, reactive } from 'vue'

definePageMeta({
  layout: 'empty'
})

const emit = defineEmits(['switch-to-signup'])
const { start, finish } = useLoadingIndicator();
const isLoading = ref(false)

const form = reactive({
  email: '',
  password: '',
  rememberMe: false
})


const sendTo = (route: string) => {
  navigateTo(route)
}

const { login, saveToken } = useAuth();
const toast = useToast();

const handleSignIn = async () => {
  isLoading.value = true
  start();
  try {

    const response = await login(form.email, form.password);

    const res = await response.json();

    if (res.successful === false) {
      throw new Error(res.message ? res.message : 'Something went wrong');
    }

    if (res.data === null || res.data === undefined) {
      throw new Error("Missing access token");
    }
    await saveToken(res.data);

    toast.add({ title: 'Success', description: res.message, color: 'info' });

    navigateTo('/dashboard');
  } catch (error) {
    console.error('Sign in error:', error)
  } finally {
    isLoading.value = false;
    finish();
  }
}
</script>