import { List } from './List'
import { Modal } from './Modal'
import { useState } from 'react'
import { InputText } from '../InputText'
import { Formik, Form } from 'formik'
import './styles.css'


export function Dashboard() {
  const [modal, setModal] = useState(false)

  return (
    <>
    <div className="dashboard_container">
      <span className="dashboard_title">Dashboard</span>
      <div className="container_buttons">
        <input onClick={() => setModal(!modal)} type="button" value="CREATE TASK" className="dashboard_button task"/>
        <input type="button" value="LOGOUT" className="dashboard_button logout"/>
      </div>
    </div>

    <Modal modal={modal} setModal={setModal}>
      <Formik
        initialValues = {{title: '', descripcion: ''}}
      >
          {() => (
            <Form className="form">
              <InputText name="title" placeholder="Title"/>
              <InputText name="descripcion" placeholder="Descripcion"/>
            </Form>
          )}
        </Formik>
    </Modal>
    

    <List/>
    </>
  )
}