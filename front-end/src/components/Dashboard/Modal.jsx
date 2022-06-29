import { HiOutlineX } from "react-icons/hi";
import './styles.css'

export function Modal({children, modal, setModal}) {
    return (
      <>
        {modal &&
          <div className="overlay">
            <div className="modal_container">
              <div onClick={() => setModal(false)} className="modal_button-close"><HiOutlineX/></div>
              {children}
            </div>
          </div>
        }
      </>
    )
}