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

  return(
    <>
      <FormContainer title="Sign In">
        <Formik
          initialValues = {{ email: '', password:''}}
          validationSchema={validateSignin}
        >
          {() => (
            <Form className="form">
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