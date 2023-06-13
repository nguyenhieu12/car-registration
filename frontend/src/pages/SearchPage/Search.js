import Navbar from "../../components/Navbar/Navbar";
import { useState } from "react";
import HeaderSearch from "../../components/HeaderSearch/HeaderSearch";

function Search() {
    const [isFormOpened, setIsFormOpened] = useState(false);

    const handleOpenForm = () => {
        setIsFormOpened(true)
    }

    const handleCloseForm = () => {
        setIsFormOpened(false)
    }

    return (
        <div>
            <HeaderSearch />

            <Navbar style={5}
                    isOpen={isFormOpened}
                    handleLoginClick={handleOpenForm}
                    handleOutsideClick={handleCloseForm}
            />
        </div>
    );
}

export default Search;