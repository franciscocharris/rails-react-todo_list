import styles from './styles.module.css'

export function InputText(props) {
  const { name, type = 'text', placeholder } = props

  return(
    <input
      name={name}
      type={type}
      placeholder={placeholder}
      className={styles.input}
    />
  )
}
