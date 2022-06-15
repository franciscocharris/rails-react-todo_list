import '../index.css'
import Axios from 'axios'
import { useState } from 'react'

export function SignUp() {
  // const URL = 'http://localhost:3000/v1/signup'
  // const TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6Mn0.VE73XwpT1UCjEsPkb80uphw6Jb7CoHLY720wFBNp618'

  const [data, setData] = useState({
    first_name:"",
    last_name:"",
    email:"",
    password:""
  })

  // function submit(e){
  //   e.preventDefault()
  //   Axios.post(URL, {
  //     first_name: data.first_name,
  //     last_name: data.last_name,
  //     email: data.email,
  //     password: data.password
  //   })
  //   .then(response => {
  //     console.log(response.data)
  //   })
  // }

  function handle(e){
    const newData = {...data}
    newData[e.target.id] = e.target.value
    setData(newData)
    console.log('data', newData)
  }

  return(
    <>
      <div className="container">
        <div className="container_sign-up">
          <div className="container_form">
            <h1>Sign Up</h1>
            <form className="form" onSubmit={(e) => submit(e)}>
              <input onChange={(e) => handle(e)} id="first_name" value={data.first_name} type="text" placeholder="Name" className="form_input"/>
              <input onChange={(e) => handle(e)} id="last_name" value={data.last_name} type="text" placeholder="Last Name" className="form_input"/>
              <input onChange={(e) => handle(e)} id="email" value={data.email} type="email" placeholder="Email" className="form_input"/>
              <input onChange={(e) => handle(e)} id="password" value={data.password} type="password" placeholder="Password" className="form_input"/>
              <input type="submit" value="CREATE ACCOUNT" className="form_button"/>
            </form>
              <a className="form_link-signin" href="/">Sign in</a>
          </div>
        </div>
      </div>
    </>
  )
}