import axios from 'axios'

const api = axios.create({
    baseURL: 'http://localhost:3001/api',
})

export const insertMovie = payload => api.post(`/movie`, payload)
export const getAllMovies = () => api.get(`/movies`)


const apis = {
    insertMovie,
    getAllMovies
}

export default apis