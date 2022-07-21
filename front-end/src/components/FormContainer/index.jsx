import './styles.css'


export function FormContainer(props) {
  const { title, children, submit } = props
  return(
    <>
      <div className="container">
        <div className="container_sign-up">
          <div className="container_form">
            <h1> {title} </h1>
              {children}
          </div>
        </div>
      </div>
    </>
  )
}

