export default defineNuxtRouteMiddleware(async () => {
    const response = await $fetch('/api/retreive');
    if(response.successful === false){
        return navigateTo('/auth/login');

    }
})