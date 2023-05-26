import Navbar from "../../components/Navbar/Navbar";
import { useState } from "react";
import InfoHeader from "../../components/InfoHeader/InfoHeader";
import HeaderSearch from "../../components/HeaderSearch/HeaderSearch";
import Timeline from "../../components/Timeline/Timeline";

function Search() {
    const [isFormOpened, setisFormOpened] = useState(false);

    const handleOpenForm = () => {
        setisFormOpened(true)
    }

    const handleCloseForm = () => {
        setisFormOpened(false)
    }

    return (
        <div>
            <Navbar style={5}
                isOpen={isFormOpened}
                handleLoginClick={handleOpenForm}
                handleOutsideClick={handleCloseForm}
            />

            <HeaderSearch />

            <InfoHeader />

            <Timeline />
        </div>
    );
}

export default Search;