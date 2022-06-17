import { Link } from "react-router-dom"
import { FormContainer } from '../FormContainer'
import { InputText } from '../InputText'

export function SignIn() {

  return(
    <>
      <FormContainer title="Sign In">
        <InputText name="email" type="email" placeholder="Email"  />
        <InputText name="password" type="password" placeholder="Password" />
        <input type="submit" value="LOGIN" className="form_button"/>
        <Link to={`/sign-up`} className="form_link-signup">
          <span> Sign up for an account </span>
        </Link>
      </FormContainer>
    </>
  )
}