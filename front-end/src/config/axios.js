import axios from 'axios'

const instance = axios.create({
  baseURL: 'http://localhost:3000/v1',
  headers: { 'Content-Type' : 'application/json' }
})

instance.interceptors.request.use(
  config => {
    const token =  localStorage.getItem( 'token', token);

    config.headers.authorization = `Bearer ${token}`
    return config;
  },
  err => {
    return Promise.reject(err)
  }
)

export default instance

