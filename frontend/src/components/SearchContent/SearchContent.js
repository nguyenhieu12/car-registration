import React, { useState } from 'react';
import { utils, read } from 'xlsx';
import TableSearch from '../TableSearch/TableSearch';
import './SearchContent.css';
import 'boxicons/css/boxicons.min.css';

function SearchContent(props) {
    const [excelData, setExcelData] = useState([]);
    const file_type = ["application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/vnd.ms-excel"];
    const handleChange = (e) => {
        const selected_file = e.target.files[0];
        if (selected_file) {
            if (selected_file && file_type.includes(selected_file.type)) {
                let reader = new FileReader();
                reader.onload = (e) => {
                    const workbook = read(e.target.result);
                    const sheet = workbook.SheetNames;
                    if (sheet.length) {
                        const data = utils.sheet_to_json(workbook.Sheets[sheet[0]]);
                        setExcelData(data);
                    }
                }
                reader.readAsArrayBuffer(selected_file);
            } else {
                setExcelData([]);
            }
        }
    };

    const [menuVisible, setMenuVisible] = useState(false);

    const toggleMenu = () => {
        setMenuVisible(!menuVisible);
    };

    return (
        <div className='searchContent-container'>
            <div className="app-container">
                <div className="app-content">
                    <div className="app-content-header">
                        <h1 className="app-content-headerText">Tra cứu</h1>
                        <label htmlFor='import-excel' className='app-content-headerButton'>Nhập dữ liệu</label>
                        <input type='file' id='import-excel' onChange={handleChange} style={{ 'display': 'none' }} />
                    </div>
                    <div className="app-content-actions">
                        <div className="search-box">
                            <i class='bx bx-search'></i>
                            <input type="text" placeholder="Search" />
                        </div>
                        <div className="app-content-actions-wrapper">
                            <div className="filter-button-wrapper">
                                <button className="action-button filter" onClick={toggleMenu}>
                                    <i class='bx bx-filter-alt' ></i>
                                    <span className='filter-text'>Filter</span>
                                </button>
                                <div className={`filter-menu ${menuVisible ? 'active' : ''}`}>
                                    <label>Cột</label>
                                    <select>
                                        <option>Tất cả</option>
                                        <option>Tên</option>
                                        <option>Mã đăng kiểm</option>
                                        <option>Biển số xe</option>
                                    </select>
                                    <label>Trạng thái</label>
                                    <select>
                                        <option>Tất cả</option>
                                        <option>Hoàn thành</option>
                                        <option>Chưa hoàn thành</option>
                                    </select>
                                    <div className="filter-menu-buttons">
                                        <button className="filter-button reset">Reset</button>
                                        <button className="filter-button apply">Apply</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <TableSearch excelData={excelData} />
                </div>
            </div>
        </div>
    );
}

export default SearchContent;