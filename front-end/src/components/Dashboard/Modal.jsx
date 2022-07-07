import ReactDOM from 'react-dom'
import { useEffect } from "react";
import { HiOutlineX } from "react-icons/hi";
import './styles.css'

const modalRoot = document.getElementById('modal-root');
const el = document.createElement('div');

export function Modal({children, handleClose}) {

  useEffect (() => {
    modalRoot.appendChild(el);

    return () => {
      modalRoot.removeChild(el);
    }
  } ,[]) 

  return ReactDOM.createPortal(
    <div className="overlay">
      <div className="modal_container">
        <div
          onClick={() => handleClose(false) + modalRoot.classList.remove('active')}
          className="modal_button-close"
        >
            <HiOutlineX/>
        </div>
        {children}
      </div>
    </div>, el);

}