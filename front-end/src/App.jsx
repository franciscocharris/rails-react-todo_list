import { Routes, Route } from "react-router-dom";
import { SignIn } from './components/SignIn'
import { SignUp } from './components/SignUp'
import {Dashboard } from './components/Dashboard'


function App() {

  return (
    <>
      <Routes>
        <Route path='/' element={<SignIn />} />
        <Route path='/sign-up' element={<SignUp />} />
        <Route path='/dashboard' element={<Dashboard />} />
      </Routes>
    </>
  )
}

export default App
