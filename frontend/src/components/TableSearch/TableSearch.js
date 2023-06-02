import React from 'react';
import './TableSearch.css'

function TableSearch({ excelData }) {
    return (
        <div className='search-table-container'>
            <table className='search-table'>
                <thead>
                    <tr>
                        <th>Thứ tự</th>
                        <th>Mã đăng kiểm</th>
                        <th>Họ và tên</th>
                        <th>Biển số xe</th>
                        <th>Trạng thái</th>
                        <th>Ngày đăng kiểm</th>
                        <th>Ngày hết hạn</th>
                        <th>Hoạt động</th>
                    </tr>
                </thead>
                <tbody>
                    {excelData.length ? (
                        excelData.map((info) => (
                            <tr>
                                <td>1</td>
                                <td><a href="#">{info.vehicle_inspection_id}</a></td>
                                <td>{info.name}</td>
                                <td> {info.registration_id} </td>
                                <td>
                                    <p class="status status-unpaid">{info.status}</p>
                                </td>
                                <td>{info.inspection_date}</td>
                                <td> {info.expiry_date} </td>
                                <td>
                                    <i class='bx bx-edit-alt'></i>
                                    <i class='bx bx-trash'></i>
                                </td>
                            </tr>
                        ))
                    ) : <p></p>}
                </tbody>
            </table>
        </div>
    );
}

export default TableSearch;