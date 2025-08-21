<template>
  <div class="">





    <div class="">


      <main class="p-4 sm:p-6 lg:p-8">
        <!-- Upload Section -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-8 mb-8">
          <div class="text-center">
            <!-- <div class="mx-auto w-16 h-16 bg-blue-50 rounded-full flex items-center justify-center mb-4">
              <svg class="w-8 h-8 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                <polyline points="7,10 12,15 17,10"></polyline>
                <line x1="12" y1="15" x2="12" y2="3"></line>
              </svg>
            </div>
            <h3 class="text-lg font-medium text-gray-900 mb-2">Drag & drop your receipt here</h3>
            <p class="text-gray-500 mb-6">or</p> -->
            <div v-if="!selectedFile" class="">
              <button @click="triggerFileSelect"
                class="bg-blue-600 text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-700 transition-colors">
                Upload Receipt
              </button>
              <input type="file" ref="fileInput" accept="image/*" class="hidden" @change="handleFileChange" />
              <p class="text-sm text-gray-500 mt-4">Accepted: JPG, PNG, PDF - Max 10MB</p>
            </div>
            <div v-if="selectedFile" class="flex space-x-4 justify-center">
              <button @click="sendReceipt()"
                class="bg-blue-600 flex items-center justify-center  text-white px-6 py-3 rounded-lg font-medium hover:bg-blue-700 transition-colors">

                Add Receipt

                <svg v-if="isLoading" class="animate-spin ml-2  h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg"
                  fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor"
                    d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z">
                  </path>
                </svg>

              </button>
              <button @click="selectedFile = undefined"
                class="bg-gray-100 text-black px-6 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors">
                Cancel
              </button>
            </div>
          </div>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <!-- Total Receipts -->
          <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div class="flex items-center">
              <div class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mr-4">
                <svg class="w-6 h-6 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                  stroke-width="2">
                  <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                  <polyline points="14,2 14,8 20,8"></polyline>
                  <line x1="16" y1="13" x2="8" y2="13"></line>
                  <line x1="16" y1="17" x2="8" y2="17"></line>
                </svg>
              </div>
              <div>
                <p class="text-2xl font-bold text-gray-900">{{ totalReceipts }}</p>
                <p class="text-sm text-gray-500">Total Receipts</p>
              </div>
            </div>
          </div>

          <!-- Spent This Month -->
          <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div class="flex items-center">
              <div class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mr-4">
                <svg class="w-6 h-6 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                  stroke-width="2">
                  <line x1="8" y1="6" x2="21" y2="6"></line>
                  <line x1="8" y1="12" x2="21" y2="12"></line>
                  <line x1="8" y1="18" x2="21" y2="18"></line>
                  <line x1="3" y1="6" x2="3.01" y2="6"></line>
                  <line x1="3" y1="12" x2="3.01" y2="12"></line>
                  <line x1="3" y1="18" x2="3.01" y2="18"></line>
                </svg>
              </div>
              <div>
                <p class="text-2xl font-bold text-gray-900">$1,760.50</p>
                <p class="text-sm text-gray-500">Spent This Month</p>
              </div>
            </div>
          </div>

          <!-- Average Spend -->
          <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
            <div class="flex items-center">
              <div class="w-12 h-12 bg-blue-50 rounded-lg flex items-center justify-center mr-4">
                <svg class="w-6 h-6 text-blue-600" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                  stroke-width="2">
                  <line x1="8" y1="6" x2="21" y2="6"></line>
                  <line x1="8" y1="12" x2="21" y2="12"></line>
                  <line x1="8" y1="18" x2="21" y2="18"></line>
                  <line x1="3" y1="6" x2="3.01" y2="6"></line>
                  <line x1="3" y1="12" x2="3.01" y2="12"></line>
                  <line x1="3" y1="18" x2="3.01" y2="18"></line>
                </svg>
              </div>
              <div>
                <p class="text-2xl font-bold text-gray-900">$41.91</p>
                <p class="text-sm text-gray-500">Avg. Spend/Receipt</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Receipts -->
        <div class="bg-white rounded-lg shadow-sm border border-gray-200">
          <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-900">Recent Receipts</h2>
          </div>
          <div class="overflow-x-auto">
            <table class="w-full">
              <thead class="bg-gray-50">
                <tr>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Receipt
                  </th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vendor</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                  <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-200">
                <tr v-for="item in receipts" :key="item.id">
                  <td class="px-6 py-4 whitespace-nowrap">
                    <div class="flex items-center">
                      <img @click="viewImage(item.imageUrl)" :src="item.imageUrl" class="block w-10 h-10 rounded-md" />
                    </div>
                  </td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ item.vendor &&
                    item.vendor.length > 1 ? item.vendor : 'No name' }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">{{ item.date && item.date.length > 0 ?
                    item.date : 'No date' }}</td>
                  <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">{{ item.amount &&
                    item.amount.length > 0 ? item.amount : 'No amount' }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import type { aResponse } from '~/interfaces/aResponse';
import type { PaginatedResult, Receipt } from '~/interfaces/receipt';

definePageMeta({
  name: 'Dashboard',
  middleware: 'dashboard'
})

const sidebarOpen = ref(false);

const isLoading = ref(false);

const selectedFile = ref<File | undefined>()

// Strongly typed ref for the input element
const fileInput = ref<HTMLInputElement | null>(null)

function triggerFileSelect(): void {
  fileInput.value?.click()
}

function handleFileChange(event: Event): void {
  const target = event.target as HTMLInputElement
  const file = target.files?.[0]

  if (file) {
    selectedFile.value = file
  }
}

const viewImage = (route: string) => {
  window.open(route, '_blank');
}

const { getToken } = useAuth();
const { createReceipt, getReceipts } = useReceipt();
const toast = useToast();
const { start, finish } = useLoadingIndicator();
const page = ref(1);
const limit = ref(10);
const search = ref();
const totalReceipts = ref(0);

async function sendReceipt() {
  start();
  isLoading.value = true;
  if (!selectedFile.value) {
    throw new Error("File not selected");

  }
  try {
    const tokenResponse = await getToken();

    if (!tokenResponse.data) {
      throw new Error("Session exprired");
    }
    const response = await createReceipt(tokenResponse.data, selectedFile.value);

    const res = await response.json();

    if (res.successful === false) {
      throw new Error(res.message ? res.message : 'Something went wrong');
    }

    console.log(res)

    toast.add({
      title: 'Success', description: res.message ? res.message : 'Receipt stored', color: 'info'
    });

  } catch (error: any) {
    console.error(error);
    toast.add({
      title: 'Error', description: error.message, color: 'error'
    })
  } finally {
    finish();
    isLoading.value = false;
  }
}
const receipts = ref<Receipt[]>([]);
async function fetchReceipts() {
  start();
  try {
    const tokenResponse = await getToken();

    if (!tokenResponse.data) {
      throw new Error("Session exprired");
    }
    const response = await getReceipts(tokenResponse.data, page.value, limit.value, search.value);
    if (response.status === 401) {
      throw new Error("Session expired");

    }
    const res: aResponse<PaginatedResult<Receipt>> = await response.json();
    console.log(res)
    if (res.data && res.data.data) {
      receipts.value = res.data.data;
      totalReceipts.value = res.data.total
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