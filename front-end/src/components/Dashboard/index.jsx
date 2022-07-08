import { useEffect } from 'react'
import axios from '../../config/axios'
import { Board } from './Board'
import { Modal } from './Modal'
import { useState } from 'react'
import { InputText } from '../InputText'
import { Formik, Form } from 'formik'
import './styles.css'

const mock = {
  "data": [
    {
      "id": 1,
      "title": "hola 1",
      "description": "string 2",
      "status": "NOT_STARTED",
    },
    {
      "id": 2,
      "title": "hola 2",
      "description": "string 2",
      "status": "IN_PROGRESS",
    },
    {
      "id": 4,
      "title": "hola 3",
      "description": "string",
      "status": "DONE",
    }
  ]
}


const tasksSet = new Set()

export function Dashboard() {
  const [isOpen, setIsOpen] = useState(false)
  const [tasks, setTasks] = useState([])
  const [columns, setColumns] = useState([])
  const modalRoot = document.getElementById('modal-root')
  console.log('isOpen', isOpen)


  useEffect(() => {
    // feching data
    axios.get('/lists')
    .then(response => {
      console.log(response.data)
    })
    .catch(error => {
      console.log('Error :',error.message)
    })

    mock.data.forEach((task) => tasksSet.add(task.status))
    setColumns([...tasksSet])
    setTasks(mock.data)

  }, [mock.data])

  return (
    <>
      <div className="dashboard_container">
        <span className="dashboard_title">Dashboard</span>
        <div className="container_buttons">
          <input onClick={() => setIsOpen(true) + modalRoot.classList.add('active')} type="button" value="CREATE TASK" className="dashboard_button task"/>
          <input type="button" value="LOGOUT" className="dashboard_button logout"/>
        </div>
      </div>

      {
        isOpen &&
        <Modal handleClose={setIsOpen}>
          <Formik
            initialValues = {{title: '', descripcion: ''}}
          >
              {() => (
                <Form className="form">
                  <InputText name="title" placeholder="Title" className="form-modal"/>
                  <InputText name="descripcion" placeholder="Descripcion"/>
                </Form>
              )}
            </Formik>
        </Modal>
      }

      <Board columns={columns} tasks={tasks} />
    </>
  )
}