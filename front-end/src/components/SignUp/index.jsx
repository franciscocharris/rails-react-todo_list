import axios from '../../config/axios'
import { FormContainer } from '../FormContainer'
import { InputText } from '../InputText'

export function SignUp() {

  function Submit(e){
    e.preventDefault()
    const{
      firstName,
      lastName,
      email,
      password
    } = e.target

    console.log('firstName.value', firstName.value)
    console.log('firstName.value', lastName.value)
    console.log('firstName.value', email.value)
    console.log('firstName.value', password.value)

    // AGREGAR VALIDACIONES

    axios.post('/signup', {
      first_name: firstName.value,
      last_name: lastName.value,
      email: email.value,
      password: password.value
    })
    .then(response => {
      console.log(response.data)
    })
    .catch(error => {
      console.log(error.message)
    })
  }
  
  return(
    <FormContainer title="Sign Up" onSubmit={Submit}> 
      <InputText name="firstName" placeholder="Name" />
      <InputText name="lastName" placeholder="Last Name" />
      <InputText name="email" type="email" placeholder="Email" />
      <InputText name="password" type="password" placeholder="Password" />
      <input type="submit" value="CREATE ACCOUNT" className="form_button"/>
      <a className="form_link-signin" href="/">Sign in</a>
    </FormContainer>  
  )
}

