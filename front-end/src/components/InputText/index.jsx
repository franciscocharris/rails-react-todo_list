import styles from './styles.module.css'
import {ErrorMessage, Field} from 'formik'

export function InputText(props) {
  const { name, type = 'text', placeholder } = props
  
  return(
    <>
      <Field
        name={name}
        type={type}
        placeholder={placeholder}
        className={styles.input}
      />
      <ErrorMessage 
        name={name} 
        component="div" 
        className={styles.messageError} 
      />
    </>
  )
}
