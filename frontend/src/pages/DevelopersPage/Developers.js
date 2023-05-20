import { useState  } from "react";
import Navbar from "../../components/Navbar/Navbar";

function Developers() {
    const [isFormOpened, setisFormOpened] = useState(false); 

    const handleOpenForm = () => {
        setisFormOpened(true)
    }

    const handleCloseForm = () => {
        setisFormOpened(false)
    }

    return(
        <div className="developers-container">
            <Navbar isOpen={isFormOpened} handleLoginClick={handleOpenForm} handleOutsideClick={handleCloseForm}/>
            <h1>Hello form Developers</h1>
        </div>
    );
}

export default Developers;