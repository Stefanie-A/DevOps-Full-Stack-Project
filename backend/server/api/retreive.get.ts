export default defineEventHandler(async (event) => {
    const token = getCookie(event, 'accessToken')

    return { successful: token === undefined ? false : true, message: 'Token', data: token }
})