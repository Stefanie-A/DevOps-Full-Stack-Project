export const useAuth = () => {
    const config = useRuntimeConfig();
    const baseURL = config.public.apiBase;


    const signup = async (email: string, password: string) => {
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        const raw = JSON.stringify({
            email, password
        });

        const requestOptions: RequestInit = {
            method: "POST",
            headers: myHeaders,
            body: raw,
            redirect: "follow"
        };

        const response = await fetch(`${baseURL}/user`, requestOptions)
        return response;
    }

    const login = async (email: string, password: string) => {
        const myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/json");

        const raw = JSON.stringify({
           email, password
        });

        const requestOptions:RequestInit = {
            method: "POST",
            headers: myHeaders,
            body: raw,
            redirect: "follow"
        };

        const response = await fetch(`${baseURL}/user/login`, requestOptions)
        return response
    }

    const saveToken = async (token: string) => {
        const response = await $fetch('/api/token', {
            method: 'POST',
            body: {
                accessToken: token
            }
        });
        return response;
    }
    
    const getToken = async () => {
        const response = await $fetch('/api/retreive');
        return response;
    }
    

    return {
        signup, login, saveToken, getToken
    }
}