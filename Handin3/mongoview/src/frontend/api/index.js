import axios from 'axios'

const api = axios.create({
    baseURL: 'http://localhost:3001/api',
})

export const insertTweet = payload => api.post(`/tweet`, payload)
export const getAllTweets = () => api.get(`/tweets`)


const apis = {
    insertTweet,
    getAllTweets
}

export default apis