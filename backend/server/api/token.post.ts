export default defineEventHandler(async (event) => {
    const body = await readBody(event);

    setCookie(event, 'accessToken', body.accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'lax',
        path: '/',
        maxAge: 60 * 60, 
    })

    return { successful: true, message: 'Saved token', data: null}
})