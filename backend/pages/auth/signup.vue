<template>
  <div class="min-h-screen bg-gray-50 flex flex-col justify-center px-6 py-12 sm:px-6 lg:px-8">
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

    <!-- Sign Up Form -->
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
      <div class="bg-white py-8 px-4 shadow-sm rounded-lg sm:px-10 border border-gray-200">
        <div class="mb-6">
          <h2 class="text-2xl font-bold text-gray-900 text-center">Sign Up</h2>
          <p class="mt-2 text-center text-sm text-gray-600">
            Start tracking your receipts today
          </p>
        </div>

        <form @submit.prevent="handleSignUp" class="space-y-6">


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
            <input id="password" v-model="form.password" type="password" required placeholder="Create a strong password"
              class="w-full px-3 py-3 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500" />
            <p class="mt-1 text-xs text-gray-500">
              Must be at least 8 characters long
            </p>
          </div>

          <!-- Confirm Password Field -->
          <div>
            <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">
              Confirm Password
            </label>
            <input id="confirmPassword" v-model="form.confirmPassword" type="password" required
              placeholder="Confirm your password"
              class="w-full px-3 py-3 border border-gray-300 rounded-md shadow-sm placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
              :class="{ 'border-red-300': passwordMismatch }" />
            <p v-if="passwordMismatch" class="mt-1 text-xs text-red-600">
              Passwords do not match
            </p>
          </div>

          <!-- Terms and Conditions -->
          <div class="flex items-start">
            <input id="terms" v-model="form.acceptTerms" type="checkbox" required
              class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded mt-1" />
            <label for="terms" class="ml-2 block text-sm text-gray-700">
              I agree to the
              <a href="#" class="text-blue-600 hover:text-blue-500">Terms of Service</a>
              and
              <a href="#" class="text-blue-600 hover:text-blue-500">Privacy Policy</a>
            </label>
          </div>

          <!-- Sign Up Button -->
          <button type="submit" :disabled="isLoading || passwordMismatch || !form.acceptTerms"
            class="w-full flex justify-center py-3 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed">
            <span v-if="isLoading" class="flex items-center">
              <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none"
                viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor"
                  d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                </path>
              </svg>
              Creating account...
            </span>
            <span v-else>Create Account</span>
          </button>
        </form>

        <!-- Sign In Link -->
        <div class="mt-6 text-center">
          <p class="text-sm text-gray-600">
            Already have an account?
            <NuxtLink to="/auth/login" @click="$emit('switch-to-login')"
              class="font-medium text-blue-600 hover:text-blue-500">
              Sign in
            </NuxtLink>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'
import { useAuth } from '~/composables/auth'
definePageMeta({
  layout: 'empty'
})
const emit = defineEmits(['switch-to-login'])

const isLoading = ref(false)

const form = reactive({
  firstName: '',
  lastName: '',
  email: '',
  password: '',
  confirmPassword: '',
  acceptTerms: false
})

const passwordMismatch = computed(() => {
  return form.password && form.confirmPassword && form.password !== form.confirmPassword
})
const toast = useToast();

const sendTo = (route: string) => {
  navigateTo(route)
}

const { signup } = useAuth();

const { start, finish } = useLoadingIndicator()

const handleSignUp = async () => {
  if (passwordMismatch.value) return

  isLoading.value = true;

  start();

  try {
    const response = await signup(form.email, form.password);

    const res = await response.json();

    if (res.successful === false) {
      throw new Error(res.message ? res.message : 'Something went wrong');
    }

    toast.add({ title: 'Success', description: res.message, color: 'info' });

    navigateTo('/auth/login');

  } catch (error: any) {
    console.error('Sign up error:', error);
    toast.add({ title: 'Error', description: error.message, color: 'error' });
  } finally {
    isLoading.value = false;
    finish();
  }
}
</script>