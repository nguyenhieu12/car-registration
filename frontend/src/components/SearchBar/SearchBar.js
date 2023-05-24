import React from 'react';
import './SearchBar.css';

function SearchBar({ value, clearSearch }) {
  return (
    <div className='searchBar'>
      <input
        type='text'
        placeholder='Tìm kiếm tin tức ...'
      />
      <button>Tìm</button>
    </div>
  );
};

export default SearchBar;
