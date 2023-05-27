import React, { useEffect, useState } from 'react';
import Navbar from "../../components/Navbar/Navbar";
import SearchBar from '../../components/SearchBar/SearchBar';
import NewsList from '../../components/NewsList/NewsList';
import axios from 'axios';
import HeaderNews from '../../components/HeaderNews/HeaderNews';

function News(props) {
    const [isFormOpened, setIsFormOpened] = useState(false);

    const handleOpenForm = () => {
        setIsFormOpened(true)
    }

    const handleCloseForm = () => {
        setIsFormOpened(false)
    }

    const [newsList, setNewsList] = useState([]);

    useEffect(() => {
        axios.get("https://newsapi.org/v2/everything?q=car&apiKey=09ccc9dea02242a9b897be5a65515cb9")
            .then(response => {
                console.log(response);
                setNewsList(response.data.articles)
            })

    });

    // const [currentPage, setCurrentPage] = useState(1);
    // const totalPages = Math.ceil(newsList.length / 6);

    // const indexOfLastItem = currentPage * 6;
    // const indexOfFirstItem = indexOfLastItem - 6;
    // const currentItems = newsList.slice(indexOfFirstItem, indexOfLastItem);

    // const handlePageChange = (pageNumber) => {
    //     setCurrentPage(pageNumber);
    // };

    return (
        <div>
            <Navbar style={4}
                isOpen={isFormOpened}
                handleLoginClick={handleOpenForm}
                handleOutsideClick={handleCloseForm}
            />

            <HeaderNews />

            <SearchBar />

            <NewsList newsList={newsList} />

        </div>
    );
}

export default News;