import Navbar from "../../components/Navbar/Navbar";
import { useState, useEffect } from "react";
import InfoHeader from "../../components/InfoHeader/InfoHeader";
import HeaderSearch from "../../components/HeaderSearch/HeaderSearch";
import Timeline from "../../components/Timeline/Timeline";

function Search() {
    const [isFormOpened, setIsFormOpened] = useState(false);
    const [limitedScroll, setLimitedScroll] = useState(5);
    const handleOpenForm = () => {
        setIsFormOpened(true)
    }

    const handleCloseForm = () => {
        setIsFormOpened(false)
    }

    useEffect(() => {
        const handleScroll = () => {
            if (window.scrollY > 300) {
                setLimitedScroll(6);
                console.log(window.scrollY);
            } else {
                setLimitedScroll(5);
            }
        };

        window.addEventListener('scroll', handleScroll);

        return () => {
            window.removeEventListener('scroll', handleScroll);
        };
    }, []);

    return (
        <div>
            <HeaderSearch />

            <InfoHeader />

            <Timeline />

            <Navbar style={limitedScroll}
                    isOpen={isFormOpened}
                    handleLoginClick={handleOpenForm}
                    handleOutsideClick={handleCloseForm}
            />
        </div>
    );
}

export default Search;