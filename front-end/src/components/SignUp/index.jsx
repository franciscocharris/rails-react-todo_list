import axios from '../../config/axios'
import { Navigate } from "react-router-dom"
import { FormContainer } from '../FormContainer'
import { InputText } from '../InputText'
import { Formik, Form } from 'formik'
import {useState} from 'react'
import * as yup from 'yup'

export function SignUp() {
  const [success, setSuccess] = useState(false)

  // AGREGAR VALIDACIONES YUP
  const validateSignup = yup.object({
    firstName: yup.string().required('Name is Required').max(15, 'Must be 15 characters or less'),
    lastName: yup.string().required('Last Name is Required').max(15, 'Must be 15 characters or less'),
    email: yup.string().required('Email is Required').email('Email is invalid'),
    password: yup.string().required('Password is Required').min(8,'Password must be at least 8 characters')
  })

  function SubmitSignUp(e){
    e.preventDefault()
    const{
      firstName,
      lastName,
      email,
      password
    } = e.target  

    axios.post('/signup', {
      first_name: firstName.value,
      last_name: lastName.value,
      email: email.value,
      password: password.value
    })
    .then(response => {
      console.log(response.data)
      setSuccess(true)
    })
    .catch(error => {
      console.log('Error :',error.message) 
    })
  }

  return(
    <FormContainer title="Sign Up" >
      <Formik
        initialValues = {{firstName: '', lastName: '', email: '', password:''}}
        validationSchema={validateSignup}
      >
      {() => (
        <Form className="form" onSubmit={SubmitSignUp}>
          <InputText name="firstName" placeholder="Name" />
          <InputText name="lastName" placeholder="Last Name" />
          <InputText name="email" type="email" placeholder="Email" />
          <InputText name="password" type="password" placeholder="Password" />
          <input type="submit" value="CREATE ACCOUNT" className="form_button"/>
          <a className="form_link-signin" href="/">Sign in</a>
          {success ? <Navigate to="/"/> :  ''}
        </Form>
      )}
      </Formik>
    </FormContainer>  
  )
}