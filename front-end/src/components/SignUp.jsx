import '../index.css'

export function SignUp() {

  return(
    <>
      <div className="container">
        <div className="container_sign-up">
          <div className="container_form">
            <h1>Sign Up</h1>
            <form className="form">
              <input type="text" placeholder="Name" className="form_input"/>
              <input type="text" placeholder="Last Name" className="form_input"/>
              <input type="email" placeholder="Email" className="form_input"/>
              <input type="password" placeholder="Password" className="form_input"/>
              <input type="submit" value="CREATE ACCOUNT" className="form_button"/>
            </form>
              <a className="form_link-signin" href="/">Sign in</a>
          </div>
        </div>
      </div>
    </>
  )
}