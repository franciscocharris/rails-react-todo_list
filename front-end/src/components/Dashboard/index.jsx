import { useEffect } from 'react'
import axios from '../../config/axios'
import { Board } from './Board'
import { Modal } from './Modal'
import { useState } from 'react'
import { InputText } from '../InputText'
import { Formik, Form } from 'formik'
import './styles.css'

const tasksSet = new Set()
const tasksMap = new Map()
const _tasks = []

export function Dashboard() {
  const [isOpenTask, setIsOpenTask] = useState(false)
  const [isOpenlist, setIsOpenList] = useState(false)
  const [tasks, setTasks] = useState([])
  const [columns, setColumns] = useState([])
  const modalRoot = document.getElementById('modal-root')


  useEffect(() => {
    axios.get('/lists')
      .then(response => {         
        const lists = response?.data?.lists || []
        const _tasks = lists.reduce((acc, cur) => {
          acc = [...acc, ...cur?.tasks]
          return acc
        }, [])

        lists.forEach((task) => tasksMap.set(task.id, task.name))

        setColumns([...tasksMap])
        setTasks(_tasks)
      })
      .catch(error => {
        console.log('Error :',error.message)
      })   
  }, [])

  function SubmitTask(e){
    e.preventDefault()
    const{
      name,
      description,
    } = e.target

    axios.post('/tasks', {
      name: name.value,
      description: description.value,
      list_id: 1
    })
    .then(response => {
      response.data
    })
    .catch(error => {
      console.log('Error :',error.message) 
    })
  }

  return (
    <>
      <div className="dashboard_container">
        <span className="dashboard_title">Dashboard</span>
        <div className="container_buttons">
          <input onClick={() => setIsOpenTask(true) + modalRoot.classList.add('active')} type="button" value="CREATE TASK" className="dashboard_button task"/>
          <input onClick={() => setIsOpenList(true) + modalRoot.classList.add('active')} type="button" value="CREATE LIST" className="dashboard_button task"/>
          <input type="button" value="LOGOUT" className="dashboard_button logout"/>
        </div>
      </div>

      {
        isOpenTask &&
        <Modal handleClose={setIsOpenTask}>
          <Formik
            initialValues = {{title: '', descripcion: ''}}
          >
              {() => (
                <Form className="form" onSubmit={SubmitTask}>
                  <InputText name="name" placeholder="Title" className="form-modal"/>
                  <InputText name="description" placeholder="Descripcion"/>
                  <input type="submit" value="SUBMIT" className="form_button"/>
                </Form>
              )}
            </Formik>
        </Modal>
      }

      {
        isOpenlist &&
        <Modal handleClose={setIsOpenList}>
          <Formik
            initialValues = {{name: ''}}
          >
              {() => (
                <Form className="form" onSubmit={SubmitTask}>
                  <InputText name="name" placeholder="Name" className="form-modal"/>
                  <input type="submit" value="SUBMIT" className="form_button"/>
                </Form>
              )}
            </Formik>
        </Modal>
      }

      <Board columns={columns} tasks={tasks} />
    </>
  )
}