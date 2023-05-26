import React from 'react';
import './NewsList.css';

function NewsList({ newsList }) {
  return (
    <section className="news-container">
      {newsList && newsList.map((news) => (
        <article>
          <div className="news-wrapper">
            <figure className='news-figure'>
              <img src={news.urlToImage} alt="" />
            </figure>
            <div className="news-body">
              <div>{news.publishedAt}</div>
              <h2>{news.title}</h2>
              <div className='news-description'>{news.description}</div>
            </div>
            <a href="#" className="news-read-more">
              Xem thêm <svg xmlns="http://www.w3.org/2000/svg" className="news-icon" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </a>
          </div>
        </article>
      ))}
    </section>
  );
};

export default NewsList;