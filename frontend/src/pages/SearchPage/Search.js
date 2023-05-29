import Navbar from "../../components/Navbar/Navbar";
import { useState } from "react";
import InfoHeader from "../../components/InfoHeader/InfoHeader";
import HeaderSearch from "../../components/HeaderSearch/HeaderSearch";
import Timeline from "../../components/Timeline/Timeline";

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

            <InfoHeader />

            <Timeline />

            <Navbar style={5}
                    isOpen={isFormOpened}
                    handleLoginClick={handleOpenForm}
                    handleOutsideClick={handleCloseForm}
            />
        </div>
    );
}

export default Search;