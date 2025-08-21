<template>
  <div class="">

    <!-- Main Content -->
    <div class="">


      <!-- Receipts Content -->
      <main class="p-4 sm:p-6 lg:p-8">
        <!-- Search Bar -->
        <div class="max-w-md mx-auto mb-8">
          <div class="relative">
            <input v-model="searchQuery" type="text" placeholder="Search by vendor..."
              class="w-full px-4 py-3 pl-10 pr-4 text-gray-700 bg-white border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent">
            <div class="absolute inset-y-0 left-0 flex items-center pl-3">
              <svg class="w-5 h-5 text-gray-400" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"></circle>
                <path d="m21 21-4.35-4.35"></path>
              </svg>
            </div>
          </div>
        </div>

        <!-- Receipts Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 xl:grid-cols-3 gap-6 mb-8">
          <div v-for="receipt in receipts" :key="receipt.id"
            class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition-shadow cursor-pointer">
            <div class="flex items-start space-x-4">
              <!-- Receipt Icon -->
              <div class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center flex-shrink-0">
                <img @click="viewImage(receipt.imageUrl)" :src="receipt.imageUrl" class="block w-10 h-10 rounded-md" />

              </div>

              <!-- Receipt Details -->
              <div class="flex-1 min-w-0">
                <h3 class="text-lg font-semibold text-gray-900 mb-1">{{ receipt.vendor && receipt.vendor.length > 2 ?
                  receipt.vendor : 'No Vendor'}}</h3>
                <p class="text-sm text-gray-500 mb-2">{{ receipt.date && receipt.date.length > 2 ? receipt.date : 'No Date' }}</p>
                <p class="text-xl font-bold text-blue-600">{{ receipt.amount && receipt.amount.length > 2 ?
                  receipt.amount : 'No Amount' }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Pagination -->
        <div class="flex items-center justify-center space-x-2">
          <button @click="previousPage" :disabled="currentPage === 1"
            class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
            <svg class="w-4 h-4 mr-1 inline" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <polyline points="15,18 9,12 15,6"></polyline>
            </svg>
            Previous
          </button>

          <button v-for="page in totalPages" :key="page" @click="currentPage = page" :class="[
            'px-3 py-2 text-sm font-medium rounded-md',
            currentPage === page
              ? 'text-blue-600 bg-blue-50 border border-blue-300'
              : 'text-gray-700 bg-white border border-gray-300 hover:bg-gray-50'
          ]">
            {{ page }}
          </button>

          <button @click="nextPage" :disabled="currentPage === totalPages"
            class="px-3 py-2 text-sm font-medium text-gray-500 bg-white border border-gray-300 rounded-md hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
            Next
            <svg class="w-4 h-4 ml-1 inline" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <polyline points="9,18 15,12 9,6"></polyline>
            </svg>
          </button>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import type { aResponse } from '~/interfaces/aResponse'
import type { PaginatedResult, Receipt } from '~/interfaces/receipt'
definePageMeta({
  name: 'All Receipts',
  middleware: 'dashboard'
})

const sidebarOpen = ref(false)
const searchQuery = ref('')
const currentPage = ref(1)
const itemsPerPage = ref(4);
const totalPages = ref(0);



const viewImage = (route: string) => {
  window.open(route, '_blank');
}


// Methods
const previousPage = async () => {
  if (currentPage.value > 1) {
    currentPage.value--
    await fetchReceipts();
  }
}

const nextPage = async () => {
  if (currentPage.value < totalPages.value) {
    currentPage.value++
    await fetchReceipts();
  }
}

// Reset to first page when searching
const resetPage = () => {
  currentPage.value = 1
}
const { getToken } = useAuth();
const { createReceipt, getReceipts } = useReceipt();
const toast = useToast();
const { start, finish } = useLoadingIndicator();

const receipts = ref<Receipt[]>([]);
async function fetchReceipts() {
  start();
  try {
    const tokenResponse = await getToken();

    if (!tokenResponse.data) {
      throw new Error("Session exprired");
    }
    const response = await getReceipts(tokenResponse.data, currentPage.value, itemsPerPage.value, searchQuery.value);
    if (response.status === 401) {
      throw new Error("Session expired");

    }
    const res: aResponse<PaginatedResult<Receipt>> = await response.json();
    console.log(res)
    if (res.data && res.data.data) {
      receipts.value = res.data.data;
      totalPages.value = res.data.totalPages
    }
    else {
      receipts.value = [];
    }
  } catch (error: any) {
    console.error(error);
    toast.add({ title: 'Error', description: error.message, color: 'error' });

  } finally {
    finish();
  }
}
onMounted(() => {
  fetchReceipts()
})

</script>

<style scoped>
/* Additional custom styles if needed */
</style>