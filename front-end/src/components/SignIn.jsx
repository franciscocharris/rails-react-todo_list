import '../index.css'
import { Link } from "react-router-dom"

export function SignIn() {

  return(
    <>
      <div className="container">
        <div className="container_sign-in">
          <div className="container_form">
            <h1>Sign In</h1>
            <form method='get' className="form">
              <input type="email" placeholder='Email' className="form_input"/>
              <input type="password" placeholder="Password" className="form_input"/>
              <input type="submit" value="LOGIN" className="form_button"/>
            </form>
            <Link to={`/sign-up`} className="form_link-signup">
              <span> Sign up for an account </span>
            </Link>
          </div>
        </div>
      </div>
    </>
  )
}