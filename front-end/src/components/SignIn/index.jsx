import axios from '../../config/axios'
import { Link } from "react-router-dom"
import { FormContainer } from '../FormContainer'
import { InputText } from '../InputText'
import { Formik, Form } from 'formik'
import * as yup from 'yup'

export function SignIn() {

  let validateSignin = yup.object({
    email: yup.string().required('Email is Required').email('Email is invalid'),
    password: yup.string().required('Password Required').min(8,'Password is Invalid')
  })

  function SubmitSignIn(e) {
    e.preventDefault()
    const{
      email,
      password
    } = e.target

    axios.post('/login', {
      email: email.value,
      password: password.value
    })
    .then(response => {
      console.log(response.data)
    })
    .catch(error => {
      console.log('Error :',error.message) 
    })
  }

  return(
    <>
      <FormContainer title="Sign In">
        <Formik
          initialValues = {{ email: '', password:''}}
          validationSchema={validateSignin}
        >
          {() => (
            <Form className="form" onSubmit={SubmitSignIn}>
              <InputText name="email" type="email" placeholder="Email"  />
              <InputText name="password" type="password" placeholder="Password" />
              <input type="submit" value="LOGIN" className="form_button"/>
              <Link to={`/sign-up`} className="form_link-signup">
                <span> Sign up for an account </span>
              </Link>
            </Form>
          )}
        </Formik>
      </FormContainer>
    </>
  )
}