import React, { useEffect, useState } from 'react';
import Navbar from "../../components/Navbar/Navbar";
import SearchBar from '../../components/SearchBar/SearchBar';
import NewsList from '../../components/NewsList/NewsList';
import axios from 'axios';
import './News.css';

function News(props) {
    const [isFormOpened, setisFormOpened] = useState(false);

    const handleOpenForm = () => {
        setisFormOpened(true)
    }

    const handleCloseForm = () => {
        setisFormOpened(false)
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

            <div className='news-header'>
                <h2>Tin tức mới nhất về</h2>
                <h1>
                    <strong>"</strong>Đăng kiểm<strong>"</strong>
                </h1>
                <p>
                    Nơi cập nhật các thông tin mới nhất về đăng kiểm ô tô <br /> các lịch thông báo từ phía trung tâm đăng kiểm,
                    cục đăng kiểm.
                </p>
            </div>

            <SearchBar />

            <NewsList newsList={newsList} />
        </div>
    );
}

export default News;