import { List } from './List'
import './styles.css'


export function Dashboard() {

  return (
    <>
    <div className="dashboard_container">
      <span className="dashboard_title">Dashboard</span>
      <div className="container_buttons">
        <input type="button" value="CREATE TASK" className="dashboard_button task"/>
        <input type="button" value="LOGOUT" className="dashboard_button logout"/>
      </div>
    </div>
    <List/>
    </>
  )
}